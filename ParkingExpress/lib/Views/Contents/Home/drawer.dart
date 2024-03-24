import 'package:parkingexpress/Models/DB/User.dart';
import 'package:parkingexpress/Views/AdminContents/Management/parking-management.dart';
import 'package:flutter/material.dart';
import 'package:parkingexpress/Controllers/AuthController.dart';
import 'package:parkingexpress/Models/Utils/Colors.dart';
import 'package:parkingexpress/Models/Utils/Common.dart';
import 'package:parkingexpress/Models/Utils/Images.dart';
import 'package:parkingexpress/Models/Utils/Routes.dart';
import 'package:parkingexpress/Models/Utils/Utils.dart';
import 'package:parkingexpress/Views/AdminContents/Management/user-managvement.dart';
import 'package:parkingexpress/Views/Contents/History/history.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key? key}) : super(key: key);

  AuthController _authController = AuthController();

  List<Widget> userMenus = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: displaySize.width * 0.8,
      decoration: BoxDecoration(color: color6),
      child: ListView(
        children: [
          SizedBox(
            width: double.infinity,
            height: displaySize.height * 0.15,
            child: Container(
                decoration: BoxDecoration(color: colorPrimary),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 12.0, left: 15.0, right: 15.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 60.0,
                          width: 60.0,
                          child: ClipOval(
                            child: Image.asset(
                              user,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  CustomUtils.loggedInUser!.name,
                                  style: TextStyle(
                                      color: color6,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  CustomUtils.loggedInUser!.email,
                                  style: TextStyle(
                                      color: color6,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                )),
          ),
          ListTile(
            onTap: () => Navigator.pop(context),
            tileColor: color6,
            leading: Icon(
              Icons.home_outlined,
              color: color15,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                  color: color15, fontWeight: FontWeight.w400, fontSize: 15.0),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: color15,
              size: 15.0,
            ),
          ),
          if (CustomUtils.loggedInUser!.type == LoggedUser.Admin)
            ListTile(
              onTap: () =>
                  Routes(context: context).navigate(const ParkingManagement()),
              tileColor: color6,
              leading: Icon(
                Icons.local_parking_outlined,
                color: color15,
              ),
              title: Text(
                'Parking Management',
                style: TextStyle(
                    color: color15,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: color15,
                size: 15.0,
              ),
            ),
          ListTile(
            onTap: () =>
                Routes(context: context).navigate(const ParkingHistory()),
            tileColor: color6,
            leading: Icon(
              Icons.history_edu_outlined,
              color: color15,
            ),
            title: Text(
              'History',
              style: TextStyle(
                  color: color15, fontWeight: FontWeight.w400, fontSize: 15.0),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: color15,
              size: 15.0,
            ),
          ),
          if (CustomUtils.loggedInUser!.type == LoggedUser.Admin)
            ListTile(
              onTap: () => Routes(context: context).navigate(const UsersList()),
              tileColor: color6,
              leading: Icon(
                Icons.person_2_outlined,
                color: color15,
              ),
              title: Text(
                'Users',
                style: TextStyle(
                    color: color15,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: color15,
                size: 15.0,
              ),
            ),
          ListTile(
            onTap: () => _authController.logout(context),
            tileColor: color6,
            leading: Icon(
              Icons.logout_outlined,
              color: color15,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                  color: color15, fontWeight: FontWeight.w400, fontSize: 15.0),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: color15,
              size: 15.0,
            ),
          ),
        ],
      ),
    );
  }
}
