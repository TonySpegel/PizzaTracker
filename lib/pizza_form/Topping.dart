//
// Holds Toppings of a Pizza
//
// Copyright 2019 Tony Spegel
//

import 'package:flutter/foundation.dart';


class Topping with ChangeNotifier {
  List<String> _toppings = [];
  List<String> get toppings => _toppings;

  addToppingToList(String topping) {
    _toppings.add(topping);
    notifyListeners();
  }

  removeToppingFromList(String topping) {
    _toppings.remove(topping);
    notifyListeners();
  }
}
