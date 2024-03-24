import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parkingexpress/Models/DB/User.dart';
import 'package:parkingexpress/Models/Utils/Colors.dart';
import 'package:parkingexpress/Models/Utils/Common.dart';
import 'package:parkingexpress/Models/Utils/FirebaseStructure.dart';
import 'package:parkingexpress/Models/Utils/Routes.dart';
import 'package:parkingexpress/Models/Utils/Utils.dart';
import '../../Widgets/custom_text_datetime_chooser.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
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
                                "Users",
                                style: TextStyle(fontSize: 16.0, color: color7),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  getData();
                                },
                                child: Icon(
                                  Icons.refresh,
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
                                                        horizontal: 15.0,
                                                        vertical: 10.0),
                                                    child: ExpansionTile(
                                                      expandedCrossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      leading: Icon(
                                                        Icons.person_2_outlined,
                                                        color: colorBlack,
                                                        size: 35.0,
                                                      ),
                                                      title: Text(
                                                        rec['value']['name']
                                                            .toString()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            color: colorBlack,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 15.0),
                                                      ),
                                                      subtitle: Text(
                                                        rec['value']['email'],
                                                        style: TextStyle(
                                                            color: color15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12.0),
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
                                                              "NIC Number : ${rec['value']['nic'].toString()}",
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
                                                              "Mobile Number : ${rec['value']['mobile'].toString()}",
                                                              style: TextStyle(
                                                                  color:
                                                                      color15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      14.0),
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

  Future<void> getData() async {
    _databaseReference
        .child(FirebaseStructure.USERS)
        .orderByChild('type')
        .equalTo(1)
        .once()
        .then((DatabaseEvent data) {
      list.clear();
      for (DataSnapshot element in data.snapshot.children) {
        dynamic value = element.value;
        list.add({'key': element.key, 'value': value});
      }
      setState(() {});
    });
  }
}
