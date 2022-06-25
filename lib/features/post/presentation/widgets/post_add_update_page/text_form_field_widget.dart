import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final bool multiLine;
  const TextFormFieldWidget(
      {required this.controller,
      required this.name,
      required this.multiLine,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (val) => val!.isEmpty ? "$name Can't be empty" : null,
        decoration: InputDecoration(hintText: name),
        maxLines: multiLine ? 6 : 1,
        minLines: multiLine ? 6 : null,
      ),
    );
  }
}
