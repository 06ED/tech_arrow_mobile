import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final Color focusColor;
  final Color enabledColor;
  final Color fillColor;
  final Color hintColor;
  final Color textColor;
  final Color iconColor;
  final double borderRadius;
  final double borderWidthFocused;
  final double borderWidthEnabled;
  final Widget? helperWidget;
  final bool showQuestionMark;
  final VoidCallback? onQuestionPressed;
  final Function(String)? validate;
  final double height;
  final TextEditingController controller;

  const MyTextField({
    Key? key,
    required this.labelText,
    this.hintText = "",
    this.focusColor = const Color(0xFF60BAFF),
    this.enabledColor = Colors.white,
    this.fillColor = Colors.white,
    this.hintColor = const Color(0xFF6EBFFF),
    this.textColor = const Color(0xFF60BAFF),
    this.iconColor = const Color(0xFF6EBFFF),
    this.borderRadius = 15.0,
    this.borderWidthFocused = 2.5,
    this.borderWidthEnabled = 1.5,
    this.helperWidget,
    this.showQuestionMark = true,
    this.onQuestionPressed,
    this.validate,
    this.height=30, required String label, required this.controller,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late FocusNode _focusNode;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: widget.height,
          child: TextField(
            controller: widget.controller,
            style: TextStyle(
              color: _focusNode.hasFocus ? widget.focusColor : widget.textColor,
            ),
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: TextStyle(
                color:
                    _focusNode.hasFocus ? widget.focusColor : widget.hintColor,
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: widget.hintColor,
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.hintColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              // focusedBorder: OutlineInputBorder(
              //   borderSide: BorderSide(
              //     color: widget.focusColor,
              //     width: widget.borderWidthFocused,
              //   ),
              //   borderRadius: BorderRadius.circular(widget.borderRadius),
              // ),
              filled: true,
              fillColor:
                  _focusNode.hasFocus ? widget.fillColor : (widget.fillColor),
            ),
          ),
        ),
      ],
    );
  }
}
