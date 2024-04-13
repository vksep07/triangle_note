// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plateron_assignment/utils/app_util.dart';
import 'package:plateron_assignment/utils/common/logger/app_logger.dart';
import 'package:plateron_assignment/utils/common_util/utils_importer.dart';
import 'package:plateron_assignment/utils/common_widgets/app_text_widget.dart';
import 'package:plateron_assignment/utils/extensions.dart';

class ConversationList extends StatefulWidget {
  String name;
  String subDesc;
  String imageUrl;
  Function? onclick;
  Function? onAddition;
  Function? onRemoval;
  Function? onAdd;
  bool? isAvailable;
  Function? onKeyboardEnter;
  TextEditingController? controller;
  bool? checkAddButtonDisableOrNot;
  num? price;

  ConversationList(
      {required this.name,
      required this.subDesc,
      required this.imageUrl,
      this.onclick,
      this.onAdd,
      this.controller,
      this.isAvailable,
      this.checkAddButtonDisableOrNot,
      this.onAddition,
      this.onKeyboardEnter,
      this.price,
      this.onRemoval});

  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onclick != null) {
          widget.onclick!();
        }
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color:Theme.of(context).primaryColorDark),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Image border
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(48), // Image radius
                      child: Image.network(widget.imageUrl,
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AppTextWidget(
                            maxlines: 1,
                            text: widget.name,
                            size: 16,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          AppTextWidget(
                            text: widget.subDesc,
                            size: 13,
                            color: Theme.of(AppUtil.getBuildContext()).primaryColorDark,
                            fontWeight: FontWeight.normal,
                          ),
                          Spacer(),
                          Row(
                            children: [
                              AppTextWidget(
                                  text: "Rs.${widget.price}",
                                  size: 12,
                                  fontWeight: FontWeight.bold),
                              Spacer(),
                              (() {
                                if (widget.checkAddButtonDisableOrNot!) {
                                  return addButtonQuantityLayout();
                                }
                                return InkWell(
                                  onTap: () {
                                    if (widget.onAdd != null) {
                                      widget.onAdd!();
                                    }
                                  },
                                  child: addButtonLayout(),
                                );
                              }())
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  addButtonLayout() {
    return Container(
      width: 127,
      height: 30,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(AppUtil.getBuildContext()).primaryColorDark,
            width: 1, //                   <--- border width here
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Align(
        alignment: Alignment.center,
        child: AppTextWidget(
          text: "${UtilsImporter().stringUtils.add}",
        ),
      ),
    );
  }

  addButtonQuantityLayout() {
    return Container(
        width: 127,
        height: 30,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(AppUtil.getBuildContext()).primaryColorDark,              width: 1.5, //                   <--- border width here
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                AppLogger.printLog("On remove - ${widget.isAvailable!}");
                if (widget.isAvailable!) {
                  this.widget.onRemoval!();
                }
              },
              child: Icon(
                Icons.remove,
                color: Theme.of(AppUtil.getBuildContext()).primaryColorDark,
                size: 15,
              ),
            ),
            10.widthBox,
            Container(
              height: 30,
              color: Theme.of(AppUtil.getBuildContext()).primaryColorDark,
              width: 1.5,
            ),
            SizedBox(
              width: 40,
              height: 20,
              child: Stack(
                children: [
                  TextFormField(
                    enabled: false,
                    readOnly: true,
                    onFieldSubmitted: (value) {
                      /// do some stuff here
                      AppLogger.printLog("onFieldSubmitted $value");
                      widget.onKeyboardEnter!(value);
                    },
                    onEditingComplete: () {
                      AppLogger.printLog(
                          "onEditingComplete  onEditingComplete");
                    },
                    onChanged: (val) {
                      AppLogger.printLog("onChanged $val");
                    },
                    enableInteractiveSelection: false,
                    cursorColor: UtilsImporter().colorUtils.darkcolor,
                    //<-- SEE HERE
                    maxLength: 4,
                    autofocus: false,
                    controller: widget.controller,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(AppUtil.getBuildContext()).primaryColorDark,
                        fontWeight: FontWeight.w700),
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      // for below version 2 use this
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      counterText: "",
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
              color: Theme.of(AppUtil.getBuildContext()).primaryColorDark,
              width: 1.5,
            ),
            10.widthBox,
            InkWell(
              onTap: () {
                AppLogger.printLog('Add button clicked 1');
                if (widget.isAvailable!) {
                  AppLogger.printLog('Add button clicked 2');
                  this.widget.onAddition!();
                }
              },
              child: Icon(
                Icons.add,
                color: Theme.of(AppUtil.getBuildContext()).primaryColorDark,
                size: 15,
              ),
            ),
          ],
        ));
  }
}
