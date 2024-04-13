import 'package:flutter/material.dart';
import 'package:plateron_assignment/notes/models/notes_data_model.dart';
import 'package:plateron_assignment/signup/model/user_model.dart';
import 'package:plateron_assignment/utils/app_util.dart';
import 'package:plateron_assignment/utils/common/local_storage/database_helper.dart';

class NoteService {
  ValueNotifier<List<NoteDataModel>> notes =
      ValueNotifier<List<NoteDataModel>>([]);

  getNoteList() async {
    List<Map<String, dynamic>> list =
        await DatabaseHelper().getNotes(mobileNumber: '7503600686');
    List<NoteDataModel> items = [];
    for (Map<String, dynamic> element in list) {
      items.add(
        NoteDataModel(
          title: element['title'],
          content: element['content'],
          dateTime: AppUtil().formatTimestampToDateTime(element['timestamp']),
          isFavorite: element['isFavorite'] == 1 ? true : false,
          dbId: element['id'],
        ),
      );
    }
    notes.value = items;
  }


 Future<UserModel> getUserFromDb() async {
    Map<String, dynamic>? list = await DatabaseHelper().getUser(mobileNumber: '7503600686');
    UserModel user = UserModel(
      mobileNumber: list!['mobileNumber'],
      name: list['name'],
      pin: list['pin'],
    );

    return user;
    
  }
}
