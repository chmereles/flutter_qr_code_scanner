import 'package:flutter/material.dart';
import 'package:qr_code_scanner/pages/qrcode_generar.dart';
import 'package:qr_code_scanner/pages/qrcode_result.dart';
import 'package:qr_code_scanner/widgtes/qrcode_reader_view.dart';

class QRScannerWidget extends StatelessWidget {
  const QRScannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Container(
            color: Colors.grey,
          ),
          // child: QrcodeReaderView(
          //   headerWidget: null,
          //   scanBoxRatio: 0.85,
          //   onScan: (String result) async {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => QRCodeResultPage(codeResult: result),
          //       ),
          //     );
          //   },
          // ),
        ),
        ZoomSliderWidget(),
        QRToolBarWidget(),
      ],
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

    return Align(
      alignment: Alignment(0, 0.7),
      child: Container(
        width: size.width * 0.9,
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
      ),
    );
  }
}

class QRToolBarWidget extends StatelessWidget {
  const QRToolBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final _size = MediaQuery.of(context).size;
    final _toolBarColor = Theme.of(context).primaryColor;
    final _iconColor = Colors.white;
    final _iconSlectedColor = Colors.yellow;
    final _isFlashOn = false;
    final _isMultiScan = false;

    return Align(
      alignment: Alignment(0, 0.9),
      child: SizedBox(
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRCodeGenerar(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.flash_on,
                  color: _isFlashOn ? _iconSlectedColor : _iconColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRCodeResultPage(
                          // codeResult: 'dafadf',
                          codeResult:
                              'https://www.afip.gob.ar/fe/qr/?p=eycndmVyJyc6MSwnJ2ZlY2hhJyc6JycyMDIxLTA1LTEwJycsJydjdWl0Jyc6MzA2ODU4ODkzOTcsJydwdG9WdGEnJzowMDMxLCcndGlwb0NtcCcnOjA2LCcnbnJvQ21wJyc6OTMyNzgyNzMsJydpbXBvcnRlJyc6NDU0NSwnJ21vbmVkYScnOicnUEVTJycsJydjdHonJzoxLCcndGlwb0RvY1JlYycnOiwnJ25yb0RvY1JlYycnOiwnJ3RpcG9Db2RBdXQnJzonJ0InJywnJ2NvZEF1dCcnOjcxMTk3OTc4NTQyMTk4fQ== https://www.afip.gob.ar/fe/qr/?p=eycndmVyJyc6MSwnJ2ZlY2hhJyc6JycyMDIxLTA1LTEwJycsJydjdWl0Jyc6MzA2ODU4ODkzOTcsJydwdG9WdGEnJzowMDMxLCcndGlwb0NtcCcnOjA2LCcnbnJvQ21wJyc6OTMyNzgyNzMsJydpbXBvcnRlJyc6NDU0NSwnJ21vbmVkYScnOicnUEVTJycsJydjdHonJzoxLCcndGlwb0RvY1JlYycnOiwnJ25yb0RvY1JlYycnOiwnJ3RpcG9Db2RBdXQnJzonJ0InJywnJ2NvZEF1dCcnOjcxMTk3OTc4NTQyMTk4fQ=='),
                    ),
                  );
                },
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
          //),
        ),
      ),
    );
  }
}
