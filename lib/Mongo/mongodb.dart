import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:fireter/Mongo/mongovars.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    var collection = db.collection(COLLECTION_NAME);
    data = await collection.find().toList();
    print(data);
  }

  static push(
      var location, var faculty, var grade, var alert, var details) async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION_NAME);
    await collection.insertMany([
      {
        "faculty": faculty,
        "location": location,
        "grade": grade,
        "alert": alert,
        "details": details
      }
    ]);
  }

  static fetch() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection(COLLECTION_NAME);
    data = await collection.find().toList();
  }
}
