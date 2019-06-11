import 'package:flutter/foundation.dart';

class Topping with ChangeNotifier {
  List<String> _toppings = ['Salami', 'Pilze', 'Bacon'];
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
