import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/db_provider.dart';

import 'package:qr_reader/providers/ui_provider.dart';

import 'package:qr_reader/widgets/custom_navigator_bar.dart';
import 'package:qr_reader/widgets/scan_button.dart';
import 'package:qr_reader/screens/direcciones.dart';
import 'package:qr_reader/screens/historial_mapas.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(icon: Icon(Icons.delete_forever), onPressed: () {})
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButtom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* Obtener El SelectedMenuOpt(Provider) */
    final uiProvider = Provider.of<UiProvider>(context);

    /* Cambiar Para Mostrar La Página Respectiva */
    final currentIndex = uiProvider.selectedMenuOpt;

    /* TODO: Temporal Leer La Base De Datos */
    // DBProvider.db.database;
    final tempScan = new ScanModel(valor: 'https://google.com');
    final intTemp = DBProvider.db.nuevoScan(tempScan);
    print(intTemp);

    switch (currentIndex) {
      case 0:
        return HistorialMapasPage();

      case 1:
        return DireccionesPage();

        break;
      default:
        return HistorialMapasPage();
    }
  }
}
