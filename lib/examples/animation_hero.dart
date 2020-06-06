import 'package:flutter/material.dart';
import 'package:volc/SharedWidgets/loading.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero({ Key key, this.photo, this.onTap, this.width }) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class HeroAnimation extends StatelessWidget {
  Widget build(BuildContext context) {
   // var timeDilation = 10.0; // 1.0 means normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation'),
      ),
      body: Center(
        child: PhotoHero(
          photo: 'assets/profile_picture.png',
          width: 30.0,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Flippers Page'),
                  ),
                  body: Container(
                    // The blue background emphasizes that it's a new route.
                    color: Colors.lightBlueAccent,
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.topLeft,
                    child: PhotoHero(
                      photo: 'assets/profile_picture.png',
                      width: 100.0,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                );
              }
            ));
          },
        ),
      ),
    );
  }
}


























class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  //final AuthService _auth = new AuthService();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return  loading? Loading() : Scaffold(
      body:CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 100.0,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Edit Account',style: TextStyle(fontSize: 22,color: Colors.white),),
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
  Widget items(index){
      return Container();
     }
}