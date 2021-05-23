import 'package:flutter/material.dart';

import 'package:qr_reader/widgets/scan_titles.dart';

class DireccionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScanTitles(tipo: 'http');
  }
}
