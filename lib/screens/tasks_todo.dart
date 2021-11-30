import 'package:flutter/material.dart';
import 'package:ssqflitetodos/widgets/menu_widget.dart';

import '../constants.dart';

class TaskTodooScreen extends StatefulWidget {
  const TaskTodooScreen({Key? key}) : super(key: key);

  @override
  _TaskTodooScreenState createState() => _TaskTodooScreenState();
}

class _TaskTodooScreenState extends State<TaskTodooScreen> {
  TextEditingController inputController = TextEditingController();

  String newTaskTxt = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        title: const Text("My To-Do"),
        leading: const MenuWidget(),
      ),
      backgroundColor: mainColor,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            decoration: BoxDecoration(
              color: mainColor,
            ),
            child: Row(
              children: [
                Container(
                  width: 20.0,
                  height: 20.0,
                  margin: EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.white, width: 1.5)),
                  child: Image(
                    image: AssetImage('assets/images/check_icon.png'),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: inputController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: mainColor,
                      hintText: "Enter Todo item...",
                      focusedBorder: InputBorder.none,
                    ),
                    style: TextStyle(color: secondColor),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    size: 30,
                    color: btnColor,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
