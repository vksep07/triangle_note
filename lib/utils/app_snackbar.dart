import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showSnackbar({
  required BuildContext context,
  required String title,
  required String message,
  ContentType? contentType,
}) {
  final snackBar = SnackBar(
    // need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: contentType ?? ContentType.failure,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

showMaterialBanner({
  required BuildContext context,
  required String title,
  required String message,
  ContentType? contentType,
}) {
  final materialBanner = MaterialBanner(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    backgroundColor: Colors.transparent,
    forceActionsBelow: false,
    content: AwesomeSnackbarContent(
      title: 'Oh Hey!!',
      message:
          'This is an example error message that will be shown in the body of materialBanner!',

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.failure,
      // to configure for material banner
      inMaterialBanner: false,
    ),
    actions: const [SizedBox.shrink()],
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentMaterialBanner()
    ..showMaterialBanner(materialBanner);
}

showToast({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
