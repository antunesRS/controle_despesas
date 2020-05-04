import 'package:flutter/material.dart';

class TextFormComponent extends StatelessWidget {

  final TextEditingController _controller;
  final String _label;

  TextFormComponent(this._controller, this._label);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: _label
      ),
      controller: _controller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );
  }
}
