import 'dart:developer';

import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/models/local_model_class/local_model_class.dart';
import '../../../domain/models/remote_model_class/remote_model_class.dart';
import '../../repositories/repositories.dart';

class DataBaseFunctions {
  Database? _db;
  int loadItemLimit = 5;
  Future<void> initDataBase() async {
    try {
      _db = await openDatabase(
        'details.db',
        version: 1,
        onCreate: (db, version) async {
          db.execute(
              'CREATE TABLE details (id INTEGER PRIMARY KEY, name TEXT, email TEXT, body TEXT)');
        },
      );
    } catch (e) {
      Get.snackbar('something went wrong', e.toString());
    }
  }

  Future<void> addDetails() async {
    try {
      if (_db == null) {
        await initDataBase();
      }
      final int count =
          await _db!.query('details').then((results) => results.length);
      if (count == 0) {
        List<RemoteModelClass> dataList = await ApiFunctions().getData();

        for (var element in dataList) {
          await _db!.rawInsert(
              'INSERT INTO details (name,email,body) VALUES (?,?,?)',
              [element.name, element.email, element.body]);
        }
      }
    } catch (e) {
      Get.snackbar('something went wrong', e.toString());

      throw Exception();
    }
  }



  Future<List<LocalModelClass>> getLimitedData(int count) async {
    try {
      await addDetails();
      List<LocalModelClass> limitedItemsList =
          await getDataInRange(count * loadItemLimit);
      // List<LocalModelClass> limitedItemsList = [];
      // for (int i = (count * loadItemLimit);
      //     i < (count * loadItemLimit + loadItemLimit);
      //     i++) {
      //   if (i < allItemsList.length) {
      //     limitedItemsList.add(allItemsList[i]);
      //   } else {
      //     break;
      //   }
      // }
      await Future.delayed(Duration(seconds: 3));
      return limitedItemsList;
    } catch (e) {
      Get.snackbar('something went wrong', e.toString());

      throw Exception();
    }
  }

  Future<List<LocalModelClass>> getDataInRange(int startId) async {
    try {
      List<LocalModelClass> localModelClass = [];

      final List<Map<String, Object?>> values = await _db!.rawQuery(
          'SELECT * FROM details WHERE id BETWEEN $startId AND ${startId + loadItemLimit}');

      for (var map in values) {
        final LocalModelClass details = LocalModelClass.fromMap(map);

        localModelClass.add(details);
      }
      return localModelClass;
    } catch (e) {
      Get.snackbar('something went wrong', e.toString());

      throw Exception();
    }
  }
    // Future<List<LocalModelClass>> getAllData() async {
  //   try {
  //     List<LocalModelClass> localModelClass = [];

  //     final List<Map<String, Object?>> values =
  //         await _db!.rawQuery('SELECT * FROM details');

  //     for (var map in values) {
  //       final LocalModelClass details = LocalModelClass.fromMap(map);

  //       localModelClass.add(details);
  //     }
  //     return localModelClass;
  //   } catch (e) {
  //     Get.snackbar('something went wrong', e.toString());

  //     throw Exception();
  //   }
  // }
}
