import 'package:flutter/material.dart';
import 'package:qr_code_scanner/domain/entities/qr_code.dart';
import 'package:qr_code_scanner/presentation/code_reader/cubit/code_reader_cubit.dart';
import 'package:qr_code_scanner/presentation/pages/qrcode_viewer_page.dart';
import 'package:qr_code_scanner/presentation/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QRCodeResultPage extends StatelessWidget {
  const QRCodeResultPage({Key? key, required this.code}) : super(key: key);

  final QrCode code;

  final radio = 30.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(code.type.title),
        iconTheme: IconThemeData(),
        textTheme: Theme.of(context).textTheme,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<CodeReaderCubit>().start();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Card
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Card(
                          // color: Colors.amber,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(22, 30, 22, 10),
                            child: Column(
                              children: [
                                // result
                                // TODO: armar un widget para cada tipo de codigo
                                Text(
                                  code.codeValue,
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 20),

                                //button
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.qr_code,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      textStyle: TextStyle(fontSize: 16),
                                    ),
                                    label: Text(
                                      'BUSCAR EN GOOGLE',
                                    ),
                                  ),
                                ),

                                //
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.copy,
                                      ),
                                      label: Text(
                                        'Copiar',
                                      ),
                                    ),
                                    TextButton.icon(
                                      onPressed: () {},
                                      icon: Icon(Icons.share),
                                      label: Text(
                                        'Compartir',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // ),

                      // circulo superior
                      Positioned(
                        top: 0,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: SizedBox(
                            height: radio * 2,
                            width: radio * 2,
                            child: Icon(getIconData(code.type.iconType)),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // boton copiar
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QRCodeViewerPage(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.qr_code,
                    ),
                    label: Text(
                      'Ver código (Código QR)',
                    ),
                  ),

                  //boton agregar notas
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                    ),
                    label: Text(
                      'Agregar Notas',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        // color: Colors.amber,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Personalizar color'),
              Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    color: Colors.green,
                  ),
                  Icon(
                    Icons.color_lens,
                    color: Colors.amber,
                  ),
                  Icon(
                    Icons.color_lens,
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
