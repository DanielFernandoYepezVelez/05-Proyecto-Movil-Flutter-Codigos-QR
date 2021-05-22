import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  /* Esta Es La Propiedad Que Yo Le Voy A Compartir A Toda Mi Aplicación
  * Para Saber Cual Tap Se Esta Oprimiendo Y De Acuerdo A Eso, Mostrar
  * La Pantalla Respectiva */
  int _selectedMenuOpt = 0;

  /* Cambio Esta Propiedad Privada Mediante GETTERS y SETTERS */
  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  /* Cuando Yo Cambie O Establezca Un Nuevo Valor A Esta Propiedad,
  * Es Cuando Se Va A Ejecutar Un Codigo Especial */
  set selectedMenuOpt(int i) {
    this._selectedMenuOpt = i;
    notifyListeners();
  }
}
