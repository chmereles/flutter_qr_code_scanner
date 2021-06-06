import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/presentation/cubit/qrcode_cubit.dart';
import 'package:qr_code_scanner/presentation/qrcode_widget/qr_reader_main_page.dart';
import 'package:qr_code_scanner/theme_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      // themeMode: ThemeMode.light,
      home: BlocProvider(
        create: (context) => QrcodeCubit(),
        child: QrRaderMainPage(),
      ),
    );
  }
}
