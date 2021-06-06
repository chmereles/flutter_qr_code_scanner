import 'package:flutter/material.dart';
import 'package:qr_code_scanner/presentation/qrcode_widget/qr_reader_main_page.dart';

class QRScannerWidget extends StatelessWidget {
  const QRScannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: QrRaderMainPage(),
          // child: Container(
          //   color: Colors.grey,
          // ),

          //   child: QrcodeReaderView(
          //     headerWidget: null,
          //     scanBoxRatio: 0.85,
          //     onScan: (String result) async {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => QRCodeResultPage(codeResult: result),
          //         ),
          //       );
          //     },
          //   ),
          //
        ),

        //ZoomSliderWidget(),
        //QRToolBarWidget(),
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
