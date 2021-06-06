import 'package:flutter/material.dart';
import 'package:qr_code_scanner/presentation/pages/qrcode_viewer_page.dart';

class QRCodeResultPage extends StatelessWidget {
  const QRCodeResultPage({Key? key, required this.codeResult})
      : super(key: key);

  final String codeResult;

  final radio = 30.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //TODO: completar con el titulo
        title: Text('title'),
        iconTheme: IconThemeData(),
        textTheme: Theme.of(context).textTheme,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                                Text(
                                  codeResult,
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 20),

                                // info adicional
                                Text('info adicional opcional'),
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
                            child: Icon(Icons.text_fields),
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

// class QRCodeResultPage extends StatelessWidget {
//   const QRCodeResultPage({Key? key, required this.codeResult})
//       : super(key: key);

//   final String codeResult;

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final radio = 30.0;
//     //determinar el alto segun lo que haya que mostrar
//     final fracHigthCard = 0.43;

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         title: Text('Texto'),
//         iconTheme: IconThemeData(),
//         textTheme: Theme.of(context).textTheme,
//       ),
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           Positioned(
//             top: radio,
//             height: size.height * fracHigthCard,
//             width: size.width * 0.9,
//             child: Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 children: [
//                   // qr result
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       top: 40,
//                       left: 20,
//                       right: 20,
//                     ),
//                     child: Text(
//                       codeResult,
//                       style: TextStyle(fontSize: 18),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   SizedBox(height: 10),

//                   // info adicional
//                   Text('info adicional opcional'),
//                   SizedBox(height: 20),

//                   // boton
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 20),
//                     child: OutlinedButton.icon(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.qr_code,
//                       ),
//                       style: OutlinedButton.styleFrom(
//                         textStyle: TextStyle(fontSize: 16),
//                       ),
//                       label: Text(
//                         'BUSCAR EN GOOGLE',
//                       ),
//                     ),
//                   ),

//                   //Row(boton, compartir)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       TextButton.icon(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.copy,
//                         ),
//                         label: Text(
//                           'Copiar',
//                         ),
//                       ),
//                       TextButton.icon(
//                         onPressed: () {},
//                         icon: Icon(Icons.share),
//                         label: Text(
//                           'Compartir',
//                         ),
//                       ),
//                     ],
//                   ),
//                   //separador // opcional
//                   Divider(),

//                   //botones //otas opciones
//                   Container(
//                     height: 40,
//                     // color: Colors.red,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 0,
//             child: Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               child: SizedBox(
//                 height: radio * 2,
//                 width: radio * 2,
//                 child: Icon(Icons.text_fields),
//               ),
//             ),
//           ),
//           Positioned(
//             top: radio + size.height * fracHigthCard + 20,
//             child: Column(
//               children: [
//                 TextButton.icon(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.qr_code,
//                   ),
//                   label: Text(
//                     'Ver código (Código QR)',
//                   ),
//                 ),
//                 //
//                 TextButton.icon(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.edit,
//                   ),
//                   label: Text(
//                     'Agregar Notas',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Align(
//           //   alignment: Alignment.bottomLeft,
//           //   child: SizedBox(
//           //     // width: size.width * 0.9,
//           //     child: Text('Personalizar el color'),
//           //   ),
//           // ),
//           // Align(
//           //   alignment: Alignment.bottomRight,
//           //   child: Row(
//           //     children: [
//           //       Icon(
//           //         Icons.color_lens,
//           //         color: Colors.green,
//           //       ),
//           //       Icon(
//           //         Icons.color_lens,
//           //         color: Colors.amber,
//           //       ),
//           //       Icon(
//           //         Icons.color_lens,
//           //         color: Colors.red,
//           //       ),
//           //     ],
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
