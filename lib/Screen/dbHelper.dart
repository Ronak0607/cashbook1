import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Database? db;

  Future<Database> checkDatabase() async {
    if (db != null) {
      return db!;
    } else {
      return await createDatabase();
    }
  }

  Future<Database> createDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String path = join(folder.path, "casebook.db");
    return openDatabase(path, version: 1, onCreate: (db, version) {
      String query =
          "CREAT TABLE customer(cid INTEGER PRIMARI KEY AUTOINCREMENT,name TEXT,mobile TEXT,add TEXT)";
      db.execute(query);
    });
  }

  void datainsert(String n1, String m1, String a1) async {
    db = await checkDatabase();
    db!.insert("customer", {"name": n1, "mobile": m1, "add": a1});
  }

  Future<List<Map>> readData() async {
    db = await checkDatabase();
    String query = "SELECT * FROM std";
    List<Map> customerList = await db!.rawQuery(query, null);

    return customerList;
  }


}
