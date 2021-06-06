import 'package:flutter/material.dart';
import 'package:qr_code_scanner/buttons/custom_button_icon_widget.dart';

class QRCodeGenerar extends StatelessWidget {
  const QRCodeGenerar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generar codigo QR'),
        iconTheme: IconThemeData(),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Historial
                  ReusableCard(
                    // onTap: null,
                    cardChild: Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.text_fields_outlined,
                                  size: 35,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'lorem',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 5,
                          color: Colors.grey,
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.history),
                          label: Text('VER TODO EL HISTORIAL'),
                        ),
                      ],
                    ),
                  ),

                  // Portapapeles
                  CustomButtonIconWidget(
                    title: 'Contenido del portapapeles',
                    subtitle: 'valor en el portapapeles',
                    iconData: Icons.content_copy_outlined,
                    iconColor: Theme.of(context).primaryColor,
                    onTap: () {
                      print('Generar: contenido portapapeles');
                    },
                  ),

                  // Generador
                  Column(
                    children: [
                      // Sitio web - Texto
                      Row(
                        children: [
                          ReusableGenerator(
                            text: 'Sitio web',
                            icon: Icons.link,
                            onTap: () {},
                          ),
                          SizedBox(width: 10.0),
                          ReusableGenerator(
                            text: 'Texto',
                            icon: Icons.text_fields,
                            onTap: () {},
                          ),
                        ],
                      ),
                      // Wifi - Evento
                      Row(
                        children: [
                          ReusableGenerator(
                            text: 'Wifi',
                            icon: Icons.wifi_outlined,
                            onTap: () {},
                          ),
                          SizedBox(width: 10.0),
                          ReusableGenerator(
                            text: 'Evento',
                            icon: Icons.event_outlined,
                            onTap: () {},
                          ),
                        ],
                      ),
                      //
                      Row(
                        children: [
                          ReusableGenerator(
                            text: 'Contacto',
                            icon: Icons.contact_phone_outlined,
                            onTap: () {},
                          ),
                          SizedBox(width: 10.0),
                          ReusableGenerator(
                            text: 'Email',
                            icon: Icons.event_outlined,
                            onTap: () {},
                          ),
                        ],
                      ),
                      //
                      Row(
                        children: [
                          ReusableGenerator(
                            text: 'Telefono',
                            icon: Icons.phone_outlined,
                            onTap: () {},
                          ),
                          SizedBox(width: 10.0),
                          ReusableGenerator(
                            text: 'SMS',
                            icon: Icons.sms_outlined,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Info
                  ReusableCard(
                    onTap: () {},
                    cardChild: Container(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.share,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text('Contenido del portapapeles'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReusableGenerator extends StatelessWidget {
  const ReusableGenerator(
      {Key? key, required this.text, required this.icon, required this.onTap})
      : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ReusableCard(
        onTap: () {},
        cardChild: SizedBox(
          height: 55,
          child: Column(
            children: [
              Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 35,
              ),
              Text(
                text,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard({
    required this.cardChild,
    this.onTap,
    this.colour,
  });

  final Widget cardChild;
  final VoidCallback? onTap;
  final Color? colour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            child: cardChild,
          ),
        ),
        // color: Colors.amber,
      ),
    );
  }
}
