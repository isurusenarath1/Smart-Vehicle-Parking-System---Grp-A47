import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isPasswordVisible = false;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/ragistation.jpg"),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Registration",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Login",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16), // Add space between rows
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Your Name",
                    ),
                  ),
                  SizedBox(height: 16), // Add space between rows
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Your NIC Number",
                    ),
                  ),
                  SizedBox(height: 16), // Add space between rows
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Your Email Address",
                    ),
                  ),
                  SizedBox(height: 16), // Add space between rows
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Your User Name",
                    ),
                  ),
                  SizedBox(height: 16), // Add space between rows
                  TextField(
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: "Enter Your Password",
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          _isPasswordVisible = !_isPasswordVisible;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      _getImageFromGallery(context);
                    },
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Add Your Profile Photo",
                      ),
                    ),
                  ),

                  SizedBox(height: 16), // Add space between rows
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromARGB(70, 61, 61, 1)
                                .withOpacity(.5),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.facebook,
                            color: Color.fromARGB(255, 9, 8, 8).withOpacity(.5),
                          ),
                        ),
                      ),
                      SizedBox(width: 28),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                Color.fromRGBO(70, 61, 61, 1).withOpacity(.5),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.chat,
                            color: const Color.fromARGB(255, 19, 18, 18)
                                .withOpacity(.5),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromRGBO(229, 208, 30, 1),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Do something with the picked image (e.g., display it)
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Selected Image"),
          content: Image.file(File(pickedImage.path)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}
