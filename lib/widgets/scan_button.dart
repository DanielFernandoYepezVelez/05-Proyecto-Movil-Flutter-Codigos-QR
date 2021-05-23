import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:qr_reader/providers/scan_list.dart';

import 'package:qr_reader/utils/url_launch.dart';

// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanButtom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancelar', false, ScanMode.QR);
        //final barcodeScanRes = 'https://danielfernandoyepezvelez.github.io/Portafolio-Proyectos/';
        //final barcodeScanRes = 'geo:6.265901974194184,-75.54951179793287';

         if (barcodeScanRes == -1) {
           return;
         }

        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

        /* Lanzamos Desde El Boton La Web O La Geolización Del QR */
        launchURL(context, nuevoScan);
      },
    );
  }
}