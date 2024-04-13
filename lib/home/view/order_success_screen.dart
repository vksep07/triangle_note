import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:plateron_assignment/home/bloc/home_bloc.dart';
import 'package:plateron_assignment/utils/app_util.dart';
import 'package:plateron_assignment/utils/assets.dart';
import 'package:plateron_assignment/utils/common_util/utils_importer.dart';
import 'package:plateron_assignment/utils/common_widgets/app_text_widget.dart';
import 'package:plateron_assignment/utils/extensions.dart';
import 'package:plateron_assignment/utils/spacing.dart';

class OrderSuccessScreen extends StatefulWidget {
  String? order;

  OrderSuccessScreen({Key? key, this.order}) : super(key: key);

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        GetIt.I<HomeScreenBloc>().resetCard();
        return Future.value(true);
      },
      child: SafeArea(
          child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              AppTextWidget(
                text:
                    UtilsImporter().stringUtils.order_placed_successfully,
                size: 22,
              ),
              10.heightBox,
              AppTextWidget(
                text:
                    UtilsImporter().stringUtils.your_order_has_been_placed_successfully,
                size: 22,
              ),
              Spacer(),
              SizedBox(
                height: 200,
                width: 300,
                child: SvgPicture.asset(
                  Assets.orderSuccess,
                ),
              ),
              50.heightBox,
              Column(
                children: [
                  RowItem(
                    title: UtilsImporter().stringUtils.order_id,
                    value: " XYZADBED12322",
                  ),
                  RowItem(
                    title: UtilsImporter().stringUtils.delivery_date,
                    value: "28-Sep-2023",
                  ),
                  RowItem(
                    title:
                        UtilsImporter().stringUtils.total_invoice_amount,
                    value:
                        AppUtil.formatCurrency(GetIt.I<HomeScreenBloc>().getTotalCartAmount()),
                  ),
                  RowItem(
                    title: UtilsImporter().stringUtils.total_items,
                    value: "${GetIt.I<HomeScreenBloc>().getCartList()?.length}",
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  GetIt.I<HomeScreenBloc>().resetCard();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(AppUtil.getBuildContext())
                            .primaryColorDark,
                        width: 1, //                   <--- border width here
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Align(
                    alignment: Alignment.center,
                    child: AppTextWidget(
                      text: UtilsImporter().stringUtils.continue_shoppping,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSpacing.l,
              )
            ],
          ),
        ),
      )),
    );
  }
}

class RowItem extends StatelessWidget {
  final String? title;
  final String? value;

  const RowItem({Key? key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextWidget(
            text: "$title ",
          ),
          AppTextWidget(
            text: "$value ",
          ),
        ],
      ),
    );
  }
}
