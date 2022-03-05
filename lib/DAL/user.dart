

class user {
  late String _fullName;
  late int _age;
  late String _email;
  late String _gender;
  late String _userName;
  late String _password;


   String get getpassword => _password;

  set setpassword(String value) {
    _password = value;
  }



   String get getfullName => _fullName;

   String get getuserName => _userName;

  set setuserName(String value) {
    _userName = value;
  }




  String get getgender => _gender;

  set setgender(String value) {
    _gender = value;
  }

  String get getemail => _email;

  set setemail(String value) {
    _email = value;
  }

  int get getage => _age;

  set setage(int value) {
    _age = value;
  }

  set setfullName(String value) {
    _fullName = value;
  }

   @override
  String toString() {
    return ' _fullName: $_fullName, _age: $_age, _email: $_email, _gender: $_gender, _userName: $_userName,_password: $_password,}';
  }
}