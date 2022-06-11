
import '../models/metWith.dart';
import '../utils/db_helper.dart';

class DBService {
  
  Future<List<metWith>> getMetWith() async {
    await DBHelper.init();
    List<Map<String, dynamic>> contacts = await DBHelper.queryAll(metWith.table);
    return contacts.map((item) => metWith.fromMap(item)).toList();
  }

  Future<List<metWith>> getContact(String uid,String contactUid) async {
    await DBHelper.init();
    List<Map<String, dynamic>> contacts = await DBHelper.queryContact(metWith.table, uid, contactUid);
    return contacts.map((item) => metWith.fromMap(item)).toList();
  }

  Future<List<metWith>> getContacts(String uid) async {
    await DBHelper.init();
    List<Map<String, dynamic>> contacts = await DBHelper.query(metWith.table, uid);
    return contacts.map((item) => metWith.fromMap(item)).toList();
  }

  Future<bool> addContact(metWith model) async {
    await DBHelper.init();
    int ret = await DBHelper.insert(metWith.table, model);
    return ret > 0 ? true : false;
  }

  Future<bool> updateContact(metWith model) async {
    await DBHelper.init();
    int ret = await DBHelper.update(metWith.table, model);
    return ret > 0 ? true : false;
  }

  
  Future<bool> removeAll(metWith model) async {
    await DBHelper.init();
    int ret = await DBHelper.delete(metWith.table, model);
    return ret > 0 ? true : false;
  }

  Future<bool> removeContact(String uid,String contactUid) async {
    await DBHelper.init();
    int ret = await DBHelper.deleteContact(metWith.table, uid, contactUid);
    return ret > 0 ? true : false;
  }
}
