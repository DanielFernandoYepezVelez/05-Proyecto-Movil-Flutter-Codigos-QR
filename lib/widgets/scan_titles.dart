import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/providers/scan_list.dart';

import 'package:qr_reader/utils/url_launch.dart';

class ScanTitles extends StatelessWidget {
  final String tipo;

  ScanTitles({@required this.tipo});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, i) => Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.deepPurple,
          ),
          onDismissed: (direction) {
            Provider.of<ScanListProvider>(context, listen: false).borrarScanId(scans[i].id);
          },
          child: ListTile(
            leading: Icon(
              (this.tipo == 'http') ? Icons.home_outlined : Icons.map,
              color: Theme.of(context).primaryColor
            ),
            title: Text(scans[i].valor),
            subtitle: Text(scans[i].id.toString()),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
            onTap: () => launchURL(context, scans[i]),
          ),
        )
    );
  }
}
