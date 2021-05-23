import 'package:flutter/cupertino.dart';

/* El Scan Model Viene De db_provider, Por Que Alli Fue Donde Lo Exporte (export) */
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  /* Estos Métodos Interactuan Con La Interface De Usuario, Dependiendo De Lo
  * Que Pase En La Base De Datos */

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = new ScanModel(valor: valor);

    /* Inserto El Scan En La Base De Datos */
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    /* Asignar El Id De La Base De Datos Al Modelo */
    nuevoScan.id = id;

    /* Aquí Se Va A Renderizar El Scan, Ya Sea Geolocalización O Web */
    if (this.tipoSeleccionado == nuevoScan.tipo) {
      this.scans.add(nuevoScan);
      notifyListeners();
    }

    return nuevoScan;
  }

  cargarScans() async {
    final scans = await DBProvider.db.getTodosScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScansTipo(String tipo) async {
    final scans = await DBProvider.db.getScansTipo(tipo);
    this.scans = [...scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScan();
    this.scans = [];
    notifyListeners();
  }

  borrarScanId(int id) async {
    await DBProvider.db.deleteScan(id);
    //this.cargarScansTipo(this.tipoSeleccionado);
  }
}