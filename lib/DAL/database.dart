import 'package:cloud_firestore/cloud_firestore.dart';
class databaseService{
  final CollectionReference trackCollection=FirebaseFirestore.instance.collection('users');
  late final String uid;
  databaseService({required this.uid});
  Future updateUserDate(String fullName, int age,String gender,String username,String password,String email,bool infected,String registerDate,String dateCtl) async{
    return await trackCollection.doc(uid).set({
     'fullName':fullName,
      'age':age,
      'gender':gender,
      'username':username,
      'password':password,
      'email':email,
      'infected':infected,
      'registerDate':registerDate,
      'birthDate':dateCtl,
    });
  }

}