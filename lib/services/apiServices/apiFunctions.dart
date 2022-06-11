import 'dart:convert';

import 'package:http/http.dart' as http;

import 'constApi.dart';

class ApiFunctions {
  login(String email, String password) async {
    try {
      var response = await http.post(Uri.parse(loginURL),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode({"email": email, "password": password}));
      return response;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  createUser(String birthDate, String email, String fullName, String gender,
      String password, String cin) async {
    try {
      var response = await http.post(Uri.parse(createUserURL),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode({
            "birthDate": birthDate,
            "email": email,
            "fullName": fullName,
            "gender": gender,
            "password": password,
            "cin": cin
          }));
      print(response.statusCode);
      print(response.body);
      return response;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  getuser(String token) async {
    try {
      var response = await http.get(
        Uri.parse(getUserURL),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "auth-token": token
        },
      );
      return response;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
  getViruses(String token) async {
    try {
      var response = await http.get(
        Uri.parse(getVirusesURL),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "auth-token": token
        },
      );
      return response;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  modifyPassword(String token, String email, String previousPassword,
      String newPassword) async {
    try {
      var response =
          await http.put(Uri.parse(modifyPassURL),
              headers: {
                "Content-type": "application/json",
                "Accept": "application/json",
                "auth-token": token
              },
              body: jsonEncode({
                "email": email,
                "previousPassword": previousPassword,
                "newPassword": newPassword,
              }));
      print(response.statusCode);
      print(response.body);
      return response;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
  updatePlayerId( String PlayerId,String token) async {
    try {
      var response =
          await http.put(Uri.parse(updateToken),
              headers: {
                "Content-type": "application/json",
                "Accept": "application/json",
                "auth-token": token
              },
              body: jsonEncode({
               "playerId": PlayerId,
              }));
      return response;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  modifyUser(String token, String email, String fullName, String birthDate,
      String cin) async {
    try {
      var response = await http.put(Uri.parse(modifyUserURL),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
            "auth-token": token
          },
          body: jsonEncode({
            "email": email,
            "fullName": fullName,
            "birthDate": birthDate,
            "cin": cin
          }));
      print(response.statusCode);
      print(response.body);
      return response;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  metWith(String token, String contactUid, String ContactTime, double latitude, double longitude) async {
    try {
      var response = await http.post(Uri.parse(metWithURL),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
            "auth-token": token
          },
          body: jsonEncode({
            "contactUid": contactUid,
            "contactTime": ContactTime,
            "latitude": latitude,
            "longitude": longitude,
          }));
      return response;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
  checkEmail( String email) async {
    try {
      var response = await http.post(Uri.parse(checkEmailURL),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json", 
          },
          body: jsonEncode({
            "email": email,
          }));
      return response;
    } catch (e) {
      print(e);
      return e.toString();
    }
  

  }
  deleteAccount( String token) async {
    try {
      var response = await http.delete(Uri.parse(deleteUserURL),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json", 
              "auth-token": token
          },);
      return response;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
  resetPassword( String email,String password) async {
    try {
      var response = await http.post(Uri.parse(resetPassURL),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json", 
          },
          body: jsonEncode({
            "email": email,
            "newPassword": password,
          }));
      return response;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
  addContamination( String token,String virusId,String time,double latitude, double longitude) async {
      try {
      var response = await http.post(Uri.parse(declareURL),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
            "auth-token": token
          },
          body: jsonEncode({
            "uidVirus": virusId,
            "contaminationTime": time,
            "latitude": latitude,
            "longitude": longitude,
          }));
      return response;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
  
}
