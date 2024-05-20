import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_planner/validation/email_validation.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  Rx<Color> emailBorderColor = Colors.grey.shade300.obs;

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Obx(() {
            return TextFormField(
              validator: EmailValidation.validateEmail,
              controller: emailTextController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: emailBorderColor.value),
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                hintText: "e-mail adresiniz",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: passwordTextController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "şifreniz",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              String? emailValidationValue =
                  EmailValidation.validateEmail(emailTextController.text);
              if (emailValidationValue == null) {
                //TODO: KAYIT İŞLEMLERİ
              } else if (emailValidationValue != null) {
                print(emailValidationValue);
              }

              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (EmailValidation.validateEmail(emailTextController.text) ==
                    null) {
                  //TODO: kayıt işlemleri buraya
                } else {
                  emailBorderColor.value = Color(0xFFE91e63);
                  //TODO: gecersiz mail adresi durumu, bir diyalog widget ile burada gösterilebilir
                }
              }
              print(emailTextController.value.text);
              print(passwordTextController.value.text);
            },
            child: Text(
              "Giriş Yap".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
