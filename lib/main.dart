import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/providers/scan_list.dart';

import 'package:qr_reader/screens/home.dart';
import 'package:qr_reader/screens/mapa.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
          'mapa': (_) => MapaPage()
        },
        theme: ThemeData(
            primaryColor: Colors.deepPurple,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepPurple
           )
        ),
      ),
    );
  }
}
