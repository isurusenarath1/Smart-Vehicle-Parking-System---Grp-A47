import 'dart:io';

import 'package:parkingexpress/Models/DB/User.dart';
import 'package:parkingexpress/Models/Utils/FirebaseStructure.dart';
import 'package:parkingexpress/Models/Utils/Utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parkingexpress/Models/Strings/app.dart';
import 'package:parkingexpress/Models/Utils/Colors.dart';
import 'package:parkingexpress/Models/Utils/Common.dart';
import 'package:parkingexpress/Models/Utils/Images.dart';
import 'package:parkingexpress/Views/Contents/Home/drawer.dart';
import 'package:parkingexpress/Views/Widgets/custom_button.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  List<dynamic> list = [];
  List<String> parkingKeys = [];

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  bool hasParking = false;

  bool showQR = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getData();
    });
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (CustomUtils.loggedInUser!.type == LoggedUser.User) {
      if (Platform.isAndroid) {
        controller!.pauseCamera();
      } else if (Platform.isIOS) {
        controller!.resumeCamera();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: color7,
        drawer: HomeDrawer(),
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
                                onTap: () => (_scaffoldKey
                                        .currentState!.isDrawerOpen)
                                    ? _scaffoldKey.currentState!.openEndDrawer()
                                    : _scaffoldKey.currentState!.openDrawer(),
                                child: Icon(
                                  Icons.menu_rounded,
                                  color: colorWhite,
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: displaySize.width * 0.08,
                                    child: Image.asset(logo),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      app_name,
                                      style: TextStyle(
                                          fontSize: 16.0, color: color7),
                                    ),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () => setState(() {
                                  if (CustomUtils.loggedInUser!.type ==
                                      LoggedUser.User) {
                                    setState(() {
                                      showQR = !showQR;
                                      firstDetection = showQR;
                                    });

                                    // try {
                                    //   if (controller != null) {
                                    //     if (showQR) {
                                    //       print('resumt');
                                    //       controller!.pauseCamera();
                                    //       controller!.resumeCamera();
                                    //     } else {
                                    //       print('pause');
                                    //       controller!.pauseCamera();
                                    //     }
                                    //   }
                                    // } catch (e) {}
                                  } else {
                                    getData();
                                  }
                                }),
                                child: Icon(
                                  (CustomUtils.loggedInUser!.type ==
                                          LoggedUser.User)
                                      ? ((showQR)
                                          ? Icons.qr_code_scanner_outlined
                                          : Icons.qr_code_2_outlined)
                                      : Icons.refresh,
                                  color: colorWhite,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                  if (!showQR && hasParking)
                    Expanded(
                        flex: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Center(
                            child: Text(
                              "You have ongoing parking",
                              style: TextStyle(
                                  fontSize: 20.0, color: colorPrimary),
                            ),
                          ),
                        )),
                  if (showQR)
                    Expanded(
                        flex: 0,
                        child: SizedBox(
                          width: displaySize.width * 0.5,
                          height: displaySize.width * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: QRView(
                              key: qrKey,
                              onQRViewCreated: _onQRViewCreated,
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
                                                        "Available Slots : ${rec['value']['slots']}",
                                                        style: TextStyle(
                                                            color: colorBlack,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14.0),
                                                      ),
                                                      trailing: Wrap(
                                                        children: [
                                                          IconButton(
                                                              onPressed: () => CustomUtils.openMap(
                                                                  context,
                                                                  double.parse(
                                                                      rec['value']
                                                                          [
                                                                          'ltd']),
                                                                  double.parse(rec[
                                                                          'value']
                                                                      ['lng'])),
                                                              icon: Icon(
                                                                  Icons
                                                                      .map_outlined,
                                                                  color:
                                                                      color14)),
                                                          IconButton(
                                                              onPressed: () =>
                                                                  CustomUtils.call(
                                                                      context,
                                                                      rec['value']
                                                                          [
                                                                          'phone']),
                                                              icon: Icon(
                                                                  Icons
                                                                      .phone_android_outlined,
                                                                  color:
                                                                      color2))
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

  Future<void> getData() async {
    initListener();
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
          parkingKeys.add(element.key!);
        }
      });
    });
  }

  bool firstDetection = true;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      if (result != null && firstDetection) {
        firstDetection = false;
        String code = result!.code!;
        setState(() {
          showQR = !showQR;
        });
        if (!showQR) {
          checkData(code);
        }

        sleep(const Duration(seconds: 2));
      }
    });
  }

  Future<void> checkData(String code) async {
    if (parkingKeys.contains(code)) {
      await addNewParking(code);
      await openDoor(code);
    } else {
      CustomUtils.showSnackBarMessage(
          context, "Invalid QR Code", CustomUtils.ERROR_SNACKBAR);
    }
  }

  Future<void> addNewParking(String parking) async {
    _databaseReference
        .child(FirebaseStructure.PARKINGS)
        .child(parking)
        .child(FirebaseStructure.BOOKINGS)
        .child(CustomUtils.loggedInUser!.uid)
        .orderByChild("status")
        .equalTo(1)
        .once()
        .then((value) async {
      if (value.snapshot.exists) {
        await _databaseReference
            .child(FirebaseStructure.USERS)
            .child(CustomUtils.loggedInUser!.uid)
            .child('parked')
            .remove();

        await _databaseReference
            .child(FirebaseStructure.PARKINGS)
            .child(parking)
            .child("slots")
            .set(ServerValue.increment(1));

        await getData();

        //exit
        _databaseReference
            .child(FirebaseStructure.PARKINGS)
            .child(parking)
            .child(FirebaseStructure.BOOKINGS)
            .child(CustomUtils.loggedInUser!.uid)
            .child(value.snapshot.children.first.key!)
            .update({
          'status': 2,
          'departure': DateTime.now().millisecondsSinceEpoch,
        }).then((valuea) {
          _databaseReference
              .child(FirebaseStructure.PARKINGS)
              .child(parking)
              .once()
              .then((valueParking) {
            dynamic valueParkingData = valueParking.snapshot.value;
            CustomUtils.showSnackBarMessage(
                context,
                "Departure Successfully Confirmed.",
                CustomUtils.ERROR_SNACKBAR);
            CustomUtils.showLoader(context);
            _databaseReference
                .child(FirebaseStructure.PARKINGS)
                .child(parking)
                .child(FirebaseStructure.BOOKINGS)
                .child(CustomUtils.loggedInUser!.uid)
                .child(value.snapshot.children.first.key!)
                .once()
                .then((value) async {
              dynamic pastData = value.snapshot.value;

              await _databaseReference
                  .child(FirebaseStructure.BOOKINGS)
                  .push()
                  .set({
                'user': CustomUtils.loggedInUser!.uid,
                'timestamp': pastData['arrival'],
                'parking': valueParkingData['name'],
                'name': CustomUtils.loggedInUser!.name,
                'email': CustomUtils.loggedInUser!.email,
                'arrival': pastData['arrival'],
                'departure': pastData['departure'],
              });

              CustomUtils.hideLoader(context);
              initListener();
              showPriceModalSheet(
                  DateTime.fromMillisecondsSinceEpoch(pastData['departure'])
                      .difference(DateTime.fromMillisecondsSinceEpoch(
                          pastData['arrival'])));
            });
          });
        });
      } else {
        //enter

        await _databaseReference
            .child(FirebaseStructure.USERS)
            .child(CustomUtils.loggedInUser!.uid)
            .update({'parked': true});

        await _databaseReference
            .child(FirebaseStructure.PARKINGS)
            .child(parking)
            .child("slots")
            .set(ServerValue.increment(-1));

        await getData();

        _databaseReference
            .child(FirebaseStructure.PARKINGS)
            .child(parking)
            .child(FirebaseStructure.BOOKINGS)
            .child(CustomUtils.loggedInUser!.uid)
            .push()
            .set({
          'isNew': true,
          'status': 1,
          'arrival': DateTime.now().millisecondsSinceEpoch,
        }).then((value) {
          initListener();
          CustomUtils.showSnackBarMessage(
              context, "Successfully Arrived", CustomUtils.SUCCESS_SNACKBAR);
        });
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void showPriceModalSheet(Duration duration) {
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
                                "Your Parking Duration : ${duration.inHours} Hours",
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
                        child: Center(
                          child: Text(
                            "LKR : ${(duration.inHours == 0 ? '100' : (duration.inHours * 100))}.00",
                            style: TextStyle(
                                color: colorBlack,
                                fontWeight: FontWeight.w400,
                                fontSize: 25.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: CustomButton(
                            buttonText: "OK",
                            textColor: color6,
                            backgroundColor: colorPrimary,
                            isBorder: false,
                            borderColor: color6,
                            onclickFunction: () async {
                              Navigator.pop(context);
                            }),
                      )
                    ],
                  )),
                )),
          );
        });
  }

  void initListener() {
    _databaseReference
        .child(FirebaseStructure.USERS)
        .child(CustomUtils.loggedInUser!.uid)
        .child('parked')
        .once()
        .then((value) {
      setState(() {
        hasParking = value.snapshot.exists;
      });
    });
  }

  Future<void> openDoor(String code) async {
    await _databaseReference
        .child(FirebaseStructure.PARKINGS)
        .child(code)
        .update({'door': true});
  }
}
