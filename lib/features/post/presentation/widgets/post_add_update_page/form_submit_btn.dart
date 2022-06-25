import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  final bool isUpdate;
  final void Function() onPressed;
  const FormSubmitBtn(
      {required this.isUpdate, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(isUpdate ? Icons.edit : Icons.add),
      label: Text(isUpdate ? "Update" : "Add"),
    );
  }
}
