// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:parkingexpress/Controllers/AuthController.dart';
import 'package:parkingexpress/Models/Strings/forget_password.dart';
import 'package:parkingexpress/Models/Strings/register_screen.dart';
import 'package:parkingexpress/Models/Utils/Colors.dart';
import 'package:parkingexpress/Models/Utils/Common.dart';
import 'package:parkingexpress/Models/Utils/Images.dart';
import 'package:parkingexpress/Models/Utils/Routes.dart';
import 'package:parkingexpress/Models/Utils/Utils.dart';
import 'package:parkingexpress/Views/Widgets/custom_button.dart';
import 'package:parkingexpress/Views/Widgets/custom_back_button.dart';
import 'package:parkingexpress/Views/Widgets/custom_text_form_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _LoginState();
}

class _LoginState extends State<ForgetPassword> {
  final AuthController _authController = AuthController();
  final _keyForm = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  dynamic response;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: color6,
      body: SafeArea(
          child: SizedBox(
        height: displaySize.height,
        width: displaySize.width,
        child: Stack(
          children: [
            Container(
              height: displaySize.height,
              width: displaySize.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [colorPrimary, colorSecondary],
                    begin: const FractionalOffset(0.0, 1.0),
                    end: const FractionalOffset(1.0, 0.0),
                    tileMode: TileMode.clamp),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: CustomCustomBackButton(
                    onclickFunction: () => Routes(context: context).back())),
            Form(
                key: _keyForm,
                child: Padding(
                  padding: EdgeInsets.only(bottom: displaySize.width * 0.3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: displaySize.width * 0.5,
                            child: Image.asset(passwordReset),
                          )),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: Text(
                          "Forget Password".toUpperCase(),
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: color11),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "Reset your account password".toUpperCase(),
                            style:
                                TextStyle(fontSize: 12.0, color: colorPrimary),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: displaySize.width * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        child: CustomTextFormField(
                            height: 5.0,
                            controller: _email,
                            backgroundColor: color7,
                            iconColor: colorPrimary,
                            isIconAvailable: true,
                            hint: 'Email',
                            icon: Icons.email,
                            textInputType: TextInputType.text,
                            validation: (value) {
                              final validator = Validator(
                                validators: [const RequiredValidator()],
                              );
                              return validator.validate(
                                label: register_validation_invalid_email,
                                value: value,
                              );
                            },
                            obscureText: false),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 20.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                              buttonText: forget_passsword_button_text,
                              textColor: color6,
                              backgroundColor: colorBlack,
                              isBorder: false,
                              borderColor: color6,
                              onclickFunction: () async {
                                FocusScope.of(context).unfocus();
                                if (_keyForm.currentState!.validate()) {
                                  CustomUtils.showLoader(context);
                                  await _authController
                                      .sendPasswordResetLink(
                                          context, _email.text)
                                      .then((value) {
                                    CustomUtils.hideLoader(context);
                                    _email.text = '';
                                    CustomUtils.showSnackBarMessage(
                                        context,
                                        "Password Reset Link Sent",
                                        CustomUtils.ERROR_SNACKBAR);
                                    Routes(context: context).back();
                                  });
                                }
                              }),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
