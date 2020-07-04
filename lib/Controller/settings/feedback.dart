import 'package:OpenAndBuy/Model/localization/localizationConstants.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/storeDatabase.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  String value(String key) {
    return "Thank you"; //getTranslated(context, key);
  }

  final _formKey = GlobalKey<FormState>();
  String feedback = '';
  String subject = '';
  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    userNotifier.getUserInfo();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text(value('feedback')),
      ),
      body: Builder(
        builder: (context) => Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      value('feedbackNote'),
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: value('subject'),
                      ),
                      keyboardType: TextInputType.multiline,
                      // decoration: textInputDecoration.copyWith(hintText:'First Name'),
                      validator: (val) => val.isEmpty || val == '' ? '' : null,
                      onChanged: (val) {
                        setState(() {
                          subject = val;
                        });
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: value('feedbackBody'),
                      ),
                      keyboardType: TextInputType.multiline,
                      // decoration: textInputDecoration.copyWith(hintText:'First Name'),
                      validator: (val) => val.isEmpty || val == '' ? '' : null,
                      onChanged: (val) {
                        setState(() {
                          feedback = val;
                        });
                      }),
                  SizedBox(
                    height: 50.0,
                  ),
                  Center(
                    child: ButtonTheme(
                      minWidth: 300,
                      height: 55,
                      child: RaisedButton(
                        elevation: 0.0,
                        color: Colors.pink[400],
                        highlightColor: Colors.red,
                        child: Text(
                          value('submit'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await StoreDatabaseService.sendFeedback(
                                userNotifier.userDetail.userID,
                                subject,
                                feedback);
                            // return TRUE to the previous page to show the SnackBar
                            Navigator.of(context).pop(true);
                            showAlertDialog(context);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  BuildContext dialogContext;

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(value('close')),
      onPressed: () {
        Navigator.pop(dialogContext);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(value('feedbackRecieved')),
      content: Text(value('feedbackThanks')),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        dialogContext = context;
        return alert;
      },
    );
  }
}
