import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test5/connection/database_connection.dart';
import 'package:test5/view/main_screen.dart';

import '../model/user_model.dart';

class screenupdate extends StatefulWidget {
  screenupdate({required this.user, Key? key}) : super(key: key);

  User user;

  @override
  State<screenupdate> createState() => _screenupdateState();
}

class _screenupdateState extends State<screenupdate> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = widget.user.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 600,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)))),
                    ),
                  )
                ],
              ),
            ),
          ),
          OutlinedButton(
              onPressed: () async {
                await DatabaseConnection()
                    .updatedatabase(
                        User(id: widget.user.id, name: controller.text))
                    .whenComplete(() {
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MyHomePage(title: 'Flutter SQFlite');
                    }));
                  });
                });
              },
              child: Text('Update'))
        ],
      ),
    );
  }
}
