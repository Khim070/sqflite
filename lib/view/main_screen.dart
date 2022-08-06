import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:test5/Model/user_model.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:test5/connection/database_connection.dart';
import 'package:test5/view/screen_update.dart';

import '../model/user_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  late DatabaseConnection db;
  Future<List<User>>? listUser;
  Future<List<User>> getList() async {
    return await db.getUser();
  }

  @override
  void initState() {
    super.initState();
    db = DatabaseConnection();
    db.initializeUserDB().whenComplete(() async {
      setState(() {
        listUser = db.getUser();
        print(listUser!.then((value) => value.first.name.toString()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: 'Enter name', border: OutlineInputBorder()),
            ),
          ),
          Container(
            height: 400,
            width: double.infinity,
            child: FutureBuilder(
              future: listUser,
              builder: (context, AsyncSnapshot<List<User>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return snapshot.hasError
                    ? const Center(
                        child: Icon(
                          Icons.info,
                          color: Colors.red,
                          size: 28,
                        ),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: ((context, index) {
                          var item = snapshot.data![index];
                          return InkWell(
                            child: Card(
                              child: ListTile(
                                title: Text(item.name),
                                trailing: IconButton(
                                  onPressed: () async {
                                    await DatabaseConnection()
                                        .deletedatabase(item.id);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return screenupdate(
                                    user: item,
                                  );
                                }));
                              });
                            },
                          );
                        }));
              },
            ),
          ),
          OutlinedButton(
              style: TextButton.styleFrom(
                  primary: Colors.redAccent,
                  backgroundColor: Colors.lightBlue[200]),
              onPressed: () async {},
              child: Text('Delete'))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (() async {
            await DatabaseConnection()
                .insetUser(
                    User(id: Random().nextInt(200), name: controller.text))
                .whenComplete(() {
              print('insert success');
            });
          }),
          tooltip: 'Increment',
          child: const Icon(Icons.done)),
    );
  }
}
