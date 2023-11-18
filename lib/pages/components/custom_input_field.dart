import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({Key? key,
    required this.title,
    this.obscureText = false,
    this.color = Colors.white,
    this.controller,
    this.initialValue,
    this.hint,
    this.suffixIcon,
    this.readOnly = false,
    this.validator

  }) : super(key: key);
  final String? initialValue;
  final String title;
  final bool readOnly;
  final Color color;
  final String? hint;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {

  late bool obscure;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold, color: widget.color),),
          TextFormField(
            obscureText: obscure,
            initialValue: widget.initialValue,
            controller: widget.controller,
            readOnly: widget.readOnly,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(color:widget.color),
            decoration: InputDecoration(
                hintText: widget.hint ?? "Enter_Your_email".tr() + widget.title,
                hintStyle:  TextStyle(color: widget.color),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:  BorderSide(color: widget.color, width: 2)
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:  BorderSide(color: widget.color, width: 2)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: widget.color, width: 2)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.red, width: 2)
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: widget.color, width: 2)
                ),
                errorStyle: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 14),
                suffixIcon: widget.suffixIcon ?? (widget.obscureText?  GestureDetector(
                    onTap: (){
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    child: Icon(obscure? Icons.visibility: Icons.visibility_off, color: Colors.white,)) : null

                )),
            validator: widget.validator,

          ),
        ],
      ),
    );
  }
}
