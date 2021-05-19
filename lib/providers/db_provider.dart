import 'package:sqflite/sqflite.dart';

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

  Future<Database> initDB() async {}
}
