import 'dart:convert';
import 'dart:typed_data';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';

import 'package:barcode_image/barcode_image.dart';
import 'package:image/image.dart' as myImage;
import 'package:qr_code_scanner/presentation/buttons/custom_button_widget.dart';

class QRCodeViewerPage extends StatelessWidget {
  QRCodeViewerPage({Key? key}) : super(key: key);

  void generateCode() async {
    // final dm = Barcode.qrCode();

    // final me = MeCard.wifi(
    //   ssid: 'Wifi Name',
    //   password: 'password',
    // );

    // Generate a SVG with a barcode that configures the wifi access
    // final svg = dm.toSvg(me.toString(), width: 200, height: 200);
    // final bytes = dm.t

    // Save the image
    // await File('wifi.svg').writeAsString(svg);
  }

  @override
  Widget build(BuildContext context) {
    final me = MeCard.wifi(
      ssid: 'Wifi Name',
      password: 'password',
    );

    final image = myImage.Image(600, 600);
    // // Fill it with a solid color (white)
    myImage.fill(image, myImage.getColor(255, 255, 255));
    drawBarcode(image, Barcode.qrCode(), me.toString(), font: myImage.arial_24);
    final pngImage = myImage.encodePng(image);
    Uint8List _image = base64Decode(base64.encode(pngImage));

    return Scaffold(
      // backgroundColor: Colors.amber,
      appBar: AppBar(
        iconTheme: IconThemeData(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // QR Code
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                    child: Card(
                      color: Colors.white,
                      // elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Image.memory(
                          _image,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),

                  // Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonViewer(
                        icon: Icons.file_download_outlined,
                        text: 'GUARDAR EN EL DISPOSITIVO',
                        onTap: () {},
                      ),
                      ButtonViewer(
                        text: 'COMPARTIR',
                        icon: Icons.share_outlined,
                        onTap: () {},
                      ),
                      // ButtonViewer(),
                    ],
                  ),

                  // Tipo de codigo
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.link),
                            Text('Sitio web'),
                          ],
                        ),
                        // Separador
                        Divider(
                          height: 2,
                        ),
                        SizedBox(height: 15),

                        // Contenido
                        Center(
                          child: Text(
                            'contenido contenido contenido conteido ' +
                                'contenid contenido contenido contenido ' +
                                'contenid contenido contenido contenido ' +
                                'contenid contenido contenido contenido ',
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonViewer extends StatelessWidget {
  const ButtonViewer(
      {Key? key, required this.icon, required this.text, required this.onTap})
      : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomButtonWidget(
        color: Theme.of(context).primaryColor,
        cardChild: Column(
          children: [
            Icon(
              icon,
              size: 35,
            ),
            Text(
              text,
              style: TextStyle(),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
