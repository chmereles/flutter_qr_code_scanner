import 'package:flutter/material.dart';

import 'package:qr_code_scanner/presentation/pages/qrcode_generar.dart';
import 'package:qr_code_scanner/presentation/pages/qrcode_history_page.dart';
import 'package:qr_code_scanner/presentation/pages/qrcode_result.dart';
import 'package:qr_code_scanner/presentation/pages/qrcode_viewer_page.dart';
import 'package:qr_code_scanner/presentation/qrcode_widget/qrcode_reader_view.dart';

class QrRaderMainPage extends StatefulWidget {
  @override
  _QrRaderMainPageState createState() => _QrRaderMainPageState();
}

class _QrRaderMainPageState extends State<QrRaderMainPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool _showScanView = false;

  late Function myStopScan;
  late Function myStartScan;

  @override
  void initState() {
    super.initState();
  }

  void alert(String tip) {
    ScaffoldMessenger.of(scaffoldKey.currentContext!)
        .showSnackBar(SnackBar(content: Text(tip)));
  }

  void showResultPage(String result) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRCodeResultPage(codeResult: result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title: Text('la'),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _showScanView = !_showScanView;
                });
              },
              icon: Icon(Icons.qr_code),
            ),
            IconButton(
              onPressed: () {
                myStartScan();
                // setState(() {
                //   _showScanView = !_showScanView;
                // });
              },
              icon: Icon(Icons.play_arrow),
            ),
            IconButton(
              onPressed: () {
                myStopScan();
                // setState(() {
                //   _showScanView = !_showScanView;
                // });
              },
              icon: Icon(Icons.stop),
            ),
          ],
        ),
        body: Builder(
          builder: (context) {
            return _showScanView == true
                ?
                //
                QrcodeReaderView(
                    headerWidget: null,
                    stopScan: (fun) {
                      this.myStopScan = fun;
                    },
                    startScan: (fun) {
                      this.myStartScan = fun;
                    },
                    onScan: (String result) async {
                      showResultPage(result);
                    },
                  )
                : Container();
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          //
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          //
          selectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          //
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          // type: BottomNavigationBarType.fixed,
          onTap: (index) {
            if (index == 0) {
              // myStopScan();
              // myStartScan();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QRCodeHistoryPage(),
                ),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QRCodeGenerar(),
                ),
              );
            } else {
              myStopScan();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QRCodeViewerPage(),
                ),
              );
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Historial',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: 'Generar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configuracion',
            ),
          ],
        ),
      ),
    );
  }
}
