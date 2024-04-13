import 'package:flutter/material.dart';
import 'package:triangle_note/notes/models/notes_data_model.dart';
import 'package:triangle_note/signup/model/user_model.dart';
import 'package:triangle_note/utils/app_util.dart';
import 'package:triangle_note/utils/common/local_storage/database_helper.dart';
import 'package:triangle_note/utils/common/services/shared_preference_service.dart';

class NoteService {
  ValueNotifier<List<NoteDataModel>> notes =
      ValueNotifier<List<NoteDataModel>>([]);

  getNoteList() async {
    String? mobileNumber = await sharedPreferenceService.getUserMobileNumber();
    List<Map<String, dynamic>> list =
        await DatabaseHelper().getNotes(mobileNumber: mobileNumber ?? '');
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
    String? mobileNumber = await sharedPreferenceService.getUserMobileNumber();
    Map<String, dynamic>? list =
        await DatabaseHelper().getUser(mobileNumber: mobileNumber ?? '');
    UserModel user = UserModel(
      mobileNumber: list!['mobileNumber'],
      name: list['name'],
      pin: list['pin'],
    );

    return user;
  }
}
