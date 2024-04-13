 import 'package:flutter/material.dart';
import 'package:triangle_note/utils/common_util/string_utils.dart';
import 'package:triangle_note/utils/common_util/utils_importer.dart';
import 'package:triangle_note/utils/common_widgets/app_text_widget.dart';



 StringUtils getStringObject() {
    return UtilsImporter().stringUtils;
  }
openConfirmationDialog(BuildContext context, Function deleteCallback) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColorLight,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: AppTextWidget(
              text: getStringObject().delete_note,
              fontWeight: FontWeight.w500,
              size: 18,
            ),
            content: AppTextWidget(
              text: getStringObject().delete_message,
              size: 14,
              fontWeight: FontWeight.normal,
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () async {
                  deleteCallback();
                  // await DatabaseHelper()
                  //     .deleteNote(dbId: widget.existingNote!.dbId);
                  // callTriggerToRefresh();
                  // Navigator.pop(context);
                  // Navigator.pop(context);
                },
                child: AppTextWidget(
                  text: getStringObject().delete,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: AppTextWidget(
                  text: getStringObject().cancel,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ],
          );
        });
  }



  openLogoutDialog(BuildContext context, Function logoutCallback) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColorLight,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: AppTextWidget(
              text: getStringObject().logout,
              fontWeight: FontWeight.w500,
              size: 18,
            ),
            content: AppTextWidget(
              text: getStringObject().logout_msg,
              size: 14,
              fontWeight: FontWeight.normal,
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () async {
                  logoutCallback();
                  
                },
                child: AppTextWidget(
                  text: getStringObject().yes,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: AppTextWidget(
                  text: getStringObject().no,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ],
          );
        });
  }