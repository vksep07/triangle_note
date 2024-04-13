// To parse this JSON data, do
//
//     final jokesResModel = jokesResModelFromJson(jsonString);

import 'dart:convert';

JokesResModel jokesResModelFromJson(String str) => JokesResModel.fromJson(json.decode(str));

String jokesResModelToJson(JokesResModel data) => json.encode(data.toJson());

class JokesResModel {
  String? joke;

  JokesResModel({
    this.joke,
  });

  factory JokesResModel.fromJson(Map<String, dynamic> json) => JokesResModel(
    joke: json["joke"],
  );

  Map<String, dynamic> toJson() => {
    "joke": joke,
  };
}
