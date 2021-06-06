import 'package:flutter/material.dart';
import 'package:qr_code_scanner/pages/qrcode_history_page.dart';
import 'package:qr_code_scanner/pages/qrcode_viewer_page.dart';

import 'package:qr_code_scanner/widgtes/qr_scanner_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentItemIndex = 0;

  final navigationBarColor = Colors.grey[700];

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;

    return Scaffold(
      body: QRScannerWidget(),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12.0,
        unselectedItemColor: iconColor,
        selectedItemColor: iconColor,
        currentIndex: _currentItemIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QRCodeHistoryPage(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QRCodeViewerPage(),
              ),
            );
          }

          // generateCode();
          // setState(() {
          //   _currentItemIndex = index;
          // });
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
    );
  }
}
