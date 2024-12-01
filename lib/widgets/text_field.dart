import 'package:flutter/material.dart';

class KrishiTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextStyle textStyle;
  final bool isPassword;
  final void Function(String)? onChanged;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final double radius;
  final bool autofocus;
  final String? initialValue;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final bool hasSearchIcon;
  final BoxDecoration? boxDecoration;
  final bool hasImagePicker;
  final VoidCallback? onClickImage;
  final TextStyle hintStyle;
  const KrishiTextField({
    super.key,
    this.onChanged,
    this.hasSearchIcon = false,
    this.hasImagePicker = false,
    this.onClickImage,
    this.focusNode,
    this.controller,
    this.boxDecoration,
    this.hintText,
    this.initialValue,
    this.validator,
    this.keyboardType,
    this.labelText,
    this.textInputAction,
    this.radius = 7,
    this.maxLines = 1,
    this.maxLength,
    this.onFieldSubmitted,
    this.autofocus = false,
    this.textStyle = const TextStyle(
      color: Colors.black,
      decoration: TextDecoration.none,
      fontSize: 14,
    ),
    this.isPassword = false,
    this.hintStyle = const TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
  });

  @override
  State<KrishiTextField> createState() => _TrekSathiTextFieldState();
}

class _TrekSathiTextFieldState extends State<KrishiTextField> {
  bool isObscure = false;
  @override
  void initState() {
    super.initState();
  }

  void toggle() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color.fromARGB(199, 77, 76, 76),
        width: 1,
      ),
      gapPadding: 2,
      borderRadius: BorderRadius.all(
        Radius.circular(widget.radius),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: widget.boxDecoration,
        child: TextFormField(
          initialValue: widget.initialValue,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: widget.onChanged,
          autofocus: widget.autofocus,
          controller: widget.controller,
          style: widget.textStyle,
          textInputAction: widget.textInputAction,
          obscureText: widget.isPassword ? !isObscure : false,
          validator: widget.validator,
          enableIMEPersonalizedLearning: true,
          enabled: true,
          textAlign: TextAlign.start,
          enableSuggestions: true,
          decoration: InputDecoration(
            counterText: '',
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            labelText: widget.labelText,
            suffixIcon: widget.hasImagePicker
                ? IconButton(
                    color: Colors.black,
                    onPressed: () {
                      if (widget.onClickImage != null) {
                        widget.onClickImage!();
                      }
                    },
                    icon: Icon(
                      Icons.image,
                    ),
                  )
                : widget.hasSearchIcon
                    ? const Icon(Icons.search)
                    : widget.isPassword
                        ? IconButton(
                            onPressed: toggle,
                            icon: Icon(
                              isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          )
                        : null,
            enabledBorder: border,
            border: border,
            focusedBorder: border,
          ),
        ),
      ),
    );
  }
}
