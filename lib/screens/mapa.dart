import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:qr_reader/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    /* Recibo Los Argumentos Del PushName() */
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17.5,
      tilt: 50
    );

    /* Marcadores (Punto Rojo En Mi Dirección) */
    Set<Marker> markers = new Set<Marker>();
    markers.add(
        Marker(
            markerId: MarkerId('geo-location'),
            position: scan.getLatLng()
        )
    );

    return Scaffold(
      appBar: AppBar(
          title: Text('Mapa'),
        actions: [
          /* Boton Para LLegar Nuevamente Al Pin, En Caso Tal De Alejarme Mucho */
          IconButton(icon: Icon(Icons.location_disabled), onPressed: () async {
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(
                CameraUpdate.newCameraPosition(
                    CameraPosition(target: scan.getLatLng(), zoom: 17.5, tilt: 50)
                )
            );
          })
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: this.mapType,
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          setState(() {
            if (this.mapType == MapType.normal) {
              this.mapType = MapType.satellite;
            } else {
              this.mapType = MapType.normal;
            }
          });
        },
      ),
    );
  }
}