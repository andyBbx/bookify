import 'dart:convert';
import 'dart:io';

import 'package:bookify/data/models/location.dart';
import 'package:http/http.dart';

class Place {
  String? streetNumber;
  String? street;
  String? city;
  String? zipCode;
  dynamic lat;
  dynamic long;

  Place(
      {this.streetNumber,
      this.street,
      this.city,
      this.zipCode,
      this.lat,
      this.long});
}

// For storing our result
class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyAb-A3ugvq1lEYFImFRqa97MjHhKb-ZdzI';
  static final String iosKey = 'AIzaSyAb-A3ugvq1lEYFImFRqa97MjHhKb-ZdzI';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=es&components=country:es&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  // Future<Place> getPlaceDetailFromId(String placeId) async {
  //   // if you want to get the details of the selected place by place_id
  // }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final client = Client();

    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component%2Cgeometry&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        final componentGeo = result['result']['geometry'];
        // build result
        final place = Place();

        place.long = componentGeo['location']['lng'];

        place.lat = componentGeo['location']['lat'];

        components.forEach((c) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }
        });

        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Location> getPlaceFromGeo(lat, long) async {
    final client = Client();
    final place = Location();

    place.long = long.toString();
    place.lat = lat.toString();

    final request =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$apiKey';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components = result['results'];

        if (components.isNotEmpty) {
          place.adresss = components.first['formatted_address'];
        }

        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
