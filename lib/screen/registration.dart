// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cart/common/constants.dart';
import 'package:cart/data/user_sqlite_helper.dart';
import 'package:cart/model/user_model.dart';
import 'package:cart/screen/login.dart';
import 'package:cart/screen/tab_view.dart';
import 'package:cart/widget/button.dart';
import 'package:cart/widget/cart_text.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final UserDataModel _userDataModel = UserDataModel();
  final UserDbProvider _userDbProvider = UserDbProvider();
  bool obscureText = true;
  void _submitResult(context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    var status = await _userDbProvider.addItem(_userDataModel, userTableDb);

    if (status == 1) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Login()));
      return;
    } else {
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {

    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text("please try again later"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void toggle() {
    setState(() {
      if (obscureText) {
        obscureText = false;
      } else {
        obscureText = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Container(
                      height: mediaQueryHeight - 200,
                      decoration: BoxDecoration(

                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 6.0,
                            ),
                          ],
                          border: Border.all(
                            color: Color.fromRGBO(200, 200, 200, 0),
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 10, right: 10),
                        child: Column(children: [
                          Text(
                            "Register",
                            style: TextStyle(fontSize: 28),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CartTextBox(
                              withAsterisk: true,
                              labelText: "Username",
                              hintText: "Please Enter the UserName",
                              onError: (value) {
                                if (value.isEmpty) {
                                  return 'Thisfieldisrequired';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _userDataModel.userName = value;
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CartTextBox(
                              withAsterisk: true,
                              labelText: "Password",
                              obscureText: obscureText,
                              hintText: "Please Enter the Password",
                              onError: (value) {
                                if (value.isEmpty) {
                                  return 'Thisfieldisrequired';
                                }
                                return null;
                              },
                              suffixIcon: obscureText
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              suffixIconEvent: toggle,
                              onSaved: (value) {
                                _userDataModel.password = value;
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CartTextBox(
                              withAsterisk: true,
                              labelText: "Dob",
                              hintText: "Please Enter the Dob",
                              onError: (value) {
                                if (value.isEmpty) {
                                  return 'Thisfieldisrequired';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _userDataModel.dob = value;
                              },
                            ),
                          ),
                         
                          Container(
                            constraints: const BoxConstraints(
                                maxWidth: 300, minWidth: 120, minHeight: 50),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: TextButton(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) => secondaryColor),
                                  backgroundColor: MaterialStateProperty.all(
                                      secondaryTextColor),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: secondaryTextColor, width: 2),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  _submitResult(context);
                                },
                               
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                
                                  child: Text(
                                    "SignUp",
                                    
                                    style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 14,
                                      fontWeight: fontWeight600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
