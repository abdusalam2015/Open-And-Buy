import 'package:flutter/material.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15.0,90.0,0.0,0.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Shopping Now ...',
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                    ),
                     Padding(
                  padding: const EdgeInsets.fromLTRB(5.0,10.0,0.0,0.0),
                  child: Icon(Icons.shopping_cart ,size: 30,color: Colors.green,),
                ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(140.0,160.0,0.0,0.0),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                ),
              ), 
            ],
          )
        ,),
        Container(
          padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)
                  )
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'User Name',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)
                  )
                ),
              ),
           //   SizedBox(height: 20.0,),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)
                  ) 
                ),
                obscureText: true,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)
                  )
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)
                  )
                ),
              ),
              SizedBox(height: 5.0,),
              Container(
                alignment: Alignment(1.0, 0.0),
                padding: EdgeInsets.only(top:20.0, left: 20.0),
                child: InkWell(
                  child: Text('Forgot Password',style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline
                  ),),
                ),
              ),
              SizedBox(height: 40.0,),
              Container(
                height: 60,
                child: Material(
                  borderRadius: BorderRadius.circular(40.0),
                  shadowColor: Colors.greenAccent,
                  color: Colors.green,
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: (){},
                    child: Center(
                      child: Text(
                        'Sign Up',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                height: 60.0,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:Colors.black,
                      style:BorderStyle.solid,
                      width:1.0,
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child:
                     
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Icon(Icons.arrow_back,size: 20.0,) 
                      ),
                      Center(
                      child: Text(
                        'Go Back',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ) 
                ),
            ]),    
            ),    
          ),
          )
        ],
      )
    ,),
  ],),
);
  }
}