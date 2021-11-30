import 'package:flutter/material.dart';
import 'package:ssqflitetodos/models/menu_item.dart';

class MenuItems {
  static const todo = MenuItem('To-Do', Icons.toc_outlined);
  static const profile = MenuItem('Profile', Icons.person);
  static const settings = MenuItem('Settings', Icons.settings);
  static const about = MenuItem('About', Icons.info_outline_rounded);

  static const all = <MenuItem>[
    todo,
    profile,
    settings,
    about,
  ];
}

class MenuPage extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const MenuPage({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData.dark(),
        child: Scaffold(
          backgroundColor: Color(0xFF272D34),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                ...MenuItems.all.map(buildMenuItem).toList(),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildMenuItem(MenuItem item) => ListTileTheme(
        selectedColor: Color(0xFF4AC8EA),
        child: ListTile(
          selectedTileColor: Colors.black26,
          selected: currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(item.icon),
          title: Text(item.title),
          onTap: () => onSelectedItem(item),
        ),
      );
}
