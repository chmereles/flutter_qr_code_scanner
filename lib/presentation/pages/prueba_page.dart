import 'package:flutter/material.dart';

class PruebaPage extends StatelessWidget {
  const PruebaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina de prueba'),
      ),
      body: Card(
        child: Text(
            'https://www.afip.gob.ar/fe/qr/?p=eycndmVyJyc6MSwnJ2ZlY2hhJyc6JycyMDIxLTA1LTEwJycsJydjdWl0Jyc6MzA2ODU4ODkzOTcsJydwdG9WdGEnJzowMDMxLCcndGlwb0NtcCcnOjA2LCcnbnJvQ21wJyc6OTMyNzgyNzMsJydpbXBvcnRlJyc6NDU0NSwnJ21vbmVkYScnOicnUEVTJycsJydjdHonJzoxLCcndGlwb0RvY1JlYycnOiwnJ25yb0RvY1JlYycnOiwnJ3RpcG9Db2RBdXQnJzonJ0InJywnJ2NvZEF1dCcnOjcxMTk3OTc4NTQyMTk4fQ=='),
      ),
    );
  }
}
