import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parkingexpress/Models/DB/User.dart';
import 'package:parkingexpress/Models/Utils/Colors.dart';
import 'package:parkingexpress/Models/Utils/Common.dart';
import 'package:parkingexpress/Models/Utils/FirebaseStructure.dart';
import 'package:parkingexpress/Models/Utils/Routes.dart';
import 'package:parkingexpress/Models/Utils/Utils.dart';
import 'package:intl/intl.dart';
import '../../Widgets/custom_text_datetime_chooser.dart';

class ParkingHistory extends StatefulWidget {
  const ParkingHistory({Key? key}) : super(key: key);

  @override
  State<ParkingHistory> createState() => _ParkingHistoryState();
}

class _ParkingHistoryState extends State<ParkingHistory> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  List<dynamic> list = [];

  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();
  bool useFilters = false;
  bool showFilters = false;

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
                                "Parking History",
                                style: TextStyle(fontSize: 16.0, color: color7),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    showFilters = !showFilters;
                                  });
                                },
                                child: Icon(
                                  (showFilters) ? Icons.menu_open : Icons.menu,
                                  color: colorWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  (showFilters)
                      ? AnimatedContainer(
                          duration: const Duration(seconds: 2),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Filter",
                                    style: TextStyle(
                                        fontSize: 16.0, color: colorBlack),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: CustomTextDateTimeChooser(
                                        height: 5.0,
                                        controller: start,
                                        backgroundColor: color7,
                                        iconColor: colorPrimary,
                                        isIconAvailable: true,
                                        hint: 'Start',
                                        icon: Icons.calendar_month,
                                        textInputType: TextInputType.text,
                                        validation: (value) {
                                          return null;
                                        },
                                        obscureText: false),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: CustomTextDateTimeChooser(
                                        height: 5.0,
                                        controller: end,
                                        backgroundColor: color7,
                                        iconColor: colorPrimary,
                                        isIconAvailable: true,
                                        hint: 'End',
                                        icon: Icons.calendar_month,
                                        textInputType: TextInputType.text,
                                        validation: (value) {
                                          return null;
                                        },
                                        obscureText: false),
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      height: 50.0,
                                      child: TextButton(
                                        style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  colorWhite),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  colorPrimary),
                                        ),
                                        onPressed: () async {
                                          useFilters = true;
                                          getData();
                                        },
                                        child: const Text(
                                          "Filter Records",
                                          style: TextStyle(),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
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
                                                        horizontal: 15.0,
                                                        vertical: 10.0),
                                                    child: ExpansionTile(
                                                      expandedCrossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      leading: Icon(
                                                        Icons.history_sharp,
                                                        color: colorBlack,
                                                        size: 35.0,
                                                      ),
                                                      title: Text(
                                                        rec['value']['parking']
                                                            .toString()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            color: colorBlack,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 15.0),
                                                      ),
                                                      subtitle: Text(
                                                        getDateTime(rec['value']
                                                            ['timestamp']),
                                                        style: TextStyle(
                                                            color: color15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12.0),
                                                      ),
                                                      trailing: Text(
                                                        "LKR ${calculatePrice(DateTime.fromMillisecondsSinceEpoch(rec['value']['departure']).difference(DateTime.fromMillisecondsSinceEpoch(rec['value']['arrival'])))}.00",
                                                        style: TextStyle(
                                                            color: color15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16.0),
                                                      ),
                                                      expandedAlignment:
                                                          Alignment.centerLeft,
                                                      children: [
                                                        if (CustomUtils
                                                                .loggedInUser!
                                                                .type ==
                                                            LoggedUser.Admin)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10.0),
                                                            child: Text(
                                                              "User : ${rec['value']['name'].toString()}",
                                                              style: TextStyle(
                                                                  color:
                                                                      color15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      14.0),
                                                            ),
                                                          ),
                                                        if (CustomUtils
                                                                .loggedInUser!
                                                                .type ==
                                                            LoggedUser.Admin)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10.0),
                                                            child: Text(
                                                              "Email : ${rec['value']['email'].toString()}",
                                                              style: TextStyle(
                                                                  color:
                                                                      color15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      14.0),
                                                            ),
                                                          ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      10.0),
                                                          child: Text(
                                                            "Duration : ${DateTime.fromMillisecondsSinceEpoch(rec['value']['departure']).difference(DateTime.fromMillisecondsSinceEpoch(rec['value']['arrival'])).inHours} Hours",
                                                            style: TextStyle(
                                                                color: color15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14.0),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      10.0),
                                                          child: Text(
                                                            "Arrival Time : ${getDateTime(rec['value']['arrival'])}",
                                                            style: TextStyle(
                                                                color: color15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14.0),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      10.0),
                                                          child: Text(
                                                            "Departure Time : ${getDateTime(rec['value']['departure'])}",
                                                            style: TextStyle(
                                                                color: color15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14.0),
                                                          ),
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

  String getDateTime(int mills) {
    return DateFormat('yyyy/MM/dd hh:mm a')
        .format(DateTime.fromMillisecondsSinceEpoch(mills));
  }

  Future<void> getData() async {
    if (CustomUtils.loggedInUser!.type == LoggedUser.Admin) {
      _databaseReference
          .child(FirebaseStructure.BOOKINGS)
          .once()
          .then((DatabaseEvent data) {
        list.clear();
        for (DataSnapshot element in data.snapshot.children) {
          dynamic value = element.value;
          if (useFilters == true &&
              start.text.isNotEmpty &&
              end.text.isNotEmpty) {
            DateTime currentDateTime =
                DateTime.fromMillisecondsSinceEpoch(value['timestamp'] as int);
            if (currentDateTime.isAfter(
                    DateFormat("yyyy/MM/dd hh:mm a").parse(start.text)) &&
                currentDateTime.isBefore(
                    DateFormat("yyyy/MM/dd hh:mm a").parse(end.text))) {
              list.add({'key': element.key, 'value': value});
            }
          } else {
            list.add({'key': element.key, 'value': value});
          }
        }
        setState(() {
          useFilters = false;
        });
      });
    } else {
      _databaseReference
          .child(FirebaseStructure.BOOKINGS)
          .orderByChild('user')
          .equalTo(CustomUtils.loggedInUser!.uid)
          .once()
          .then((DatabaseEvent data) {
        list.clear();
        for (DataSnapshot element in data.snapshot.children) {
          dynamic value = element.value;
          if (useFilters == true &&
              start.text.isNotEmpty &&
              end.text.isNotEmpty) {
            DateTime currentDateTime =
                DateTime.fromMillisecondsSinceEpoch(value['timestamp'] as int);
            if (currentDateTime.isAfter(
                    DateFormat("yyyy/MM/dd hh:mm a").parse(start.text)) &&
                currentDateTime.isBefore(
                    DateFormat("yyyy/MM/dd hh:mm a").parse(end.text))) {
              list.add({'key': element.key, 'value': value});
            }
          } else {
            list.add({'key': element.key, 'value': value});
          }
        }
        setState(() {
          useFilters = false;
        });
      });
    }
  }

  String calculatePrice(Duration difference) {
    return (difference.inHours == 0
        ? "100"
        : (difference.inHours * 100).toString());
  }
}
