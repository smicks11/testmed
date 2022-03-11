import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FreeHealthCareProvider extends ChangeNotifier {
  var memoizer = AsyncMemoizer();

  void refresh() {
    memoizer=AsyncMemoizer();
    notifyListeners();
  }
}
