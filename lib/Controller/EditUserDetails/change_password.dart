import 'package:OpenAndBuy/Controller/constant.dart';
import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Model/localization/localizationConstants.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/auth.dart';
import 'package:OpenAndBuy/Service/store_notifier.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

UserDetail userDetail;

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String _currentPassword = '';
  String _newPassword = '';
  String _confirmation = '';

  String error = '';
  @override
  Widget build(BuildContext context) {
     String value(String key) {
    return getTranslated(context, key);
  }
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
          builder: (context) => ListView(
            children: <Widget>[
              Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          value('changePassword'),
                          style: TextStyle(color: Colors.black, fontSize: 17.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                            initialValue: '',
                            decoration:
                                textInputDecoration(value('currentPassword')).copyWith(
                              hintText: value('currentPassword'),
                            ),
                            obscureText: true,
                            // countrol the max chars in the first name
                            validator: (val) => val.length < 6
                                ? value('passwordNotCorrect')
                                : null,
                            onChanged: (val) {
                              setState(() {
                                _currentPassword = val;
                              });
                            }),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                            initialValue: '',
                            decoration:
                                textInputDecoration(value('newPassword')).copyWith(
                              hintText: value('newPassword'),
                            ),
                            obscureText: true,
                            // countrol the max chars in the first name
                            validator: (val) => val.length < 6
                                ? value('passwordValidate')
                                : null,
                            onChanged: (val) {
                              setState(() {
                                _newPassword = val;
                              });
                            }),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                            initialValue: '',
                            decoration: textInputDecoration(value('confirmPassword'))
                                .copyWith(
                              hintText: value('confirmPassword'),
                            ),
                            obscureText: true,
                            // countrol the max chars in the first name
                            validator: (val) => val.length < 6
                                ? value('passwordValidate')
                                : null,
                            onChanged: (val) {
                              setState(() {
                                _confirmation = val;
                              });
                              //This operation is sensitive and requires recent authentication. Log in again before retrying this request
                            }),
                        SizedBox(
                          height: 5.0,
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
                                value('changePassword'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                              onPressed: () async {
                                //  bool rightPassword = true;//checkCurrentPassword(_currentPassword);
                                if (_formKey.currentState.validate() &&
                                    (_confirmation == _newPassword)) {
                                  setState(() {
                                    loading = true;
                                  }); 
                                  try {
                                    // we need to handle the error first ( please login again)
                                    // await AuthService.changePassword(_newPassword,_currentPassword,storeDetail.email);

                                  } catch (e) {
                                    setState(() {
                                      error =
                                          value('currentNotCorrect');
                                      loading = false;
                                    });
                                  }
                                } else if (_confirmation != _newPassword) {
                                  setState(() {
                                    error =
                                        value('passwordsNotMatched');
                                    loading = false;
                                  });
                                } else {
                                  setState(() {
                                    error = value('passwordValidate');
                                    loading = false;
                                  });
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
            ],
          ),
        ));
  }
}
