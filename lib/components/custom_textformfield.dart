import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {Key? key,
      required this.header,
      required this.onSaved,
      required this.validator,
      this.textInputAction})
      : super(key: key);

  final String header;
  final FormFieldSetter onSaved;
  final FormFieldValidator validator;
  final TextInputAction? textInputAction;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.header),
          TextFormField(
            onSaved: widget.onSaved,
            validator: widget.validator,
            textInputAction: widget.textInputAction ?? TextInputAction.next,
          )
        ],
      ),
    );
  }
}
