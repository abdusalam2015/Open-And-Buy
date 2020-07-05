import 'package:OpenAndBuy/Controller/constant.dart';
import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/database.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditLastName extends StatefulWidget {
  @override
  _EditLastNameState createState() => _EditLastNameState();
}

UserDetail userDetail;

class _EditLastNameState extends State<EditLastName> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String newLastName = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    userDetail = userNotifier.userDetail;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop()),
        ),
        body: Builder(
          builder: (context) => Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'First Name',
                      style: TextStyle(color: Colors.grey, fontSize: 17.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        initialValue: userDetail.lastName,
                        decoration: textInputDecoration('Last Name')
                            .copyWith(hintText: 'Last Name'),
                        // countrol the max chars in the first name
                        maxLength: 15,
                        validator: (val) => val.isEmpty || val == ''
                            ? 'Enter Your Last Name'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            newLastName = val;
                          });
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: ButtonTheme(
                        minWidth: 300,
                        height: 55,
                        child: RaisedButton(
                          elevation: 0.0,
                          color: BUTTONCOLOR,
                          highlightColor: Colors.red,
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              try {
                                await DatabaseService.updateLastName(
                                    newLastName, userDetail.userID);
                                loading = false;
                                // return TRUE to the previous page to show the SnackBar
                                Navigator.of(context).pop(true);
                              } catch (e) {
                                print(e);
                                setState(() {
                                  error = 'Please supply a valid Name';
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              )),
        ));
  }
}
