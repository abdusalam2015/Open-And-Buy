import 'package:flutter/material.dart';

class AccountSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                (context, index) =>items(index), 
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
     Widget items(index){
       print('Index: $index');
       if(index == 0)return item1();
       else if(index == 1)return item2();
       else if(index == 2)return item3();
       else if(index == 3)return item4();
       else if(index == 4)return item5();
       else return item6();
     }
    Widget item1(){
      return Column(
        children: <Widget>[
          SizedBox(height: 20,),
          Padding(
             padding: EdgeInsets.only(left: 20),
            child: Row(
            //  mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                backgroundImage: AssetImage('assets/profile_picture.png'),
                radius: 35.0,
              ),
              SizedBox(width: 10,),
                Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  textItem('Abdulsalam Fadhel                   '),
                  textItem('+46735517944                        '),
                  textItem('abdussalm9393@gmail.com'),

                ],),
                   ],),
                   
          ),
         SizedBox(height: 10,),
          divider()
        ],
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
    
     Widget item6(){
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