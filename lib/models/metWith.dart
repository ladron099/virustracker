import 'model.dart';

class metWith extends Model {
  static String table = "contacts";
  int? id;
  String? uid;
  String? contactUid;
  String? date;
  double? latitude;
  double? longitude;

  metWith(
      {this.id,
      required this.uid,
      required this.contactUid,
      required this.date,
      required this.latitude,
      required this.longitude});

  static metWith fromMap(Map<String, dynamic> json) {
    return metWith(
      id: json["id"],
      uid: json["uid"],
      contactUid: json["contactUid"],
      date: json["date"],
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "id": id,
      "uid": uid,
      "contactUid": contactUid,
      "date": date,
      "latitude": latitude,
      "longitude": longitude,
    };
    if (id != null) {
      json['id'] = id;
    }
    return json;
  }
}
