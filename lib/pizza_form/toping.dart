import 'package:flutter/foundation.dart';

class Toping with ChangeNotifier {
  List<String> _topings = ['Salami', 'Pilze', 'Bacon'];
  List<String> get topings => _topings;

  addTopingToList(String toping) {
    _topings.add(toping);
    notifyListeners();
  }

  removeTopingFromList(String toping) {
    _topings.remove(toping);
    notifyListeners();
  }
}
