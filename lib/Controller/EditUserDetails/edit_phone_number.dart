import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/database.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:OpenAndBuy/Controller/constant.dart';

class EditPhoneNumber extends StatefulWidget {
  @override
  _EditPhoneNumberState createState() => _EditPhoneNumberState();
}

UserDetail userDetail;

class _EditPhoneNumberState extends State<EditPhoneNumber> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String newPhoneNumber = '';
  Map<String, String> phone = {'number': '', 'name': '', 'code': ''};
  String error = '';
  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    userDetail = userNotifier.userDetail;
    //phone = userDetail.phone;
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
                      'Phone Number',
                      style: TextStyle(color: Colors.grey, fontSize: 17.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        countryCodePicker(),
                        // SizedBox(height: 10.0,),
                        Padding(
                          padding: const EdgeInsets.only(top: 45.0),
                          child: Container(
                            width: 200,
                            height: 100,
                            child: TextFormField(
                                initialValue: userDetail.phone['number'],
                                decoration: textInputDecoration('Phone Number').copyWith(
                                   hintText: 'Phone Number'),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                // countrol the max chars in the first name
                                maxLength: 15,
                                validator: (val) => val.isEmpty || val == ''
                                    ? 'Enter Your Phone Number'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    newPhoneNumber = val;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
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
                            if (_formKey.currentState.validate() &&
                                phone['number'] != null) {
                              setState(() {
                                loading = true;
                              });
                              try {
                                 
                                   
                                (newPhoneNumber != '' && newPhoneNumber != null)
                                    ? phone['number'] = newPhoneNumber
                                    : phone['number'] =
                                        userDetail.phone['number'];

                                print(newPhoneNumber + ' HERE IS THE NAM');
                                DatabaseService.updatePhoneData(
                                    'phone', phone, userDetail.userID);
                                loading = false;
                                Navigator.of(context).pop(true);
                              } catch (e) {
                                print(e);
                                setState(() {
                                  error = 'Please supply a valid phone Number';
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
              )
              ),
        ));
  }

  countryCodePicker() {
    return Center(
      child: CountryCodePicker(
        onChanged: (code) {
          phone['code'] = code.dialCode;
          phone['name'] = code.name;
          // print("on init ${code.name} ${code.dialCode} ${code.name}");
        }, //print(e.name +" JJ"),//print
        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
        initialSelection: userDetail.phone['name'],
        // favorite: ['+39','FR'],
        // optional. Shows only country name and flag
        showCountryOnly: false,
        // optional. Shows only country name and flag when popup is closed.
        showOnlyCountryWhenClosed: false,
        // optional. aligns the flag and the Text left
        alignLeft: false,
        onInit: (code) {
          phone['code'] = code.dialCode;
          phone['name'] = code.name;
          print("on initttt ${code.name} ${code.dialCode} ${code.name}");
        },
      ),
    );
  }
}
