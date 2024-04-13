import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:triangle_note/notes/models/notes_data_model.dart';
import 'package:triangle_note/notes/screens/note_dialog.dart';
import 'package:triangle_note/notes/service/note_service.dart';
import 'package:triangle_note/utils/common/routes/routes.dart';
import 'package:triangle_note/utils/common/services/navigation_service.dart';
import 'package:triangle_note/utils/common/services/shared_preference_service.dart';
import 'package:triangle_note/utils/common_util/string_utils.dart';
import 'package:triangle_note/utils/common_widgets/app_text_widget.dart';
import 'package:triangle_note/utils/common_widgets/custom_theme.dart';
import 'package:triangle_note/utils/spacing.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({
    super.key,
  });

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final List<NoteDataModel> items = [];

  NoteService service = GetIt.I<NoteService>();
  String userName = '';

  @override
  void initState() {
    super.initState();
    service.getNoteList();
    getUserNameText();
  }

  var selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColorDark,
              offset: const Offset(
                0,
                AppSpacing.xxs,
              ),
              blurRadius: AppSpacing.xs,
            )
          ]),
          child: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColorLight,
            actionsIconTheme: IconThemeData(
              color: Theme.of(context).primaryColorDark,
            ),
            actions: [
              IconButton(
                icon: (context.isDarkMode)
                    ? const Icon(Icons.sunny)
                    : const Icon(Icons.wb_sunny_outlined),
                onPressed: () {
                  _changeTheme(context.isDarkMode
                      ? MyThemeKeys.LIGHT
                      : MyThemeKeys.DARK);
                  setState(() {});
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  openLogoutDialog(context, () {
                    sharedPreferenceService.setLoginStatus(isLogin: false);
                    appNavigationService.pushNamedAndRemoveUntil(
                      Routes.auth_screen,
                      (route) => false,
                    );
                  });
                },
              ),
            ],
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: AppTextWidget(
              color: Theme.of(context).primaryColorDark,
              text: userName,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
              size: AppSpacing.l,
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder<List<NoteDataModel>>(
        valueListenable: service.notes,
        builder: (context, value, child) {
          return _buildBody(value);
        },
      ),
    );
  }

  _buildBody(List<NoteDataModel> list) {
    return Stack(
      children: [
        (list.isEmpty)
            ? const Center(
                child: Text('No notes found.\n Add a new note to get started.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppSpacing.l,
                      fontWeight: FontWeight.bold,
                    )),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return _buildListItem(list[index]);
                  },
                ),
              ),
        Positioned(
          bottom: AppSpacing.mx,
          right: AppSpacing.mx,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColorDark,
            onPressed: () {
              appNavigationService.pushNamed(Routes.add_note_screen);
            },
            child: Icon(
              Icons.add,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(NoteDataModel item) {
    return InkWell(
      onTap: () {
        appNavigationService.pushNamed(
          Routes.add_note_screen,
          arguments: item,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(
          AppSpacing.s,
        ),
        padding: const EdgeInsets.all(AppSpacing.sx),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(AppSpacing.sx),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColorDark.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextWidget(
                  text: item.title,
                  fontWeight: FontWeight.bold,
                  size: 18.0,
                  color: Theme.of(context).primaryColorDark,
                ),
                Icon(
                  (item.isFavorite) ? Icons.flag : Icons.outlined_flag,
                  color: Theme.of(context).primaryColorDark,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            AppTextWidget(
              text: item.content,
              size: 16.0,
              maxlines: 2,
              overflow: TextOverflow.ellipsis,
              color: Theme.of(context).primaryColorDark,
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                AppTextWidget(
                  text: item.dateTime,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColorDark,
                ),
                // Add any other widgets here for the bottom right corner
              ],
            ),
          ],
        ),
      ),
    );
  }

  getUserNameText() {
    service.getUserFromDb().then((user) {
      setState(() {
        userName = "${StringUtils().Hello}, ${user.name}";

      });
    });
  }

  void _changeTheme(MyThemeKeys key) {
    CustomTheme.instanceOf(appNavigationService.currentContext)
        .changeTheme(key);
  }
}
