// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
  List<ProductList>? productList;

  ProductListModel({
    this.productList,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    productList: json["product_list"] == null ? [] : List<ProductList>.from(json["product_list"]!.map((x) => ProductList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_list": productList == null ? [] : List<dynamic>.from(productList!.map((x) => x.toJson())),
  };
}

class ProductList {
  String? productId;
  String? name;
  int? quantity;
  int? availableQuantity;
  int? moq;
  bool? isAvailable;
  int? price;
  String? subDesc;
  String? imageUrl;

  ProductList({
    this.productId,
    this.name,
    this.quantity,
    this.availableQuantity,
    this.moq,
    this.isAvailable,
    this.price,
    this.subDesc,
    this.imageUrl,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    name: json["name"],
    quantity: json["quantity"],
    availableQuantity: json["availableQuantity"],
    moq: json["moq"],
    isAvailable: json["is_available"],
    price: json["price"],
    subDesc: json["sub_desc"],
    imageUrl: json["image_url"],
    productId: json["productId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "quantity": quantity,
    "availableQuantity": availableQuantity,
    "moq": moq,
    "is_available": isAvailable,
    "price": price,
    "sub_desc": subDesc,
    "image_url": imageUrl,
    "productId": productId,
  };
}
