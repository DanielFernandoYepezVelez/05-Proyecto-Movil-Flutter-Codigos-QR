import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path_provider/path_provider.dart';

import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';

/* Patron Singleton, Para Que Me Funcione En Toda
  La Aplicación La Misma Instancia De Esta Clase
  De Base De Datos En Cualquier Parte Que Se
  Cree Dicha Instancia */
class DBProvider {
  static Database _database;

  /* Este Es Un Singleton Con El Constructor De Esta Clase Privado */
  static final DBProvider db = DBProvider._();

  /* Esto Me Ayuda Que Cuando Yo Haga Un New DBProvider Siempre Voy A Tener La Mismas
  Instancias De Esta Clase, Es Deci,  Los Objetos Estan Apuntando A Esta Misma Clase,
  En Conclusión Que Los Objetos Sean Los Mismos */
  DBProvider._();

  /* Aqui Estoy Accediendo A La Propiedad De Esta Clase, Que Anteriormente Se
  Asigno Como Privada */
  Future<Database> get database async {
    /* Si Ya Lo He Instanciado Anteriormente Quiero Que Me Devuelva La Misma Base De Datos */
    if (_database != null) return _database;

    /* Pero Si Por El Contrario, Es La Primera Vez, Me Va A Conectar Y A Entregar Una Base De 
       Datos */
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    /* Path Donde Almacenaremos La Base De Datos */
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');

    print(path);

    /* Crear La Base De Datos */
    /* Se Debe Modificar La Version De La DB, Si Hacemos Cambios Estructurales */
    return await openDatabase(path, version: 2, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE Scans(
        id INTEGER PRIMARY KEY,
        tipo TEXT,
        valor TEXT
      )
    ''');
    });
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    /* Verificar Que La Base De Datos Esta Lista */
    final db = await database;

    final res = await db.rawInsert(''' 
      INSERT INTO Scans(id, tipo, value)
        VALUES($id, $tipo, $valor)
    ''');
    return res;
  }

  nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    print(res);
    return res;
  }
}
