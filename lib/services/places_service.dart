import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';

class Place {
  String streetNumber;
  String street;
  String city;
  String zipCode;
  String latitude;
  String longitude;

  Place({
    this.streetNumber = "",
    this.street = "",
    this.city = "",
    this.zipCode = "",
    this.latitude = "",
    this.longitude = "",
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}

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

  static final String androidKey = 'AIzaSyDsaO_qmguuljOIJbOttaxEiKQZKiuQbwU';
  static final String iosKey = 'AIzaSyBVAykxsuB1HCPI3f0lXBjMWiWW2-EgLNY';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&key=$apiKey&sessiontoken=$sessionToken';

    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      log(result.toString());

      if (result['status'] == 'OK') {
        log("status is ok");
        // compose suggestions in a list
        return result['predictions'].map<Suggestion>((p) => Suggestion(p['place_id'], p['description'])).toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      log(result['status']);
      if (result['status'] == 'OK') {
        final geomatry = result['result']['geometry'];
        print(result['result']);
        // build result
        final place = Place();
        place.latitude = geomatry['location']['lat'].toString();
        place.longitude = geomatry['location']['lng'].toString();
        log(place.latitude);
        log(place.longitude);
        // components.forEach((c) {
        //   final List type = c['types'];
        //   if (type.contains('street_number')) {
        //     place.streetNumber = c['long_name'];
        //   }
        //   if (type.contains('route')) {
        //     place.street = c['long_name'];
        //   }
        //   if (type.contains('locality')) {
        //     place.city = c['long_name'];
        //   }
        //   if (type.contains('postal_code')) {
        //     place.zipCode = c['long_name'];
        //   }
        // });
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
