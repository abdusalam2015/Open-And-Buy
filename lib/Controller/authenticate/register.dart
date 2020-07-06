import 'package:OpenAndBuy/Controller/alert_message.dart';
import 'package:OpenAndBuy/Controller/constant.dart';
import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Controller/loading.dart';
import 'package:OpenAndBuy/Model/localization/localizationConstants.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/auth.dart';
import 'package:OpenAndBuy/Service/shared_functions.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'dart:io';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = new AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email;
  String password, confPassword, newPhoneNumber;
  String error = '',
      error_terms = '',
      passwordsDontMatch = '',
      passwordsMatch = '';
  File img;
  String firstName, lastName;
  bool isUploaded = false;
  Map<String, String> phone = {'name': '', 'code': '', 'number': ''};
  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.pink[50],
            appBar: AppBar(
              backgroundColor: APPBARCOLOR,
              elevation: 0.0,
              title: Text('Register'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Sign In')),
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                          decoration: textInputDecoration('First Name')
                              .copyWith(hintText: 'First Name'),
                          validator: (val) => val.isEmpty || val == ''
                              ? 'Enter Your First Name'
                              : null,
                          onChanged: (val) {
                            setState(() {
                              firstName = val;
                            });
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                          decoration: textInputDecoration('Last Name')
                              .copyWith(hintText: 'Last Name'),
                          validator: (val) => val.isEmpty || val == ''
                              ? 'Enter Your Last Name'
                              : null,
                          onChanged: (val) {
                            setState(() {
                              lastName = val;
                            });
                          }),
                          SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                          decoration: textInputDecoration('Email')
                              .copyWith(hintText: 'Email'),
                          validator: (val) => val.isEmpty || val == ''
                              ? 'Enter an email'
                              : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                          decoration: textInputDecoration(
                                  getTranslated(context, 'password'))
                              .copyWith(
                                  hintText: getTranslated(context, 'password')),
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? getTranslated(context, 'passwordValidate')
                              : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                          decoration: textInputDecoration(
                                  getTranslated(context, 'confirmation'))
                              .copyWith(
                                  hintText:
                                      getTranslated(context, 'confPassword')),
                          obscureText: true,
                          validator: (val) => confPassword != password
                              ? getTranslated(context, 'passwordsNotMatched')
                              : null,
                          onChanged: (val) {
                            setState(() {
                              confPassword = val;
                            });
                          }),
                      Row(
                        children: <Widget>[
                          countryCodePicker(),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Container(
                              width: 200,
                              height: 100,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                        initialValue:
                                            '', //storeDetail.phone['number'],
                                        decoration: textInputDecoration(
                                                getTranslated(
                                                    context, 'phoneNumber'))
                                            .copyWith(
                                                hintText: getTranslated(
                                                    context, 'phoneNumber')),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        // countrol the max chars in the first name
                                        maxLength: 15,
                                        validator: (val) =>
                                            val.isEmpty || val == ''
                                                ? getTranslated(
                                                    context, 'phoneInput')
                                                : null,
                                        onChanged: (val) {
                                          setState(() {
                                            phone['number'] = val;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
                      //addProfileImage(),
                      SizedBox(
                        height: 20.0,
                      ),
                      checkBoxFunction(),
                      RaisedButton(
                        color: BUTTONCOLOR,
                        child: Text(
                          getTranslated(context, 'register'),
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          print(checkedValue);

                          if (_formKey.currentState.validate()) {
                            if (checkedValue) {
                              setState(() {
                                error_terms = '';
                                loading = true;
                              });
                              LocationResult myLocation =
                                  await showLocationPicker(
                                context,
                                'AIzaSyBwq6jURpuskUG8UoYj7IOJf_B3o0oRims',
                                automaticallyAnimateToCurrentLocation: true,
                                //initialCenter: LatLng(31.1975844, 29.9598339)
                                myLocationButtonEnabled: true,
                                layersButtonEnabled: true,
                              );
                              String latitude = '',
                                  longitude = '',
                                  address = '';
                              if (myLocation != null) {
                                latitude =
                                    myLocation.latLng.latitude.toString();
                                longitude =
                                    myLocation.latLng.longitude.toString();
                                address = myLocation.address;
                              }
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                    firstName,lastName, email, password,
                                       myLocation,phone );
                              if (result == null) {
                                setState(() {
                                  error =
                                      getTranslated(context, 'emailValidation');
                                  loading = false;
                                });
                              } else {}
                            } else {
                              setState(() {
                                error_terms = getTranslated(
                                    context, 'termsAndConditions');
                                loading = false;
                              });
                            }
                          }
                        },
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
          );
  }

  addProfileImage() {
    return Column(
      children: <Widget>[
        Text(getTranslated(context, 'profileImage'),
            style: TextStyle(fontSize: 18, color: Colors.black)),
        SizedBox(height: 10),
        RaisedButton(
          child: Text(getTranslated(context, 'browse'),
              style: TextStyle(fontSize: 18, color: BUTTONCOLOR)),
          onPressed: () async {
            try {
              final SharedFunctions sharedfun = new SharedFunctions();
              img = await sharedfun.getImage();
              setState(() {});
            } catch (e) {
              print(e);
            }
          },
        ),
        SizedBox(height: 30),
        img != null ? Image(image: FileImage(img)) : Container(),
        // Center(
        //   child: Container(child: isUploaded ?  FileImage(img):Container(),),
        // ),
      ],
    );
  }

  countryCodePicker() {
    return Expanded(
      flex: 1,
      child: CountryCodePicker(
        ///dialogSize: 12.0,
        onChanged: (code) {
          phone['code'] = code.dialCode;
          phone['name'] = code.name;
        },
        initialSelection: '',
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
        },
      ),
    );
  }

  Widget checkBoxFunction() {
    return CheckboxListTile(
      title: Column(
        children: <Widget>[
          InkWell(
            child: Text(
              getTranslated(context, 'termsAndConditions'),
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
            onTap: () {
              showAlertDialog(
                  context, getTranslated(context, 'termsAndConditions'), TERMS);
            },
          ),
          Text(
            getTranslated(context, 'and'),
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          InkWell(
            child: Text(
              getTranslated(context, 'privacyPolicy'),
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
            onTap: () {
              showAlertDialog(
                  context, getTranslated(context, 'privacyPolicy'), PRIVACY);
            },
          ),
          // SelectableText(
          //   "openandsell.com/terms",
          //   style: TextStyle(color: Colors.blue, fontSize: 14),
          // ),
          // SelectableText(
          //   "openandsell.com/privacy",
          //   style: TextStyle(color: Colors.blue, fontSize: 14),
          // ),
          Text(
            error_terms,
            style: TextStyle(color: Colors.red, fontSize: 14),
          ),
        ],
      ),
      value: checkedValue,
      onChanged: (newValue) {
        setState(() {
          checkedValue = newValue;
          // open-and-sell.flycricket.io/terms.html
          // https://open-and-sell.flycricket.io/privacy.html
          //Text("By continuing, you agree to OpenAndSell's Conditions of Use and Privacy Notice."),
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }
}
