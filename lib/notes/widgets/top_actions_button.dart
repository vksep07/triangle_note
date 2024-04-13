import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plateron_assignment/utils/extensions.dart';

class TopActionButton extends StatelessWidget {
  final Function? backButton;
  final bool? isFavorite;
  final Function? onPressedImportantIcon;
  final Function? onDelete;
  final bool isEnable;
  final Function onSave;

  const TopActionButton({
    super.key,
    this.backButton,
    this.isFavorite = false,
    this.onPressedImportantIcon,
    this.onDelete,
    required this.isEnable,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            
            height: 80,
            color: Theme.of(context).canvasColor.withOpacity(0.3),
            child: SafeArea(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      if (backButton != null) {
                        backButton!();
                      }
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Mark note as important',
                    icon: Icon(
                      isFavorite ?? false ? Icons.flag : Icons.outlined_flag,
                    ),
                    onPressed: () {
                      if (onPressedImportantIcon != null) {
                        onPressedImportantIcon!();
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      if (onDelete != null) {
                        onDelete!();
                      }
                    },
                  ),
                  AnimatedContainer(
                    margin: const EdgeInsets.only(left: 10),
                    duration: const Duration(milliseconds: 200),
                    width: isEnable ? 100 : 0,
                    height: 42,
                    curve: Curves.decelerate,
                    child: InkWell(
                      onTap: () {
                        onSave();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              bottomLeft: Radius.circular(100),
                            )),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                            5.widthBox,
                            const Text(
                              'SAVE',
                              style: TextStyle(
                                  letterSpacing: 1, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
