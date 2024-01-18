import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField(
      {super.key,
      required this.titleText,
      this.labelText,
      this.readOnly,
      this.isEnabled,
      this.onTap,
      this.initialValue,
      r,
      this.controller,
      required this.isDate});
  final String titleText;
  final String? labelText;
  final bool? readOnly;
  final bool? isEnabled;
  final String? initialValue;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final bool isDate;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(width: double.infinity, child: Text(widget.titleText)),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () => {widget.onTap!()},
            child: TextFormField(
              controller: widget.controller,
              initialValue: widget.initialValue,
              readOnly: widget.readOnly ?? false,
              enabled: widget.isEnabled ?? true,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                    color: widget.isDate == true ? Colors.black : Colors.grey),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 1.0,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: const OutlineInputBorder(),
                labelText: widget.labelText,
                hintText: null,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
