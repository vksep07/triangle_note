import 'dart:collection';
import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:plateron_assignment/home/network/model/response/product_list_model.dart';
import 'package:plateron_assignment/utils/common/logger/app_logger.dart';
import 'package:plateron_assignment/utils/common/services/navigation_service.dart';
import 'package:plateron_assignment/utils/common_util/utils_importer.dart';
import 'package:plateron_assignment/utils/common_widgets/custom_theme.dart';
import 'package:plateron_assignment/utils/constants.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreenBloc {
  bool? theme = false;
  List<ProductList> productList = [];
  LinkedHashMap<String, ProductList>? map = LinkedHashMap();
  List<ProductList> cartList = [];

  final BehaviorSubject<List<ProductList>> _cartListController =
      BehaviorSubject<List<ProductList>>.seeded([]);

  BehaviorSubject<List<ProductList>> get cartListController =>
      _cartListController;

  final BehaviorSubject<bool> _loadingController =
      BehaviorSubject<bool>.seeded(false);

  BehaviorSubject<bool> get loadingController => _loadingController;

  final BehaviorSubject<List<ProductList>> _productListController =
      BehaviorSubject<List<ProductList>>.seeded([]);

  BehaviorSubject<List<ProductList>> get productConListtroller =>
      _productListController;

  final BehaviorSubject<int> _badgeController = BehaviorSubject<int>.seeded(0);

  BehaviorSubject<int> get badgeController => _badgeController;

  void changeTheme(MyThemeKeys key) {
    CustomTheme.instanceOf(appNavigationService.currentContext)
        .changeTheme(key);
  }

  getJson() {
    String tt =
        "{\"product_list\":[{\"name\":\"PavBhajiRecipe\",\"productId\":\"001\",\"quantity\":0,\"availableQuantity\":10,\"moq\":2,\"is_available\":true,\"price\":55,\"sub_desc\":\"MumbaiStyle(Stovetop&InstantPot)\",\"image_url\":\"https://www.vegrecipesofindia.com/wp-content/uploads/2021/04/pav-bhaji-1.jpg\"},{\"productId\":\"002\",\"name\":\"ManchurianRecipe\",\"quantity\":0,\"availableQuantity\":55,\"moq\":2,\"is_available\":true,\"price\":100,\"sub_desc\":\"IndoChineseVegManchurianRecipe\",\"image_url\":\"https://www.vegrecipesofindia.com/wp-content/uploads/2012/05/veg-manchurian-recipe-1.jpg\"},{\"productId\":\"003\",\"name\":\"KadaiMushroomRecipe\",\"quantity\":0,\"availableQuantity\":48,\"moq\":0,\"is_available\":true,\"price\":150,\"sub_desc\":\"adaiMushroomissuchasupereasyanddeliciousdish\",\"image_url\":\"https://www.vegrecipesofindia.com/wp-content/uploads/2012/09/kadai-mushroom-recipe-final.jpg\"},{\"productId\":\"004\",\"name\":\"SambarRecipe\",\"quantity\":0,\"availableQuantity\":140,\"moq\":2,\"is_available\":true,\"price\":200,\"sub_desc\":\"shareourfavoriteSouthIndianSambarRecipe\",\"image_url\":\"https://www.vegrecipesofindia.com/wp-content/uploads/2021/05/sambar-0.jpg\"},{\"productId\":\"005\",\"name\":\"BainganBhartaRecipe\",\"quantity\":0,\"availableQuantity\":140,\"moq\":2,\"is_available\":true,\"price\":200,\"sub_desc\":\"BainganBhartaisapopularPunjabidishfromtheNorthIndiancuisine.\",\"image_url\":\"https://www.vegrecipesofindia.com/wp-content/uploads/2021/06/baingan-bharta-1.jpg\"},{\"productId\":\"006\",\"name\":\"AlooMatarOrAlooMutter\",\"quantity\":0,\"availableQuantity\":140,\"moq\":2,\"is_available\":true,\"price\":200,\"sub_desc\":\"AlooMatar(alsospelledAlooMutter)isoneofthemostcomfortingandbelovedPunjabicurriesaround.\",\"image_url\":\"https://www.vegrecipesofindia.com/wp-content/uploads/2013/12/aloo-matar-gravy-recipe.jpg\"},{\"productId\":\"007\",\"name\":\"VegKadaiRecipe\",\"quantity\":0,\"availableQuantity\":140,\"moq\":2,\"is_available\":true,\"price\":200,\"sub_desc\":\"ThisdeliciousandvibrantVegKadaigravyisfilledwithrichflavors,aromaticspicesandvegetables.\",\"image_url\":\"https://www.vegrecipesofindia.com/wp-content/uploads/2021/08/veg-kadai-1.jpg\"},{\"productId\":\"008\",\"name\":\"IdliSambar(HotelStyle)|TiffinSambar\",\"quantity\":0,\"availableQuantity\":140,\"moq\":2,\"is_available\":true,\"price\":200,\"sub_desc\":\"IdliSambarisahearty,satisfying,comfortingandahealthymealofsoftfluffy.\",\"image_url\":\"https://www.vegrecipesofindia.com/wp-content/uploads/2014/05/idli-sambar.jpg\"},{\"productId\":\"009\",\"name\":\"VegHandi|VegDiwaniHandi\",\"quantity\":0,\"availableQuantity\":140,\"moq\":2,\"is_available\":true,\"price\":200,\"sub_desc\":\"Veghandirecipewithstepbysteppics.\",\"image_url\":\"https://www.vegrecipesofindia.com/wp-content/uploads/2014/11/veg-diwani-handi.jpg\"},{\"productId\":\"010\",\"name\":\"GobiMasalaRecipe\",\"quantity\":0,\"availableQuantity\":140,\"moq\":2,\"is_available\":true,\"price\":200,\"sub_desc\":\"Here’savegetariandishthatisasuperpopularfeatureinmenusofNorthIndian\",\"image_url\":\"https://www.vegrecipesofindia.com/wp-content/uploads/2013/11/gobi-masala-recipe.jpg\"}]}";
    var jsonMap = json.decode(tt);
    ProductListModel productItemLayout = ProductListModel.fromJson(jsonMap);
    checkCartMapForExistance(list: productItemLayout.productList);
    // AppLogger.printLog(jsonMap);
    AppLogger.printLog("----- ${productItemLayout.productList!.length}");
  }

  checkCartMapForExistance({List<ProductList>? list}) {
    if (map!.isNotEmpty) {
      for (ProductList productList in list!) {
        bool check = map!.containsKey(productList.productId);
        if (check) {
          productList.quantity = map![productList.productId]?.quantity;
        }
      }
    }

    productList = list ?? [];
    _productListController.add(list ?? []);
  }

  onAddProduct({required int pos}) {
    ProductList? model = productList[pos];
    model.quantity = int.parse((model.quantity ?? 0).toString()) + 1;
    updateProductCart(model: model);
    _productListController.add(productList);
  }

  onUpdate({required int pos, int? type}) {
    ProductList? model = productList[pos];
    if (type == add) {
      model.quantity = int.parse((model.quantity ?? 0).toString()) + 1;
      updateProductCart(model: model);
    } else {
      model.quantity = int.parse((model.quantity ?? 0).toString()) - 1;
      updateProductCart(model: model);
    }
    _productListController.add(productList);
  }

  updateProductCart({required ProductList model}) {
    bool? check = map!.containsKey(model.productId);
    if (check) {
      if (model.quantity! < 1) {
        map!.remove(model.productId);
      } else {
        map!.update(model.productId!, (value) => model);
      }
    } else {
      map!.putIfAbsent(model.productId!, () => model);
    }

    badgeController.add(map!.length);
  }

  int? getTotalCartAmount() {
    int val = 0;
    for (var item in map!.entries) {
      ProductList model = item.value;
      val = val + (model.price! * model.quantity!);
    }
    return val;
  }

  List<ProductList>? getCartList() {
    cartList.clear();
    for (var item in map!.entries) {
      ProductList model = item.value;
      cartList.add(model);
    }
    _cartListController.add(cartList);
    checkCartMapForExistance(list: productList);
    return cartList;
  }

  updateCartItem({required ProductList model, required int type}) {
    if (type == add) {
      model.quantity = model.quantity! + 1;
    } else {
      model.quantity = model.quantity! - 1;
    }
    bool? check = GetIt.I<HomeScreenBloc>().map!.containsKey(model.productId);
    if (check) {
      if (model.quantity! < 1) {
        GetIt.I<HomeScreenBloc>().map!.remove(model.productId);
      } else {
        GetIt.I<HomeScreenBloc>()
            .map!
            .update(model.productId!, (value) => model);
      }
    } else {
      GetIt.I<HomeScreenBloc>().map!.putIfAbsent(model.productId!, () => model);
    }
    GetIt.I<HomeScreenBloc>()
        .badgeController
        .add(GetIt.I<HomeScreenBloc>().map!.length);
    getCartList();
  }

  void resetCard() {
    GetIt.I<HomeScreenBloc>().cartList.clear();
    GetIt.I<HomeScreenBloc>().map!.clear();
    GetIt.I<HomeScreenBloc>().getJson();
    GetIt.I<HomeScreenBloc>().badgeController.add(0);
    appNavigationService.pop();
  }

  String? getItemsText({required int count}) {
    if (count == 1) {
      return '$count ${UtilsImporter().stringUtils.item}';
    }
    return '$count ${UtilsImporter().stringUtils.items}';
  }
}
