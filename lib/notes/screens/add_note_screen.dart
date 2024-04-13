// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:triangle_note/notes/models/notes_data_model.dart';
import 'package:triangle_note/notes/screens/note_dialog.dart';
import 'package:triangle_note/notes/service/note_service.dart';
import 'package:triangle_note/notes/widgets/text_field_widget.dart';
import 'package:triangle_note/notes/widgets/top_actions_button.dart';
import 'package:triangle_note/utils/app_toast.dart';
import 'package:triangle_note/utils/common/local_storage/database_helper.dart';
import 'package:triangle_note/utils/common/services/navigation_service.dart';
import 'package:triangle_note/utils/common/services/shared_preference_service.dart';

// ignore: must_be_immutable
class EditNotePage extends StatefulWidget {
  NoteDataModel? existingNote;
  EditNotePage({
    super.key,
    this.existingNote,
  });
  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  FocusNode titleFocus = FocusNode();
  FocusNode contentFocus = FocusNode();
  bool isFavorite = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  NoteService service = GetIt.I<NoteService>();

  getTimestamp() {
    return DateTime.now();
  }

  @override
  void initState() {
    super.initState();
    if (widget.existingNote != null) {
      titleController.text = widget.existingNote!.title;
      contentController.text = widget.existingNote!.content;
      isFavorite = widget.existingNote!.isFavorite;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 80,
                  ),
                  TextFieldWidget(
                    textEditingController: titleController,
                    titleFocus: titleFocus,
                    hintText: 'Enter the title',
                    onChanged: (value) {
                      setState(() {});
                    },
                    onFieldSubmitted: () {
                      titleFocus.unfocus();
                      FocusScope.of(context).requestFocus(contentFocus);
                    },
                  ),
                  TextFieldWidget(
                    textEditingController: contentController,
                    titleFocus: contentFocus,
                    hintText: 'Write note here...',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    onChanged: (value) {
                      setState(() {});
                    },
                    onFieldSubmitted: () {},
                  ),
                ],
              ),
            ),
            TopActionButton(
              isEnable: checkSaveButtonEnable(),
              onSave: () {
                handleSave();
              },
              backButton: () {
                appNavigationService.pop();
              },
              isFavorite: isFavorite,
              onDelete: () {
                handleDelete();
              },
              onPressedImportantIcon: () {
                setState(() {
                  if (isFavorite) {
                    isFavorite = false;
                  } else {
                    isFavorite = true;
                  }
                });
                if (checkSaveButtonEnable()) {
                  handleSave();
                }
              },
            ),
          ],
        ));
  }

  void handleSave() async {
    int dbId = 0;
    String? mobileNumber = await sharedPreferenceService.getUserMobileNumber();
    if (widget.existingNote == null) {
      dbId = await DatabaseHelper().addNote(
        mobileNumber: mobileNumber ?? '',
        title: titleController.text,
        content: contentController.text,
        isFavorite: isFavorite,
      );
    } else {
      dbId = await DatabaseHelper().updateNote(
        mobileNumber: mobileNumber ?? '',
        title: titleController.text,
        content: contentController.text,
        isFavorite: isFavorite,
        dbId: widget.existingNote!.dbId,
      );
    }
    showToast(message: 'Note saved successfully');
    Map<String, dynamic>? map = await DatabaseHelper().getNoteById(dbId);
    widget.existingNote = NoteDataModel.fromJson(map!);
    callTriggerToRefresh();
    titleFocus.unfocus();
    contentFocus.unfocus();
  }

  void callTriggerToRefresh() {
    service.getNoteList();
  }

  bool checkSaveButtonEnable() {
    if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void handleDelete() async {
    if (widget.existingNote == null) {
      Navigator.pop(context);
    } else {
      openConfirmationDialog(context, () async {
        await DatabaseHelper().deleteNote(
          dbId: widget.existingNote!.dbId,
        );
        callTriggerToRefresh();
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }
  }
}
