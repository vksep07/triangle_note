import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:plateron_assignment/notes/models/notes_data_model.dart';
import 'package:plateron_assignment/notes/service/note_service.dart';
import 'package:plateron_assignment/signup/model/user_model.dart';
import 'package:plateron_assignment/utils/common/routes/routes.dart';
import 'package:plateron_assignment/utils/common/services/navigation_service.dart';

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
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0],
            colors: [
              Colors.blue,
              Colors.cyan,
              Colors.green,
            ],
          )),
        ),
        actions: [
          PopupMenuButton(onSelected: (value) {
            // Do something here
          }, itemBuilder: (BuildContext bc) {
            return const [
              PopupMenuItem(
                child: Text("Hello"),
                value: '/hello',
              ),
              PopupMenuItem(
                child: Text("About"),
                value: '/about',
              ),
              PopupMenuItem(
                child: Text("Contact"),
                value: '/contact',
              )
            ];
          })
        ],
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(userName,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            )),
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
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return _buildListItem(list[index]);
                },
              ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            onPressed: () {
              appNavigationService.pushNamed(Routes.add_note_screen);
            },
            child: const Icon(Icons.add),
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
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
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
                Text(
                  item.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                Icon(
                  (item.isFavorite) ? Icons.flag : Icons.outlined_flag,
                  color: item.isFavorite ? Colors.red : Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              item.content,
              style: const TextStyle(fontSize: 16.0),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                Text(
                  item.dateTime,
                  style: const TextStyle(color: Colors.grey),
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
         userName = "Hello, ${user.name}";
      });
    });
  }
}
