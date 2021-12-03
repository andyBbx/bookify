class Location {
  String? adresss;
  String? lat, long;
  Location({this.adresss, this.long, this.lat});

  Map<String, dynamic> toJson() => {
        'adresss': adresss,
        'long': long,
        'lat': lat,
      };

  fromJson(Map<String, dynamic> parsedJson) {
    return Location(
        adresss: parsedJson["adresss"].toString(),
        long: parsedJson["long"],
        lat: parsedJson["lat"]);
  }
}
