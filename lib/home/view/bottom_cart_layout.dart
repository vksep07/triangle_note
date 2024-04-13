// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:plateron_assignment/home/bloc/home_bloc.dart';
import 'package:plateron_assignment/utils/app_util.dart';
import 'package:plateron_assignment/utils/common/logger/app_logger.dart';
import 'package:plateron_assignment/utils/common_widgets/app_text_widget.dart';
import 'package:plateron_assignment/utils/extensions.dart';

class BottomCartLayout extends StatefulWidget {
  Function? onClick;
  String? buttonText;
  BottomCartLayout({Key? key, this.onClick,this.buttonText}) : super(key: key);

  @override
  State<BottomCartLayout> createState() => _BottomCartLayoutState();
}

class _BottomCartLayoutState extends State<BottomCartLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream:  GetIt.I<HomeScreenBloc>().badgeController,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data! > 0) {
          return Container(
            color: Theme.of(context).primaryColorLight,
            child: InkWell(
              onTap: () {
                AppLogger.printLog('handleClickFloaterViewCart');
                if (widget.onClick != null) {
                  widget.onClick!();
                }
              },
              child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                padding:
                const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 1, color: Theme.of(context).primaryColorDark),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextWidget(
                      text: GetIt.I<HomeScreenBloc>().getItemsText(count: snapshot.data ?? 0),
                    ),
                    10.widthBox,
                    Text(
                      '\u2022 ${AppUtil.formatCurrency( GetIt.I<HomeScreenBloc>().getTotalCartAmount())}',
                    ),
                    10.widthBox,

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${widget.buttonText}',
                        ),
                        5.widthBox,
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryColorDark,
                          size: 15,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );

        }

        return const SizedBox();
      },
    );
  }
}
