import 'package:flutter/foundation.dart';

class Toping with ChangeNotifier {
  List<String> _topings = [];
  List<String> get topings => _topings;

  set addTopingToList(String toping) {
    _topings.add(toping);
    notifyListeners();
  }
}
