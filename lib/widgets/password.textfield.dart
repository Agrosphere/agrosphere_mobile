import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String value)? onChange;
  final String hintText;
  final String labelField;
  const PasswordField({
    super.key,
    this.controller,
    this.onChange,
    this.labelField = "Password",
    this.hintText = "Password",
  });

  @override
  State<PasswordField> createState() => _TiffinPasswordFieldState();
}

class _TiffinPasswordFieldState extends State<PasswordField> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _isObscure,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelField,
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        disabledBorder: InputBorder.none,
      ),
      onChanged: widget.onChange,
    );
  }
}
