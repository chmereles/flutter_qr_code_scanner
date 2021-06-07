import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qr_code_scanner/presentation/code_reader/cubit/code_reader_cubit.dart';

/// Debe haber obtenido los permisos pertinentes antes de su uso.
/// Relevant privileges must be obtained before use
class CodeReaderView extends StatefulWidget {
  final Widget? headerWidget;
  // final Future Function(String) onScan;
  final double scanBoxRatio;
  final Color boxLineColor;
  final Widget? helpWidget;

  CodeReaderView({
    // required this.onScan,
    required this.headerWidget,
    this.helpWidget,
    this.boxLineColor = Colors.cyanAccent,
    this.scanBoxRatio = 0.85,
  });

  @override
  CodeReaderViewState createState() => new CodeReaderViewState();
}

/// Operaciones de seguimiento después de escanear el código
/// ```dart
/// GlobalKey<QrcodeReaderViewState> qrViewKey = GlobalKey();
/// qrViewKey.currentState.startScan();
/// ```
class CodeReaderViewState extends State<CodeReaderView>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //
  // QrReaderViewController? _controller;
  AnimationController? _animationController;
  bool openFlashlight = false;
  Timer? _timer;
  bool _init = false;
  bool _showScanView = false;
  bool _showPermission = true;

  // Si necesita abrir la página de configuración de la APLICACIÓN para
  //obtener autorización, use este método para obtener el estado del permiso
  Completer<bool>? permissionCompleter;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    showScanView();
  }

  Future showScanView() async {
    if (true == await permission()) {
      await Future.delayed(Duration(milliseconds: 300));
      setState(() {
        _init = true;
        _showPermission = false;
        _showScanView = true;
      });
    } else {
      setState(() {
        _init = true;
        _showScanView = false;
        _showPermission = true;
      });
    }
  }

  Future<bool> permission() async {
    final status = await Permission.camera.status;
    return status.isGranted;
  }

  void requestPermission() async {
    final ok = await _requestPermission();
    if (ok) {
      showScanView();
    }
  }

  Future<bool> _requestPermission() async {
    var status = await Permission.camera.status;
    if (status.isRestricted || status.isPermanentlyDenied) {
      openAppSettings();
      permissionCompleter = Completer<bool>();
      return permissionCompleter!.future;
    } else if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    return status.isGranted;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && permissionCompleter != null) {
      permissionCompleter!.complete(await permission());
    }
  }

  void _initAnimation() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animationController!
      ..addListener(_upState)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          _timer = Timer(Duration(seconds: 1), () {
            _animationController?.reverse(from: 1.0);
          });
        } else if (state == AnimationStatus.dismissed) {
          _timer = Timer(Duration(seconds: 1), () {
            _animationController?.forward(from: 0.0);
          });
        }
      });
    _animationController!.forward(from: 0.0);
  }

  void _clearAnimation() {
    _timer?.cancel();
    if (_animationController != null) {
      _animationController?.dispose();
      _animationController = null;
    }
  }

  void _upState() {
    setState(() {});
  }

  void _onCreateController(QrReaderViewController controller) async {
    // _controller = controller;
    // startScan();

    context.read<CodeReaderCubit>().onCreateController(controller);
  }

  bool isScan = false;

  Future _onQrBack(data, _) async {
    if (isScan == true) return;
    isScan = true;
    stopScan();
    // await widget.onScan(data);
    context.read<CodeReaderCubit>().codeScanned(data);
  }

  void startScan() async {
    isScan = false;
    // await _controller?.startCamera(_onQrBack);
    _initAnimation();
  }

  void stopScan() {
    // _controller?.stopCamera();
    _clearAnimation();
  }

  Future<bool> setFlashlight() async {
    // openFlashlight = await _controller?.setFlashlight() ?? false;
    setState(() {});
    return openFlashlight;
  }

  Future _scanImage() async {
    /*
    stopScan();
    // var image = await ImagePicker().getImage(source: ImageSource.gallery);
    // if (image == null) {
    //   startScan();
    //   return;
    // }
    // final rest = await FlutterQrReader.imgScan(image.path);
    final rest =
        // await Future.value('WIFI:S:Zhone_DB01;T:WPA;P:znid311655937;H:false;');
        // await Future.value('tel:3834684050');
        await Future.value('begin:vcalendar');
    // await widget.onScan(rest);
    context.read<CodeReaderCubit>().codeScanned(rest);
    // startScan();
  */
    context.read<CodeReaderCubit>().scanImage();
  }

  @override
  Widget build(BuildContext context) {
    // Si no esta iniciado, mostrar pantalla negra
    if (_init == false) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
      );
    }
    // Mostrar los permisos??
    if (_showPermission) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   child: Text(
              //     "Recordatorio de permiso",
              //     style: TextStyle(
              //       fontSize: 36,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              // SizedBox(height: 36),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Permisos necesarios para el funcionamiento de la función',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "Acceso a la cámara",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  "El programa de código de escaneo debe usar la cámara para completar el reconocimiento del código de escaneo en tiempo real"),
                        ],
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 36),
                    Text(
                      'Se requiere permiso para el reconocimiento de álbumes de fotos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text:
                                  "Leer y escribir permisos de almacenamiento del teléfono:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  "Seleccione cualquier imagen para identificar el código QR en la imagen; este permiso le pedirá que solicite este permiso cuando lo use activamente"),
                        ],
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 120),
              TextButton(
                onPressed: requestPermission,
                child: Text(
                  'La operación autorizada debe tener permisos',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green[900]),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Si todo ok, mostrar pantalla de scanner
    return Material(
      color: Colors.black,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final qrScanSize = constraints.maxWidth * widget.scanBoxRatio;
          // final mediaQuery = MediaQuery.of(context);
          if (constraints.maxHeight < qrScanSize * 1.5) {
            print(
              "La relación entre la altura recomendada y la altura del área de escaneo es superior a 1,5",
            );
          }

          //
          return Stack(
            children: <Widget>[
              // QR Reader View
              SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: _showScanView
                    ? QrReaderView(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        callback: _onCreateController,
                        // callback: widget.callback,
                      )
                    : Container(),
              ),

              // Header (opcioneal)
              if (widget.headerWidget != null) widget.headerWidget!,

              // QR Cuadro scanner
              Positioned(
                left: (constraints.maxWidth - qrScanSize) / 2,
                top: (constraints.maxHeight - qrScanSize) * 0.333333,
                child: CustomPaint(
                  painter: QrScanBoxPainter(
                    boxLineColor: widget.boxLineColor,
                    animationValue: _animationController?.value ?? 0,
                    // animationValue: 0,
                    isForward:
                        _animationController?.status == AnimationStatus.forward,
                  ),
                  child: SizedBox(
                    width: qrScanSize,
                    height: qrScanSize,
                  ),
                ),
              ),

              Positioned(
                top: (constraints.maxHeight - qrScanSize) * 0.333333 +
                    qrScanSize +
                    50,
                width: constraints.maxWidth,
                child: Align(
                  alignment: Alignment.center,
                  child: ZoomSliderWidget(),
                ),
              ),

              Positioned(
                //TODO centrar la barra de herramientas
                top: (constraints.maxHeight - qrScanSize) * 0.333333 +
                    qrScanSize +
                    110,
                width: constraints.maxWidth,
                child: Align(
                  alignment: Alignment.center,
                  child: QRToolBarWidget(
                    onFlashLigthTap: setFlashlight,
                    onImageTap: _scanImage,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _clearAnimation();
    super.dispose();
  }
}

class QrScanBoxPainter extends CustomPainter {
  final double animationValue;
  final bool isForward;
  final Color boxLineColor;

  QrScanBoxPainter(
      {required this.animationValue,
      required this.isForward,
      required this.boxLineColor});

  @override
  void paint(Canvas canvas, Size size) {
    final borderRadius = BorderRadius.all(Radius.circular(12)).toRRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );
    canvas.drawRRect(
      borderRadius,
      Paint()
        ..color = Colors.white54
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final path = new Path();
    // leftTop
    path.moveTo(0, 50);
    path.lineTo(0, 12);
    path.quadraticBezierTo(0, 0, 12, 0);
    path.lineTo(50, 0);
    // rightTop
    path.moveTo(size.width - 50, 0);
    path.lineTo(size.width - 12, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 12);
    path.lineTo(size.width, 50);
    // rightBottom
    path.moveTo(size.width, size.height - 50);
    path.lineTo(size.width, size.height - 12);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 12, size.height);
    path.lineTo(size.width - 50, size.height);
    // leftBottom
    path.moveTo(50, size.height);
    path.lineTo(12, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 12);
    path.lineTo(0, size.height - 50);

    canvas.drawPath(path, borderPaint);

    canvas.clipRRect(
        BorderRadius.all(Radius.circular(12)).toRRect(Offset.zero & size));

    // Dibujar cuadrícula horizontal
    final linePaint = Paint();
    final lineSize = size.height * 0.45;
    final leftPress = (size.height + lineSize) * animationValue - lineSize;
    linePaint.style = PaintingStyle.stroke;
    linePaint.shader = LinearGradient(
      colors: [Colors.transparent, boxLineColor],
      begin: isForward ? Alignment.topCenter : Alignment(0.0, 2.0),
      end: isForward ? Alignment(0.0, 0.5) : Alignment.topCenter,
    ).createShader(Rect.fromLTWH(0, leftPress, size.width, lineSize));
    for (int i = 0; i < size.height / 5; i++) {
      canvas.drawLine(
        Offset(
          i * 5.0,
          leftPress,
        ),
        Offset(i * 5.0, leftPress + lineSize),
        linePaint,
      );
    }
    for (int i = 0; i < lineSize / 5; i++) {
      canvas.drawLine(
        Offset(0, leftPress + i * 5.0),
        Offset(
          size.width,
          leftPress + i * 5.0,
        ),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(QrScanBoxPainter oldDelegate) =>
      animationValue != oldDelegate.animationValue;

  @override
  bool shouldRebuildSemantics(QrScanBoxPainter oldDelegate) =>
      animationValue != oldDelegate.animationValue;
}

class QRToolBarWidget extends StatelessWidget {
  const QRToolBarWidget({
    Key? key,
    required this.onFlashLigthTap,
    required this.onImageTap,
  }) : super(key: key);

  final VoidCallback onFlashLigthTap;
  final VoidCallback onImageTap;

  @override
  Widget build(BuildContext context) {
    //
    final _size = MediaQuery.of(context).size;
    final _toolBarColor = Theme.of(context).primaryColor;
    final _iconColor = Colors.white;
    final _iconSlectedColor = Colors.yellow;
    final _isFlashOn = false;
    final _isMultiScan = false;

    return SizedBox(
      width: _size.width * 0.7,
      child: Material(
        color: _toolBarColor,
        borderRadius: BorderRadius.circular(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.image_outlined,
                color: _iconColor,
              ),
              // onPressed: () {},
              onPressed: onImageTap,
            ),
            IconButton(
              icon: Icon(
                Icons.flash_on,
                color: _isFlashOn ? _iconSlectedColor : _iconColor,
              ),
              onPressed: onFlashLigthTap,
            ),
            IconButton(
              icon: Icon(
                Icons.copy_all_outlined,
                color: _isMultiScan ? _iconSlectedColor : _iconColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class ZoomSliderWidget extends StatefulWidget {
  const ZoomSliderWidget({Key? key}) : super(key: key);

  @override
  _ZoomSliderWidgetState createState() => _ZoomSliderWidgetState();
}

class _ZoomSliderWidgetState extends State<ZoomSliderWidget> {
  var valueSlider = 0.0;
  final sliderStep = 0.05;
  final sliderMin = 0.0;
  final sliderMax = 1.0;

  void changeSlideValue(double step) {
    valueSlider = valueSlider + step;
    //
    if (valueSlider < sliderMin) {
      valueSlider = sliderMin;
    }
    //
    else if (valueSlider > sliderMax) {
      valueSlider = sliderMax;
    }

    setState(() {});
  }

  void incSliderValue() {
    changeSlideValue(sliderStep);
  }

  void decSliderValue() {
    changeSlideValue(sliderStep * -1);
  }

  @override
  Widget build(BuildContext context) {
    //
    final size = MediaQuery.of(context).size;
    final _iconColor = Colors.white;
    final _color = Theme.of(context).primaryColor;
    final _inactivColor = Colors.grey[400];

    return
        // Align(
        //   alignment: Alignment(0, 0.7),
        //   child:
        Container(
      // width: size.width * 0.9,
      height: 50,
      // color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icono menos
          GestureDetector(
            onTap: decSliderValue,
            child: Icon(
              Icons.remove,
              color: _iconColor,
            ),
          ),

          // Slider
          SizedBox(
            width: size.width * 0.7,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.0),
              ),
              child: Slider(
                min: sliderMin,
                max: sliderMax,
                value: valueSlider,
                inactiveColor: _inactivColor,
                activeColor: _color,
                onChanged: (double value) {
                  print(value);
                  setState(() {
                    valueSlider = value;
                  });
                },
              ),
            ),
          ),

          // Icono mas
          GestureDetector(
            onTap: incSliderValue,
            child: Icon(
              Icons.add,
              color: _iconColor,
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
