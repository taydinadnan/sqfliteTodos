import 'package:flutter/material.dart';

import '../constants.dart';

typedef OnCompose = void Function(String title, String description);

class ComposeWidget extends StatefulWidget {
  final OnCompose onCompose;
  const ComposeWidget({Key? key, required this.onCompose}) : super(key: key);

  @override
  _ComposeWidgetState createState() => _ComposeWidgetState();
}

class _ComposeWidgetState extends State<ComposeWidget> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          decoration: const BoxDecoration(
            color: mainColor,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: mainColor,
                    hintText: "Enter title...",
                    focusedBorder: InputBorder.none,
                  ),
                  style: const TextStyle(color: secondColor),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          decoration: const BoxDecoration(
            color: mainColor,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: mainColor,
                    hintText: "Enter description...",
                    focusedBorder: InputBorder.none,
                  ),
                  style: const TextStyle(color: secondColor),
                ),
              ),
              IconButton(
                onPressed: () {
                  final title = _titleController.text;
                  final description = _descriptionController.text;
                  widget.onCompose(title, description);
                  _titleController.text = '';
                  _descriptionController.text = '';
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                  color: btnColor,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
