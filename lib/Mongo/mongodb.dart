import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:fireter/Mongo/mongovars.dart';

class MongoDatabase {
  static connect() async {
    try {
      var db = await Db.create(MONGO_URL);
      await db.open();
      inspect(db);
      var status = db.serverStatus();
      var collection = db.collection(COLLECTION_NAME);
      data = await collection.find().toList();
    } catch (e) {
      var db = await Db.create(MONGO_URL);
      await db.open();
      inspect(db);
      var status = db.serverStatus();
      var collection = db.collection(COLLECTION_NAME);
      data = await collection.find().toList();
    }
  }

  static push(var location, var faculty, var grade, var alert, var details,
      var nam) async {
    try {
      var db = await Db.create(MONGO_URL);
      await db.open();
      var collection = db.collection(COLLECTION_NAME);
      await collection.insertMany([
        {
          "faculty": faculty,
          "location": location,
          "grade": grade,
          "alert": alert,
          "details": details,
          "name": nam
        }
      ]);
    } catch (e) {}
  }

  static remov(id) async {
    try {
      var db = await Db.create(MONGO_URL);
      await db.open();
      var collection = db.collection(COLLECTION_NAME);
      await collection.remove({'_id': id});
    } catch (e) {
      print("$e");
    }
  }

  static fetch() async {
    try {
      var db = await Db.create(MONGO_URL);
      await db.open();
      var collection = db.collection(COLLECTION_NAME);
      data = await collection.find().toList();
    } catch (e) {
      print("$e");
    }
  }
}
