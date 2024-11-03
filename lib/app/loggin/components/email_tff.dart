import 'package:flutter/material.dart';
import 'package:loggin_page_pct/app/loggin/validate.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      controller: emailController,
      autofocus: true,
      textInputAction: TextInputAction.next,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        alignLabelWithHint: true,
        prefixIcon: const Icon(Icons.person,
            color: Colors.white),
        hoverColor: Colors.white,
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        contentPadding: const EdgeInsets.all(30),
        hintStyle: const TextStyle(color: Colors.white),
        label: const Text('E-mail',
            style: TextStyle(color: Colors.white)),
        border: const OutlineInputBorder(
          gapPadding: 5,
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) =>
          Validate.email(email: value),
    );
  }
}
