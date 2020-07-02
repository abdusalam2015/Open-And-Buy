import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:OpenAndBuy/Controller/loading.dart';
import 'package:OpenAndBuy/Controller/EditUserDetails/edit_account.dart';
import 'package:OpenAndBuy/Model/user_detail.dart';
import 'package:OpenAndBuy/Service/auth.dart';


class AccountSettings extends StatefulWidget {
final BuildContext cont;
 AccountSettings(this.cont);
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}
class _AccountSettingsState extends State<AccountSettings> {
  final AuthService _auth = new AuthService();
  bool loading = false;
  UserDetail userDetail;
  @override
  Widget build(BuildContext context)  {
    userDetail = Provider.of<UserDetail>(widget.cont);
   
    return loading? Loading() :Scaffold(
      body:CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 100.0,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Account Settings',style: TextStyle(fontSize: 22,color: Colors.white),),
            ),
            backgroundColor: Colors.black,
          ),
           SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                if(index == 0)return item1();//ProfilePage();
                else if(index == 1)return item2();
                else if(index == 2)return item3();
                else if(index == 3)return item4();
                else if(index == 4)return item5();
                else return signOut();
                }, 
                childCount: 6,
              ),
              
            ),
            
        ],
      )
    );
  }



    Widget divider(){
      return Divider(
        color: Colors.grey,
        thickness: 1,
      );
    }

    Widget textItem(name){
      return Text(
        name,
        style: TextStyle(fontSize: 14,color:Colors.black, ),
      );
    }

    //  Widget items(index){
    //    print('Index: $index');
    //    if(index == 0)return item1();//ProfilePage();
    //    else if(index == 1)return item2();
    //    else if(index == 2)return item3();
    //    else if(index == 3)return item4();
    //    else if(index == 4)return item5();
    //    else return signOut();
    //  }
     item1() {
       return   InkWell(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 20,top: 20.0),
                 child: Row(
                   children: <Widget>[
                     CircleAvatar(
                       // check if the there is any photo or not! 
                      backgroundImage:userDetail.photoURL !='' && userDetail.photoURL != null  ?
                      // profile pic is updated 
                       NetworkImage(userDetail.photoURL)
                       // profile picture is not updated , so we will go with the default one 
                       :AssetImage('assets/profile_picture.png'),
                      radius: 40.0,
                        ), 
                  SizedBox(width: 10,),
              Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
               userDetail.firstName + userDetail.lastName,
                style: TextStyle(fontSize: 14,color:Colors.black, ),
               ),
               Text(
                 userDetail.phoneNumber,
                 style: TextStyle(fontSize: 14,color:Colors.black, ),),
                // Text(
                //   userDetail.email,
                //  style: TextStyle(fontSize: 14,color:Colors.black, ),),
            ],),

            ],),),
            SizedBox(height: 10.0,),
            divider(),
          ],
        ),
        onTap: ()async {
          await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditAccount(
             widget.cont,
            )
          )
          );       
        },
      ); 
    }

 Widget item2(){
      return Column(
        children: <Widget>[
          Padding(
             padding: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[ 
              SizedBox(height: 25,),
              Row(
                children: <Widget>[
                Text('Favorites'),
                ],
                ),
              SizedBox(height: 20,),
                InkWell(
                  child: Row(
                    children: <Widget>[
                    Icon (Icons.home),
                    SizedBox(width: 10),
                    textItem('Add Home'),
                  ],
                  ),
                  onTap: (){},
                ),
                SizedBox(height: 20),
                InkWell(
                child: Row(
                    children: <Widget>[
                    Icon (Icons.work),
                    SizedBox(width: 15,),
                    textItem('Add Work'),
                  ],
                  ),
                  onTap: (){},
                ),
                SizedBox(height: 20,),
                InkWell(
                child: Row(
                    children: <Widget>[
                    Text('More Saved Places',style: TextStyle(color: Colors.blue,fontSize: 15),),
                  ],
                  ),
                  onTap: (){},
                ),
                SizedBox(height: 30,),

              ],
              ),
              
          ),
          divider(),
        ],
      );
    }

Widget item4(){
      return Column(
        children: <Widget>[
          Padding(
             padding: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[ 
              SizedBox(height: 20,),
              Row(
                children: <Widget>[
                Text('Privacy'),
                ],
                ),
              SizedBox(height: 5.0,),
                InkWell(
                child: Row(
                    children: <Widget>[
                    Text('Manage the data you share with us',style: TextStyle(color: Colors.grey,fontSize: 14),),
                  ],
                  ),
                  onTap: (){},
                ),
              ],
              ),
              
          ),
          divider()
        ],
      );
    }

     Widget item3(){
      return Column(
        children: <Widget>[
          Padding(
             padding: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[ 
              SizedBox(height: 25,),
              Row(
                children: <Widget>[
                Text('Family'),
                ],
                ),
                SizedBox(height: 25,),
                InkWell(
                child: Column(
                    children: <Widget>[
                      Row(
                    children: <Widget>[
                    Text('Set up your family',style: TextStyle(color: Colors.blue,fontSize: 15),),
                  ],
                  ),
                    Row(
                    children: <Widget>[
                    Text('Pay for your loved ones and get order notifications',style: TextStyle(color: Colors.grey,fontSize: 14),),
                  ],
                  ),
                  
                  ],
                  ),
                  onTap: (){},
                ),
                SizedBox(height: 25,)
              ],
              ),
              
          ),
          divider()
        ],
      );
    }

     Widget item5(){
      return Column(
        children: <Widget>[
          Padding(
             padding: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[ 
              SizedBox(height: 20,),
              Row(
                children: <Widget>[
                Text('Security'),
                ],
                ),
              SizedBox(height: 5.0,),
                InkWell(
                child: Row(
                  children: <Widget>[
                    Text('Control your account security with 2-step verification',style: TextStyle(color: Colors.grey,fontSize: 14),),
                  ],
                  ),
                  onTap: (){},
                ),
              ],
              ),
              
          ),
          divider()
        ],
      );
    }

     Widget signOut(){
      return Column(
        children: <Widget>[
          Padding(
             padding: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[ 
              SizedBox(height: 15,),
              InkWell(
                 child: Row(
                  children: <Widget>[
                  Text('Sign Out'),
              ],
              ),
                  onTap: () async{
                  Navigator.of(context).pop();
                  setState(() {
                  loading = true;
                  });
                  _auth.signOut();
                  },
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: 20.0,),
                  Text('',style:TextStyle(color: Colors.white)),
                  Text('',style:TextStyle(color: Colors.white)),

                ],
              ),
                
              ],
              ),
              
          ),
        ],
      );


    }
}

  // Future getData() async {
  //   var url = 'http://volcshopping.000webhostapp.com/get.php';
  //   http.Response response = await http.get(url);
  //    var data = jsonDecode(response.body);
  //    print(data.toString());

  // }
  // @override
  // void initState(){
  //   getData();
  // }