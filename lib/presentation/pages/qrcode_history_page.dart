import 'package:flutter/material.dart';
import 'package:qr_code_scanner/presentation/buttons/custom_button_icon_widget.dart';
import 'package:qr_code_scanner/presentation/code_reader/views/code_result_page.dart';

class QRCodeHistoryPage extends StatelessWidget {
  const QRCodeHistoryPage({Key? key}) : super(key: key);

  final List<String> listDays = const ['Hoy', 'Ayer', 'Lunes'];
  final List<String> listCodes = const [
    'wifi',
    'text',
    'email ñadfjñajdsfdjlkajflkasjfñlkjad'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar en historial'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: listDays.length,
          itemBuilder: (context, index) {
            final day = listDays[index];
            return Column(
              children: [
                DayCardHeader(day: day),
                for (var item in listCodes)
                  CustomButtonIconWidget(
                    // iconColor: Theme.of(context).primaryColor,
                    title: item,
                    subtitle: 'dfadfad',
                    iconData: Icons.wifi_outlined,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => QRCodeResultPage(
                      //         // codeResult: 'dafadf',
                      //         code: 'https://www.afip.gob.ar/fe/d=='),
                      //   ),
                      // );
                    },
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}

class DayCardHeader extends StatelessWidget {
  const DayCardHeader({Key? key, required this.day}) : super(key: key);

  final String day;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        day,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
