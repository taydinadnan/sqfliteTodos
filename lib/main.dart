import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:ssqflitetodos/screens/my_home_screen.dart';

import 'models/menu_item.dart';
import 'screens/menu_page.dart';
import 'screens/settings_screen.dart';
import 'screens/tasks_todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MenuItem currentItem = MenuItems.todo;

  @override
  Widget build(BuildContext context) => ZoomDrawer(
        borderRadius: 40,
        angle: -10,
        slideWidth: MediaQuery.of(context).size.width * 0.7,
        showShadow: true,
        backgroundColor: Color(0xFF4AC8EA),
        style: DrawerStyle.Style1,
        mainScreen: getScreen(),
        menuScreen: Builder(builder: (context) {
          return MenuPage(
            currentItem: currentItem,
            onSelectedItem: (item) {
              setState(() {
                currentItem = item;
                ZoomDrawer.of(context)?.close();
              });
            },
          );
        }),
      );

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.todo:
        return TaskTodooScreen();
      case MenuItems.profile:
        return TaskTodooScreen();
      case MenuItems.settings:
        return TodoHomeScreen();
      case MenuItems.about:
      default:
        return TaskTodooScreen();
    }
  }
}
