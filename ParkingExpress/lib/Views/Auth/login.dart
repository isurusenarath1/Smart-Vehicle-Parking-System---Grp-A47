import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:parkingexpress/Controllers/AuthController.dart';
import 'package:parkingexpress/Models/Strings/login_screen.dart';
import 'package:parkingexpress/Models/Strings/register_screen.dart';
import 'package:parkingexpress/Models/Utils/Colors.dart';
import 'package:parkingexpress/Models/Utils/Common.dart';
import 'package:parkingexpress/Models/Utils/Images.dart';
import 'package:parkingexpress/Models/Utils/Routes.dart';
import 'package:parkingexpress/Models/Utils/Utils.dart';
import 'package:parkingexpress/Views/Auth/forget_password.dart';
import 'package:parkingexpress/Views/Auth/register.dart';
import 'package:parkingexpress/Views/Contents/Home/home.dart';
import 'package:parkingexpress/Views/Widgets/custom_button.dart';
import 'package:parkingexpress/Views/Widgets/custom_text_form_field.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthController _authController = AuthController();
  final _keyForm = GlobalKey<FormState>();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    _username.text = 'user@gmail.com';
    _password.text = 'User@123';

    // _username.text = 'admin@gmail.com';
    // _password.text = 'Admin@123';

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
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Form(
                  key: _keyForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: displaySize.width * 0.3,
                            child: Image.asset(logo),
                          )),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Text(
                          Login_title.toUpperCase(),
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500,
                              color: color11),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            Login_subtitle.toUpperCase(),
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
                            controller: _username,
                            backgroundColor: color7,
                            iconColor: colorPrimary,
                            isIconAvailable: true,
                            hint: 'Email Address',
                            icon: Icons.email_outlined,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        child: CustomTextFormField(
                            height: 5.0,
                            controller: _password,
                            backgroundColor: color7,
                            iconColor: colorPrimary,
                            isIconAvailable: true,
                            hint: 'Password',
                            icon: Icons.lock_outline,
                            textInputType: TextInputType.text,
                            validation: (value) {
                              final validator = Validator(
                                validators: [const RequiredValidator()],
                              );
                              return validator.validate(
                                label: 'Invalid Email Address',
                                value: value,
                              );
                            },
                            obscureText: true),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Routes(context: context)
                                  .navigate(const ForgetPassword());
                            },
                            child: const Text(
                              Login_forget_password_text,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 45.0, vertical: 20.0),
                        child: CustomButton(
                          buttonText: Login_button_text,
                          textColor: color6,
                          backgroundColor: colorBlack,
                          isBorder: false,
                          borderColor: color6,
                          onclickFunction: () async {
                            if (_keyForm.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              CustomUtils.showLoader(context);

                              try {
                                await _authController.doLogin({
                                  'email': _username.text,
                                  'password': _password.text
                                }).then((value) {
                                  if (value == true) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const Home()));
                                  }
                                });
                              } catch (e) {
                                CustomUtils.hideLoader(context);
                              }
                            }
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Divider(
                                color: colorGrey,
                              )),
                          Expanded(
                              flex: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  "OR",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: color11),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Divider(
                                color: colorGrey,
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 45.0, vertical: 20.0),
                        child: CustomButton(
                          buttonText: "Create New Account",
                          textColor: color6,
                          backgroundColor: colorBlack,
                          isBorder: false,
                          borderColor: color6,
                          onclickFunction: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Registration())),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      )),
    );
  }
}
