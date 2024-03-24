import 'package:parkingexpress/Models/DB/User.dart';
import 'package:flutter/material.dart';
import 'package:form_validation/form_validation.dart';
import 'package:parkingexpress/Controllers/AuthController.dart';
import 'package:parkingexpress/Models/Strings/main_screen.dart';
import 'package:parkingexpress/Models/Utils/Common.dart';
import 'package:parkingexpress/Models/Utils/Utils.dart';
import 'package:parkingexpress/Views/Widgets/custom_button.dart';
import 'package:parkingexpress/Views/Widgets/custom_text_area.dart';
import 'package:parkingexpress/Views/Widgets/custom_text_date_chooser.dart';
import 'package:parkingexpress/Views/Widgets/custom_text_form_field.dart';

import '../../Models/Strings/register_screen.dart';
import '../../Models/Utils/Colors.dart';
import '../../Models/Utils/Routes.dart';
import '../Widgets/custom_back_button.dart';

class Registration extends StatefulWidget {
  Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool termsAndConditionCheck = false;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _nic = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm_password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AuthController _authController = AuthController();

  @override
  void initState() {
    _name.text = "";
    _nic.text = "";
    _mobile.text = "";
    _email.text = "";
    _password.text = "";
    _confirm_password.text = "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child:
                                  CustomCustomBackButton(onclickFunction: () {
                                Routes(context: context).back();
                              })),
                          const Center(
                            child: Text(
                              Signup_title,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 5.0),
                                      child: CustomTextFormField(
                                          height: 5.0,
                                          controller: _name,
                                          backgroundColor: color7,
                                          iconColor: colorPrimary,
                                          isIconAvailable: true,
                                          hint: 'Full Name',
                                          icon: Icons.person_outline,
                                          textInputType: TextInputType.text,
                                          validation: (value) {
                                            final validator = Validator(
                                              validators: [
                                                const RequiredValidator()
                                              ],
                                            );
                                            return validator.validate(
                                              label:
                                                  register_validation_invalid_name,
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
                                          controller: _email,
                                          backgroundColor: color7,
                                          iconColor: colorPrimary,
                                          isIconAvailable: true,
                                          hint: 'Email',
                                          icon: Icons.email_outlined,
                                          textInputType:
                                              TextInputType.emailAddress,
                                          validation: (value) {
                                            final validator = Validator(
                                              validators: [
                                                const RequiredValidator()
                                              ],
                                            );
                                            return validator.validate(
                                              label:
                                                  register_validation_invalid_email,
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
                                          controller: _nic,
                                          backgroundColor: color7,
                                          iconColor: colorPrimary,
                                          isIconAvailable: true,
                                          hint: 'NIC Number',
                                          icon: Icons.card_membership_outlined,
                                          textInputType: TextInputType.text,
                                          validation: (value) {
                                            final validator = Validator(
                                              validators: [
                                                const RequiredValidator()
                                              ],
                                            );
                                            return validator.validate(
                                              label: "Please fill this field",
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
                                          controller: _mobile,
                                          backgroundColor: color7,
                                          iconColor: colorPrimary,
                                          isIconAvailable: true,
                                          hint: 'Mobile Number',
                                          icon: Icons.phone_android_outlined,
                                          textInputType: TextInputType.phone,
                                          validation: (value) {
                                            final validator = Validator(
                                              validators: [
                                                const RequiredValidator()
                                              ],
                                            );
                                            return validator.validate(
                                              label: "Please fill this field",
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
                                          icon: Icons.lock_open,
                                          textInputType: TextInputType.text,
                                          validation: (value) {
                                            final validator = Validator(
                                              validators: [
                                                const RequiredValidator()
                                              ],
                                            );
                                            return validator.validate(
                                              label:
                                                  register_validation_invalid_password,
                                              value: value,
                                            );
                                          },
                                          obscureText: true),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 5.0),
                                      child: CustomTextFormField(
                                          height: 5.0,
                                          controller: _confirm_password,
                                          backgroundColor: color7,
                                          iconColor: colorPrimary,
                                          isIconAvailable: true,
                                          hint: 'Confirm Password',
                                          icon: Icons.lock_open,
                                          textInputType: TextInputType.text,
                                          validation: (value) {
                                            final validator = Validator(
                                              validators: [
                                                const RequiredValidator()
                                              ],
                                            );

                                            if (value != _password.text) {
                                              return register_validation_passwords_does_not_match;
                                            }

                                            return validator.validate(
                                              label:
                                                  register_validation_invalid_retype_password,
                                              value: value,
                                            );
                                          },
                                          obscureText: true),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 5.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 20.0,
                                            width: 20.0,
                                            child: Checkbox(
                                              checkColor: colorPrimary,
                                              fillColor:
                                                  MaterialStateProperty.all(
                                                      color7),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(3)),
                                              value: termsAndConditionCheck,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  termsAndConditionCheck =
                                                      value!;
                                                });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0, left: 10.0),
                                            child: SizedBox(
                                              width: displaySize.width * 0.65,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    termsAndConditionCheck =
                                                        !termsAndConditionCheck;
                                                  });
                                                },
                                                child: Text(
                                                  Signup_Checkbox_termsAndConditions_lbl,
                                                  style: TextStyle(
                                                      color: colorBlack,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 45.0, vertical: 20.0),
                                      child: CustomButton(
                                          buttonText: SignUp_title,
                                          textColor: color6,
                                          backgroundColor: colorBlack,
                                          isBorder: false,
                                          borderColor: color6,
                                          onclickFunction: () async {
                                            FocusScope.of(context).unfocus();
                                            if (termsAndConditionCheck ==
                                                true) {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                CustomUtils.showLoader(context);
                                                FocusScope.of(context)
                                                    .unfocus();
                                                await _authController
                                                    .doRegistration({
                                                  'name': _name.text.toString(),
                                                  'nic': _nic.text.toString(),
                                                  'mobile':
                                                      _mobile.text.toString(),
                                                  'email':
                                                      _email.text.toString(),
                                                  'type': LoggedUser.User,
                                                  'password':
                                                      _password.text.toString()
                                                }).then((value) =>
                                                        CustomUtils.hideLoader(
                                                            context));

                                                _formKey.currentState!.reset();

                                                _name.text = '';
                                                _nic.text = '';
                                                _mobile.text = '';
                                                _email.text = '';
                                                _password.text = '';
                                                _confirm_password.text = '';
                                              }
                                            } else {
                                              CustomUtils.showSnackBar(
                                                  context,
                                                  register_setect_terms_and_conditions,
                                                  CustomUtils.ERROR_SNACKBAR);
                                            }
                                          }),
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
