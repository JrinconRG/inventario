import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:sqlite3/wasm.dart';

DatabaseConnection connect() {
  return DatabaseConnection.delayed(
    _openConnection(),
  );
}

Future<DatabaseConnection> _openConnection() async {
  final sqlite3 = await WasmSqlite3.loadFromUrl(Uri.parse('sqlite3.wasm'));
  final fileSystem = await IndexedDbFileSystem.open(dbName: 'lab_inventory');

  sqlite3.registerVirtualFileSystem(fileSystem, makeDefault: true);

  return DatabaseConnection(
    WasmDatabase(
      sqlite3: sqlite3,
      path: 'lab_inventory.sqlite',
    ),
  );
}
