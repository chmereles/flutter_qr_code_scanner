import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/presentation/code_reader/cubit/code_reader_cubit.dart';
import 'package:qr_code_scanner/presentation/code_reader/widgets/code_reader_view.dart';

import 'package:qr_code_scanner/presentation/pages/qrcode_generar.dart';
import 'package:qr_code_scanner/presentation/pages/qrcode_history_page.dart';
import 'package:qr_code_scanner/presentation/code_reader/views/code_result_page.dart';
import 'package:qr_code_scanner/presentation/pages/qrcode_viewer_page.dart';

class CodeReaderPage extends StatefulWidget {
  @override
  _CodeReaderPageState createState() => _CodeReaderPageState();
}

class _CodeReaderPageState extends State<CodeReaderPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool _showScanView = false;

  @override
  void initState() {
    super.initState();
  }

  void alert(String tip) {
    ScaffoldMessenger.of(scaffoldKey.currentContext!)
        .showSnackBar(SnackBar(content: Text(tip)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CodeReaderCubit, CodeReaderState>(
      listener: (context, state) {
        //
        if (state is CodeReaderScanned) {
          // print('${state.code}');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QRCodeResultPage(code: state.code),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey,
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                context.read<CodeReaderCubit>().startScan();
              },
              icon: Icon(Icons.play_arrow),
            ),
            IconButton(
              onPressed: () {
                context.read<CodeReaderCubit>().stopScan();
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
                CodeReaderView(
                    headerWidget: null,
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
