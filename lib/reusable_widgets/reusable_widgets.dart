import 'package:flutter/material.dart';

String error1 = '';
String errorMail1 = '';

String errorSignUp1 = '';
String errorMailSignUp1 = '';
Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.black,
  );
}

TextFormField sampleTextFormField(
    String text, IconData icon, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: false,
    enableSuggestions: true,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9), height: 1.15),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.black.withOpacity(0.6),
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
    keyboardType: TextInputType.emailAddress,
  );
}

TextFormField passwordConfirmTextFormField(
    String text,
    IconData icon,
    TextEditingController passwordController,
    TextEditingController passwordConfirmcontroller,
    BuildContext context) {
  return TextFormField(
      controller: passwordConfirmcontroller,
//ma sinucid am stat 4 ore ca sa implementez asta pentru ca voiam sa fie implementata diferit fut-o pula de validare
      validator: (value) {
        if (value!.isEmpty) {
          return "Please re-enter password.";
        } else if (value != passwordController.text) {
          return "Passwords do not match!";
        } else {
          return null;
        }
      },
      obscureText: true,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white70,
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.black.withOpacity(0.2),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
                width: 1.5, style: BorderStyle.solid, color: Colors.grey)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              width: 1.5,
              style: BorderStyle.solid,
              color: Colors.red,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              width: 1.5,
              style: BorderStyle.solid,
              color: Colors.red,
            )),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              width: 1.5,
              style: BorderStyle.solid,
              color: Colors.black26,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              width: 1.5,
              style: BorderStyle.solid,
              color: Theme.of(context).colorScheme.secondary,
            )),
      ),
      keyboardType: TextInputType.visiblePassword);
}
