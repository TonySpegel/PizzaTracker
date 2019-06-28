//
// Holds Types of a Pizza
//
// Copyright 2019 Tony Spegel
//

import 'package:flutter/foundation.dart';

class PizzaType with ChangeNotifier {
  List<String> _types = [];
  List<String> get types => _types;

  addTypeToList(String type) {
    _types.add(type);
    notifyListeners();
  }

  removeTypeFromList(String type) {
    _types.remove(type);
    notifyListeners();
  }
}
