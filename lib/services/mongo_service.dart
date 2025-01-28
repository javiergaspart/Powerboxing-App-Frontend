import 'package:mongo_dart/mongo_dart.dart';

class MongoService {
  static final String _connectionString = "mongodb+srv://fitboxing_admin:Powerboxing123@cluster0.nrz2j.mongodb.net/powerboxing?retryWrites=true&w=majority";
  late Db _db;

  Future<void> connect() async {
    _db = await Db.create(_connectionString);
    await _db.open();
  }

  Future<List<Map<String, dynamic>>> getSessions() async {
    final collection = _db.collection('sessions');
    return await collection.find().toList();
  }

  Future<void> bookSession(String sessionId) async {
    final collection = _db.collection('sessions');
    await collection.update(where.eq('_id', sessionId), modify.inc('slots', -1));
  }

  Future<void> close() async {
    await _db.close();
  }
}

