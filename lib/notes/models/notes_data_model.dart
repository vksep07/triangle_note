import 'package:plateron_assignment/utils/app_util.dart';

class NoteDataModel {
  String title;
  String content;
  String dateTime;
  bool isFavorite;
  int dbId;

  NoteDataModel({
    required this.title,
    required this.content,
    required this.dateTime,
    this.isFavorite = false,
    this.dbId = -1,
  });

  factory NoteDataModel.fromJson(Map<String, dynamic> json) {
    return NoteDataModel(
      dbId: json['id'],
      title: json['title'],
      content: json['content'],
      dateTime: AppUtil().formatTimestampToDateTime(json['timestamp']),
      isFavorite: (json['isFavorite'] == 1) ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': dbId,
      'content': content,
      'timestamp': dateTime,
      'isFavorite': isFavorite,
    };
  }
}
