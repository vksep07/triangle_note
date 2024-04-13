
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
    return Container(
      height: 80,
      decoration:  BoxDecoration(
          color: Theme.of(context).primaryColor,
        boxShadow: [
        BoxShadow(
          color: Theme.of(context).primaryColorDark,
          offset:const  Offset(0, 2.0),
          blurRadius: 4.0,
        )
      ]),
      child: SafeArea(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColorDark,
              ),
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
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                if (onPressedImportantIcon != null) {
                  onPressedImportantIcon!();
                }
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: Theme.of(context).primaryColorDark,
              ),
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
                  margin: const EdgeInsets.only(bottom: 5),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(100),
                        bottomLeft: Radius.circular(100),
                      )),
                  child: Row(
                    children: [
                      Icon(
                        Icons.done,
                        color: Theme.of(context).primaryColor,
                      ),
                      5.widthBox,
                      Text(
                        'SAVE',
                        style: TextStyle(
                          letterSpacing: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
