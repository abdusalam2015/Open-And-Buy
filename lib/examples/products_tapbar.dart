import 'package:flutter/material.dart';
import 'package:volc/SharedModels/store/category.dart';
import 'package:volc/SharedModels/store/store.dart';
import 'package:volc/User/Model/user_detail.dart';

 class ProductsTapBar extends StatefulWidget{
   final UserDetail userDetail;
   final StoreDetail storeDetail;
   final List<Category> categoriesList;
   ProductsTapBar(this.userDetail,this.storeDetail,this.categoriesList);
  @override
  _ProductsTapBarState createState() => _ProductsTapBarState();
  }
class _ProductsTapBarState extends State<ProductsTapBar> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length:3, vsync: this);
  }
    @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) { 
      return Column(
        children: <Widget>[
          TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.pink[400],
                  isScrollable: true,
                  labelPadding: EdgeInsets.only(right: 45.0),
                  unselectedLabelColor: Color(0xFFCDCDCD),
                  tabs: [
                    Tab(child: categoryText('Drinks',14.0),),
                    Tab(child: categoryText('Fresh Fruits',14.0)),
                    Tab(child: categoryText('Drinks',14.0),),
                  ]
                  ),
                  Container(
                height: MediaQuery.of(context).size.height - 50.0,
                width: double.infinity,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Text('Products'),
                    Text('Products'),
                   // ProductsList(),
                    //Products(_increment,_decrement,product,widget.cont),
                  ]
                )    
       
      )
        ],
      );

  }
  Widget categoryText(String text, double fsize){
    return Text(
      text,
    style: TextStyle(
            fontFamily: 'Varela',
            fontSize: fsize,
          ));
  }
}