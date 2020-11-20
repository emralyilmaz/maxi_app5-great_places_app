import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:maxi_app5_great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }
}
