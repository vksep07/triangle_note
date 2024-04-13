// ignore_for_file: library_private_types_in_public_api

import 'package:get_it/get_it.dart';

import 'package:flutter/material.dart';
import 'package:plateron_assignment/home/bloc/home_bloc.dart';
import 'package:plateron_assignment/home/network/model/response/product_list_model.dart';
import 'package:plateron_assignment/home/view/item_layout_.dart';
import 'package:plateron_assignment/home/view/bottom_cart_layout.dart';
import 'package:plateron_assignment/utils/app_logger.dart';
import 'package:plateron_assignment/utils/common/routes/routes.dart';
import 'package:plateron_assignment/utils/common/services/navigation_service.dart';
import 'package:plateron_assignment/utils/common_util/utils_importer.dart';
import 'package:plateron_assignment/utils/common_widgets/app_text_widget.dart';
import 'package:plateron_assignment/utils/common_widgets/custom_theme.dart';
import 'package:plateron_assignment/utils/constants.dart';
import 'package:plateron_assignment/utils/default_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    GetIt.I<HomeScreenBloc>().getJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme
            .of(context)
            .primaryColorLight,
        appBar: AppBar(
            actions: [
              InkWell(
                onTap: () {
                  if (! GetIt.I<HomeScreenBloc>().theme!) {
                    GetIt.I<HomeScreenBloc>().theme = true;
                    GetIt.I<HomeScreenBloc>().changeTheme(MyThemeKeys.DARK);
                  } else {
                    GetIt.I<HomeScreenBloc>().theme = false;
                    GetIt.I<HomeScreenBloc>().changeTheme(MyThemeKeys.LIGHT);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: (() {
                    if (! GetIt.I<HomeScreenBloc>().theme!) {
                      return Icon(
                        Icons.wb_sunny_outlined,
                        color: Theme
                            .of(context)
                            .primaryColorDark,
                      );
                    }
                    return Icon(Icons.sunny);
                  }()),
                ),
              ),
            ],
            backgroundColor: Theme
                .of(context)
                .primaryColorLight,
            title: AppTextWidget(
              text: UtilsImporter().stringUtils.home,
              size: 18,
              color: Theme
                  .of(context)
                  .primaryColorDark,
              fontWeight: FontWeight.bold,
            )),
        body: Stack(
          children: [
            StreamBuilder<bool>(
              stream:  GetIt.I<HomeScreenBloc>().loadingController,
              builder: (context, snapshot) {
                if (snapshot.hasData && !snapshot.data!) {
                  return StreamBuilder<List<ProductList>>(
                    stream:  GetIt.I<HomeScreenBloc>().productConListtroller,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        List<ProductList>? jokelist = snapshot.data;
                        return ListView.builder(
                          padding: const EdgeInsets.only(bottom: 100),
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
                                GetIt.I<HomeScreenBloc>().onAddProduct(pos: index);
                              },
                              onAddition: () {
                                AppLogger.printLog('onAddition');
                                GetIt.I<HomeScreenBloc>().onUpdate(pos: index, type: add);
                              },
                              onRemoval: () {
                                AppLogger.printLog('onRemoval');
                                GetIt.I<HomeScreenBloc>().onUpdate(
                                    pos: index, type: remove);
                              },
                              controller: TextEditingController(
                                  text: "${productList.quantity}"),
                            );
                          },
                        );
                      }

                      return AppTextWidget(
                          text: UtilsImporter().stringUtils.no_data_found);
                    },
                  );
                } else {
                  return const DefaultLoading();
                }
              },
            ),


            Align(
              alignment: Alignment.bottomCenter,
              child: BottomCartLayout(
                buttonText: UtilsImporter().stringUtils.view_cart,
                onClick: () {
                  appNavigationService.pushNamed(Routes.cart_screen);
                },
              ),
            ),
          ],
        )

    );
  }

}
