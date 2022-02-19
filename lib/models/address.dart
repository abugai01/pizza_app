import 'package:google_maps_flutter/google_maps_flutter.dart';

class Address {
  static const ID = "id";
  static const LAT = "lat";
  static const LNG = "lng";
  static const TITLE = "title";
  static const DESCRIPTION = "description";
  static const ENTRANCE = "entrance";
  static const INTERCOM = "intercom";
  static const APARTMENT = "apartment";
  static const FLOOR = "floor";
  static const COMMENT = "comment";
  static const IS_MAIN = "isMain";
  static const CITY = "city";
  static const STREET = "street";
  static const HOUSE = 'house';

  String? id;
  double? lat;
  double? lng;
  String? city;
  String? title;
  String? street;
  String? house;
  String? description;
  String? entrance;
  String? intercom;
  String? apartment;
  String? floor;
  String? comment;
  late bool isMain;


  Address({
    this.id,
    this.lat,
    this.lng,
    this.title,
    //this.house,
    //this.street,
    this.description,
    this.entrance,
    this.intercom,
    this.apartment,
    this.floor,
    this.comment,
    this.isMain = false,
    this.city,
  });

  Map<String, dynamic> toMap({bool compact = false}) {
    Map<String, dynamic> data = {};
    data[Address.ID] = id;
    data[Address.LAT] = lat;
    data[Address.LNG] = lng;
    data[Address.TITLE] = title;
    data[Address.DESCRIPTION] = description;
    if (compact == true) {
      return data;
    }
    data[Address.ENTRANCE] = entrance;
    data[Address.INTERCOM] = intercom;
    data[Address.APARTMENT] = apartment;
    data[Address.FLOOR] = floor;
    data[Address.COMMENT] = comment;
    data[Address.IS_MAIN] = isMain;
    data[Address.CITY] = city;
    return data;
  }

  static Address fromMap(Map<String, dynamic>? data, String? documentId) {
    final id = data?[ID] ?? documentId;
    return Address(
        id: id,
        lat: data?[LAT],
        lng: data?[LNG],
        title: data?[TITLE],
        description: data?[DESCRIPTION],
        city: data?[CITY],
        //street: data?[STREET],
        //house: data?[HOUSE],
        isMain: data?[IS_MAIN] ?? false,
        entrance: data?[ENTRANCE],
        floor: data?[FLOOR],
        intercom: data?[INTERCOM],
        apartment: data?[APARTMENT],
        comment: data?[COMMENT]
    );
  }

  void update({
    String? title,
    String? description,
    bool? isMain,
    String? city,
    String? entrance,
    String? intercom,
    String? apartment,
    String? floor,
    String? comment,
  }) {
    if (title != null) {
      this.title = title;
    }
    if (description != null) {
      this.description = description;
    }
    if (isMain != null) {
      this.isMain = isMain;
    }
    if (city != null) {
      this.city = city;
    }
    if (entrance != null) {
      this.entrance = entrance;
    }
    if (intercom != null) {
      this.intercom = intercom;
    }
    if (apartment != null) {
      this.apartment = apartment;
    }
    if (floor != null) {
      this.floor = floor;
    }
    if (comment != null) {
      this.comment = comment;
    }
  }


  //TODO: ENGLISH
  String get entranceText => (entrance != null) ? "Подъезд: $entrance" : '';
  String get intercomText => (intercom != null) ? "Домофон: $intercom" : '';
  String get apartmentText => (apartment != null) ?  "Квартира: $apartment" : '';
  String get floorText => (floor != null) ? "Этаж: " + floor! : '';
  //String get shortDescription => makeSubstring(description ?? '', length: 25);
  LatLng get position => LatLng(lat!, lng!);

}