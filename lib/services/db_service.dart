import 'package:mongo_dart/mongo_dart.dart';

class DbService {
  static Db db = Db('mongodb://localhost:27017/your_database_name');

  static Future<DbCollection> getCollection(String collection) async {
    if (!db.isConnected) {
      await db.open();
    }

    return db.collection(collection);
  }
}
