import 'package:flutter/foundation.dart';

class Info extends ChangeNotifier {
    late String name;
    changeName(String newName){
      name = newName;
      notifyListeners();
    }
}
