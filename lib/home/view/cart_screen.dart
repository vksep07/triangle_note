// ignore_for_file: library_private_types_in_public_api

import 'package:get_it/get_it.dart';

import 'package:flutter/material.dart';
import 'package:plateron_assignment/home/bloc/home_bloc.dart';
import 'package:plateron_assignment/home/network/model/response/product_list_model.dart';
import 'package:plateron_assignment/home/view/item_layout_.dart';
import 'package:plateron_assignment/home/view/bottom_cart_layout.dart';
import 'package:plateron_assignment/utils/app_logger.dart';
import 'package:plateron_assignment/utils/app_util.dart';
import 'package:plateron_assignment/utils/common/routes/routes.dart';
import 'package:plateron_assignment/utils/common/services/navigation_service.dart';
import 'package:plateron_assignment/utils/common_util/utils_importer.dart';
import 'package:plateron_assignment/utils/common_widgets/app_text_widget.dart';
import 'package:plateron_assignment/utils/common_widgets/custom_theme.dart';
import 'package:plateron_assignment/utils/common_widgets/dashed_line.dart';
import 'package:plateron_assignment/utils/constants.dart';
import 'package:plateron_assignment/utils/extensions.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    GetIt.I<HomeScreenBloc>().getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
          titleSpacing: -10,
          leading: IconButton(
              onPressed: () {
                appNavigationService.pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Theme.of(context).primaryColorDark,
              )),
          actions: [
            InkWell(
              onTap: () {
                if (!GetIt.I<HomeScreenBloc>().theme!) {
                  GetIt.I<HomeScreenBloc>().theme = true;
                  GetIt.I<HomeScreenBloc>().changeTheme(MyThemeKeys.DARK);
                } else {
                  GetIt.I<HomeScreenBloc>().theme = false;
                  GetIt.I<HomeScreenBloc>().changeTheme(MyThemeKeys.LIGHT);
                }
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: (() {
                  if (!GetIt.I<HomeScreenBloc>().theme!) {
                    return Icon(
                      Icons.wb_sunny_outlined,
                      color: Theme.of(context).primaryColorDark,
                    );
                  }
                  return Icon(Icons.sunny);
                }()),
              ),
            ),
          ],
          backgroundColor: Theme.of(context).primaryColorLight,
          title: AppTextWidget(
            text: UtilsImporter().stringUtils.cart,
            size: 18,
            color: Theme.of(context).primaryColorDark,
            fontWeight: FontWeight.bold,
          )),
      body: Stack(
        children: [
          SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  StreamBuilder<List<ProductList>>(
                    stream: GetIt.I<HomeScreenBloc>().cartListController,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        List<ProductList>? jokelist = snapshot.data;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: jokelist!.length,
                          itemBuilder: (context, index) {
                            ProductList? productList = jokelist[index];
                            return ConversationList(
                              imageUrl: productList.imageUrl ?? '',
                              name: productList.name ?? '',
                              isAvailable: productList.isAvailable,
                              checkAddButtonDisableOrNot: (() {
                                num qunatity = productList.quantity ?? 0;
                                if (qunatity > 0) {
                                  return true;
                                }
                                return false;
                              }()),
                              price: productList.price,
                              subDesc: productList.subDesc ?? '',
                              onAdd: () {
                                //cartBloc.updateProductCart(model: productList,);
                              },
                              onAddition: () {
                                AppLogger.printLog('onAddition');
                                GetIt.I<HomeScreenBloc>().updateCartItem(
                                    model: productList, type: add);
                              },
                              onRemoval: () {
                                AppLogger.printLog('onRemoval');
                                GetIt.I<HomeScreenBloc>().updateCartItem(
                                    model: productList, type: remove);
                              },
                              controller: TextEditingController(
                                  text: "${productList.quantity}"),
                            );
                          },
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                  20.heightBox,
                  StreamBuilder<List<ProductList>>(
                      stream: GetIt.I<HomeScreenBloc>().cartListController,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 0),
                            child: Card(
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: getBillDetailsUi(),
                            ),
                          );
                        }
                        return const SizedBox();
                      }),
                ],
              )),
          StreamBuilder<List<ProductList>>(
            stream: GetIt.I<HomeScreenBloc>().cartListController,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextWidget(
                      text: UtilsImporter().stringUtils.empty_card,
                      size: 20,
                    ),
                    5.heightBox,
                    ElevatedButton(
                        onPressed: () {
                          appNavigationService.pop();
                        },
                        child: AppTextWidget(
                          text: UtilsImporter().stringUtils.add_item,
                          color: Theme.of(context).primaryColorLight,
                        ))
                  ],
                ));
              } else {
                return const SizedBox();
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomCartLayout(
              buttonText: UtilsImporter().stringUtils.proceed,
              onClick: () {
                appNavigationService
                    .pushReplacementNamed(Routes.order_success_screen);
              },
            ),
          ),
        ],
      ),
    );
  }

  getBillDetailsUi() {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          border: Border.all(
            color: Theme.of(context).primaryColorDark,
          ),
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10))),
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 15, right: 15),
      width: MediaQuery.of(AppUtil.getBuildContext()).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextWidget(
            text: UtilsImporter().stringUtils.bill_details,
            fontWeight: FontWeight.bold,
            size: 16,
          ),
          10.heightBox,
          getRowLayout(
            title: UtilsImporter().stringUtils.subTotal,
            titleWeight: FontWeight.bold,
            value:
                AppUtil.formatCurrency(GetIt.I<HomeScreenBloc>().getTotalCartAmount()),
            valueWeight: FontWeight.normal,
          ),
          getRowLayout(
            title: UtilsImporter().stringUtils.tax,
            titleWeight: FontWeight.bold,
            value: AppUtil.formatCurrency(0),
            valueWeight: FontWeight.normal,
          ),
          getRowLayout(
            title: UtilsImporter().stringUtils.packging,
            titleWeight: FontWeight.bold,
            value: UtilsImporter().stringUtils.free,
            valueWeight: FontWeight.normal,
          ),
          getRowLayout(
            title: UtilsImporter().stringUtils.shipping,
            titleWeight: FontWeight.bold,
            value: UtilsImporter().stringUtils.free,
            valueWeight: FontWeight.normal,
          ),
          const MySeparator(
            height: 2,
          ),
          getRowLayout(
            title: UtilsImporter().stringUtils.pay,
            titleWeight: FontWeight.bold,
            value:
                AppUtil.formatCurrency(GetIt.I<HomeScreenBloc>().getTotalCartAmount()),
            valueWeight: FontWeight.normal,
          ),
        ],
      ),
    );
  }

  getRowLayout(
      {String? title,
      Color? titleTextColor,
      FontWeight? titleWeight,
      String? value,
      Color? valueTextColor,
      double? textSize,
      FontWeight? valueWeight}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          AppTextWidget(
            text: title!,
            fontWeight: titleWeight,
            size: textSize,
            color: titleTextColor,
          ),
          const Expanded(child: SizedBox()),
          AppTextWidget(
            text: value,
            fontWeight: valueWeight,
            size: textSize,
            color: valueTextColor,
          ),
        ],
      ),
    );
  }
}
