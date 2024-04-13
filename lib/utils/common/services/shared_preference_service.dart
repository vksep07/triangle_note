import 'dart:convert';

import 'package:plateron_assignment/home/network/model/response/jokes_res_model.dart';
import 'package:plateron_assignment/home/network/model/response/product_list_model.dart';
import 'package:plateron_assignment/utils/common/logger/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  //TAG
  final tag = "SHARED_PREFERENCE_SERVICE";

  late SharedPreferences _prefs;

  Function get clearAllData => _clearAllData;

  Future<bool> getSharedPreferencesInstance() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      return true;
    } catch (e) {
      return false;
    }
  }

  List<ProductList> getJokesList() {
    String? pref = _prefs.getString("joke_list");
    if (pref != null) {
      // convert string data to jsonMap
      var jsonMap = json.decode(pref);
      AppLogger.printLog('getJokesList -- ${jsonMap}');

// convert json map list to object model lis
      List<ProductList> sampleListFromPreferance = List<ProductList>.from(
          jsonMap.map((x) => ProductListModel.fromJson(x)));
      return sampleListFromPreferance;
    } else {
      return [];
    }
  }

  Future setProductList({List<ProductList>? productList}) async {
    String? listJson = json.encode(productList);
    await _prefs.setString('joke_list', listJson);
  }

  Future _clearAllData() async {
    await _prefs.clear();
  }
}

final SharedPreferenceService sharedPreferenceService =
    SharedPreferenceService();
