import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
 import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DbConnection{

  static final DbConnection _singleton = DbConnection();


  static DbConnection get instance => _singleton;

  // Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database> _dbOpenCompleter;

  // A private constructor. Allows us to create instances of DbConnection
  // only from within the DbConnection class itself.
  DbConnection();

  // Database object accessor
  Future<Database> get database async {
     if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      // Calling _openDatabase will also complete the completer with database instance
      _openDatabase();
    }
    // If the database is already opened, awaiting the future will happen instantly.
    // Otherwise, awaiting the returned future will take some time - until complete() is called
    // on the Completer in _openDatabase() below.
    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    // Get a platform-specific directory where persistent app data can be stored
    final appDocumentDir = await getApplicationDocumentsDirectory();
    // Path with the form: /platform-specific-directory/demo.db
    final dbPath = join(appDocumentDir.path, 'StudentsDB.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);


    // Any code awaiting the Completer's future will now start executing
    _dbOpenCompleter.complete(database);
  }
}