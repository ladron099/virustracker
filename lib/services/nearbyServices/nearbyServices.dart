import 'dart:async';

import 'package:CovidTracker/models/metWith.dart';
import 'package:CovidTracker/models/user.dart';
import 'package:CovidTracker/services/db_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import '../apiServices/apiFunctions.dart';

Future<LocationData?> determinePosition() async {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }
  _locationData = await location.getLocation();
  return _locationData;
}

class nearbyServices {
  late final Strategy strategy;
  Map<String, ConnectionInfo> endpointMap = Map();

  nearbyServices(this.strategy);

  String userID = '';
  String token = '';

  void onConnectionInit(String id, ConnectionInfo info) {
    print("id:" + id);
    print("token:" + info.authenticationToken);
    print("name:" + info.endpointName);
    print("incoming:" + (info.isIncomingConnection).toString());
  }

  void advertise(String name) async {
    try {
      bool a = await Nearby().startAdvertising(
        name,
        strategy,
        onConnectionInitiated: onConnectionInit,
        onConnectionResult: (id, status) {
          print(status);
        },
        onDisconnected: (id) {
          print("Disconnected: ${endpointMap[id]!.endpointName}, id $id");
        },
        serviceId: "com.pfe.virustracker",
      );
    } catch (exception) {
      print(exception);
    }
  }

  _getU() async {
    final prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token') ?? '';
    return (prefs.getString('uid') ?? '');
  }

  void discover(String userName) async {
    final ConnectivityResult result =
    await Connectivity().checkConnectivity();
    DBService dbService = DBService();
    if(result != ConnectivityResult.none){
      List<metWith> list = await dbService.getContacts(userName);
      if(list.isNotEmpty){
        ApiFunctions near = ApiFunctions();
        for(metWith element in list) {
          var data = await near.metWith(token, element.contactUid!, element.date!,element.latitude!, element.longitude!).then((data){
           var a = dbService.removeContact(userName, element.contactUid!);
           print(a);
           print(data.statusCode);
           print(data.body);
          });

        }
      }else{
        print("list is empty so dont send to db");
      }
    }
    double latitude=0.0;
    double longitude=0.0;
    try {
      bool a = await Nearby().startDiscovery(
        userName,
        strategy,
        onEndpointFound: (id, name, serviceId) async {
          debugPrint("Id:" + id);
          debugPrint("Name:" + name);
          debugPrint("Service:" + serviceId);
          var position = determinePosition();
          position.then((value) async {
            latitude = (value?.latitude) ?? 0.0;
            longitude= (value?.longitude) ?? 0.0;
            print(latitude);
            print(longitude);
            print('Connection is '+ result.toString());
            if (result == ConnectivityResult.none) {
              var model = metWith(uid: userName, contactUid: name, date: DateTime.now().toString(), latitude: latitude, longitude: longitude);
             Future<List<metWith>>l = dbService.getContact(model.uid!, model.contactUid!);
             l.then((l){
               if(l.isEmpty){
                 var b = dbService.addContact(model);
                 print('list is empty then added to db: ' + b.toString());
               }else{
                 var b = dbService.removeContact(model.uid!, model.contactUid!).then((_){
                   var a = dbService.addContact(model);
                   print('added after delete' + a.toString());
                 });
               }
             });
            }else{
              ApiFunctions near = ApiFunctions();
              var use = await near.metWith(token, name, (DateTime.now()).toString(),latitude, longitude);
              print(use.statusCode);
              print(use.body);
            }
          });
        },
        onEndpointLost: (id) {
          print("Lost discovered Endpoint: id $id");
        },
        serviceId: "com.pfe.virustracker",
      );
      print("DISCOVERING using uid: " + userName + " " + a.toString());
      print(strategy);
    } catch (e) {
      print(e);
    }
  }

  getUserIDandAdvertise() async {
    final String userName = await _getU();
    advertise(userName);
  }

  _getUIDandDiscover() async {
    final String userName = await _getU();
    discover(userName);
  }

  void stopServices() {
    print('Stopping old services...');
    Nearby().stopAdvertising();
  }

  void startServices(bool start) async {
    if (start) {
      print('Starting...');
      _getUIDandDiscover();
      Future.delayed(Duration(seconds: 10), () {
        Nearby().stopDiscovery();
      });
    } else
      print('Could not start services. Requirements not met.');
  }
}
