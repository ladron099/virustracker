import 'dart:io';

class connection{
   Future <bool> internetcheck(bool aa) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        aa=true;
      }
    } on SocketException catch (_) {
      print('not connected');
      aa = false;
      print(aa.toString());
    }
    return aa;
  }
}