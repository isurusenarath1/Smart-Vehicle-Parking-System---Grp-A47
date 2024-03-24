import 'package:parkingexpress/Models/Utils/Utils.dart';
import 'package:parkingexpress/Views/Widgets/custom_button.dart';
import 'package:parkingexpress/Views/Widgets/custom_text_form_field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parkingexpress/Models/Utils/Colors.dart';
import 'package:parkingexpress/Models/Utils/Common.dart';
import 'package:parkingexpress/Models/Utils/FirebaseStructure.dart';
import 'package:parkingexpress/Models/Utils/Routes.dart';
import 'package:form_validation/form_validation.dart';
import 'package:intl/intl.dart';

class ParkingManagement extends StatefulWidget {
  const ParkingManagement({Key? key}) : super(key: key);

  @override
  State<ParkingManagement> createState() => _ParkingManagementState();
}

class _ParkingManagementState extends State<ParkingManagement> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  List<dynamic> list = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: color7,
        body: SafeArea(
          child: SizedBox(
              width: displaySize.width,
              height: displaySize.height,
              child: Column(
                children: [
                  Expanded(
                      flex: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 18.0, bottom: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Routes(context: context).back();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: colorWhite,
                                ),
                              ),
                              Text(
                                "Parking Management",
                                style: TextStyle(fontSize: 16.0, color: color7),
                              ),
                              GestureDetector(
                                onTap: () => openEnrollment(null),
                                child: Icon(
                                  Icons.add,
                                  color: colorWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: colorWhite,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 5.0, left: 5.0, right: 5.0),
                          child: (list.isNotEmpty)
                              ? SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        for (var rec in list)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 1.0),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Card(
                                                color: colorWhite,
                                                child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10.0),
                                                    child: ExpansionTile(
                                                      leading: Icon(
                                                        Icons
                                                            .local_parking_outlined,
                                                        color: colorPrimary,
                                                        size: 35.0,
                                                      ),
                                                      title: Text(
                                                        rec['value']['name'],
                                                        style: TextStyle(
                                                            color: colorBlack,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16.0),
                                                      ),
                                                      subtitle: Text(
                                                        "Slots : ${rec['value']['slots']}",
                                                        style: TextStyle(
                                                            color: colorBlack,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14.0),
                                                      ),
                                                      trailing: Wrap(
                                                        children: [
                                                          IconButton(
                                                              onPressed: () =>
                                                                  openEnrollment(
                                                                      rec),
                                                              icon: Icon(
                                                                  Icons.edit,
                                                                  color:
                                                                      color12)),
                                                          IconButton(
                                                              onPressed: () => _databaseReference
                                                                  .child(FirebaseStructure
                                                                      .PARKINGS)
                                                                  .child(rec[
                                                                      'key'])
                                                                  .remove()
                                                                  .then((value) =>
                                                                      getData()),
                                                              icon: Icon(
                                                                  Icons.delete,
                                                                  color:
                                                                      colorRed))
                                                        ],
                                                      ),
                                                      expandedAlignment:
                                                          Alignment.centerLeft,
                                                      expandedCrossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      childrenPadding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 10.0),
                                                      backgroundColor: color8
                                                          .withOpacity(0.2),
                                                      children: [
                                                        Text(
                                                          "Mobile Number : ${rec['value']['phone']}",
                                                          style: TextStyle(
                                                              color: colorBlack,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14.0),
                                                        ),
                                                        Text(
                                                          "Address : ${rec['value']['address']}",
                                                          style: TextStyle(
                                                              color: colorBlack,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14.0),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          )
                                      ]),
                                )
                              : Center(
                                  child: Text(
                                    "No Data Found".toString().toUpperCase(),
                                    style: TextStyle(
                                        color: colorBlack,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.0),
                                  ),
                                ),
                        ),
                      ))
                ],
              )),
        ));
  }

  void openEnrollment(data) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController _name = TextEditingController();
    final TextEditingController _phone = TextEditingController();
    final TextEditingController _address = TextEditingController();
    final TextEditingController _lng = TextEditingController();
    final TextEditingController _ltd = TextEditingController();
    final TextEditingController _slots = TextEditingController();

    if (data != null) {
      _name.text = data['value']['name'];
      _phone.text = data['value']['phone'];
      _address.text = data['value']['address'];
      _lng.text = data['value']['lng'];
      _ltd.text = data['value']['ltd'];
      _slots.text = data['value']['slots'].toString();
    }

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10.0),
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                "${(data != null) ? 'Edit' : 'Add'} Parking",
                                style: TextStyle(
                                    color: colorBlack,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.0),
                              )),
                          Expanded(
                              flex: 0,
                              child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: Icon(
                                    Icons.close,
                                    color: colorRed,
                                  )))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Divider(
                          color: colorGrey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: CustomTextFormField(
                            height: 5.0,
                            controller: _name,
                            backgroundColor: color7,
                            iconColor: colorPrimary,
                            isIconAvailable: true,
                            hint: 'Parking Name',
                            icon: Icons.food_bank_outlined,
                            textInputType: TextInputType.text,
                            validation: (value) {
                              final validator = Validator(
                                validators: [const RequiredValidator()],
                              );
                              return validator.validate(
                                label: "TThis field cannot be empty",
                                value: value,
                              );
                            },
                            obscureText: false),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: CustomTextFormField(
                            height: 5.0,
                            controller: _phone,
                            backgroundColor: color7,
                            iconColor: colorPrimary,
                            isIconAvailable: true,
                            hint: 'Contact Number',
                            icon: Icons.phone_android_outlined,
                            textInputType: TextInputType.phone,
                            validation: (value) {
                              final validator = Validator(
                                validators: [const RequiredValidator()],
                              );
                              return validator.validate(
                                label: "TThis field cannot be empty",
                                value: value,
                              );
                            },
                            obscureText: false),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: CustomTextFormField(
                            height: 5.0,
                            controller: _address,
                            backgroundColor: color7,
                            iconColor: colorPrimary,
                            isIconAvailable: true,
                            hint: 'Address',
                            icon: Icons.map_outlined,
                            textInputType: TextInputType.text,
                            validation: (value) {
                              final validator = Validator(
                                validators: [const RequiredValidator()],
                              );
                              return validator.validate(
                                label: "TThis field cannot be empty",
                                value: value,
                              );
                            },
                            obscureText: false),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: CustomTextFormField(
                            height: 5.0,
                            controller: _lng,
                            backgroundColor: color7,
                            iconColor: colorPrimary,
                            isIconAvailable: true,
                            hint: 'Longitude',
                            icon: Icons.location_city_outlined,
                            textInputType: TextInputType.number,
                            validation: (value) {
                              final validator = Validator(
                                validators: [const RequiredValidator()],
                              );
                              return validator.validate(
                                label: "TThis field cannot be empty",
                                value: value,
                              );
                            },
                            obscureText: false),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: CustomTextFormField(
                            height: 5.0,
                            controller: _ltd,
                            backgroundColor: color7,
                            iconColor: colorPrimary,
                            isIconAvailable: true,
                            hint: 'Latitude',
                            icon: Icons.location_city_outlined,
                            textInputType: TextInputType.number,
                            validation: (value) {
                              final validator = Validator(
                                validators: [const RequiredValidator()],
                              );
                              return validator.validate(
                                label: "TThis field cannot be empty",
                                value: value,
                              );
                            },
                            obscureText: false),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: CustomTextFormField(
                            height: 5.0,
                            controller: _slots,
                            backgroundColor: color7,
                            iconColor: colorPrimary,
                            isIconAvailable: true,
                            hint: 'Slot Count',
                            icon: Icons.numbers_outlined,
                            textInputType: TextInputType.number,
                            validation: (value) {
                              final validator = Validator(
                                validators: [const RequiredValidator()],
                              );
                              return validator.validate(
                                label: "TThis field cannot be empty",
                                value: value,
                              );
                            },
                            obscureText: false),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: CustomButton(
                            buttonText: "Submit",
                            textColor: color6,
                            backgroundColor: colorPrimary,
                            isBorder: false,
                            borderColor: color6,
                            onclickFunction: () async {
                              FocusScope.of(context).unfocus();

                              if (_formKey.currentState!.validate()) {
                                CustomUtils.showLoader(context);

                                DatabaseReference ref = _databaseReference
                                    .child(FirebaseStructure.PARKINGS);

                                Map<String, dynamic> saveData = {
                                  "door": false,
                                  "name": _name.text,
                                  "phone": _phone.text,
                                  "address": _address.text,
                                  "lng": _lng.text,
                                  "ltd": _ltd.text,
                                  "slots": int.parse(_slots.text),
                                };

                                if (data != null) {
                                  await ref
                                      .child(data['key'])
                                      .update(saveData)
                                      .then((value) {
                                    CustomUtils.hideLoader(context);
                                    Navigator.pop(context);
                                    getData();
                                  });
                                } else {
                                  await ref.push().set(saveData).then((value) {
                                    CustomUtils.hideLoader(context);
                                    Navigator.pop(context);
                                    getData();
                                  });
                                }
                              }
                            }),
                      )
                    ],
                  )),
                )),
          );
        });
  }

  Future<void> getData() async {
    _databaseReference
        .child(FirebaseStructure.PARKINGS)
        .orderByPriority()
        .once()
        .then((DatabaseEvent data) {
      list.clear();
      setState(() {
        for (DataSnapshot element in data.snapshot.children) {
          dynamic value = element.value;
          list.add({'key': element.key, 'value': value});
        }
      });
    });
  }
}
