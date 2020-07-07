import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Controller/loading.dart';
import 'package:OpenAndBuy/Model/localization/localizationConstants.dart';
import 'package:OpenAndBuy/Service/storeDatabase.dart';
import 'package:OpenAndBuy/Service/store_notifier.dart';
import 'package:OpenAndBuy/Service/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:OpenAndBuy/Model/category.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Controller/home/product_list.dart';
import 'package:OpenAndBuy/Controller/home/app_bar.dart';
import 'package:OpenAndBuy/Controller/home/new_drawer.dart';
import 'package:OpenAndBuy/Model/product.dart';

class StorePage extends StatefulWidget {
  final StoreDetail storeDetail;
  final List<Category> categories;
  StorePage({this.storeDetail, this.categories});
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: StoreNotifier(sid: widget.storeDetail.sid),
        child: MaterialApp(
            home: StorePage2(
                storeDetail: widget.storeDetail,
                categories: widget.categories)));
  }
}

class StorePage2 extends StatefulWidget {
  final StoreDetail storeDetail;
  final List<Category> categories;
  StorePage2({this.storeDetail, this.categories});
  @override
  _StorePage2State createState() => _StorePage2State();
}

class _StorePage2State extends State<StorePage2>
    with SingleTickerProviderStateMixin {
  

  int categoryIndex = 0;
  void _categoryIndexFunction(int index) {
    setState(() {
      categoryIndex = index;
    });
  }

  List<Product> productsList;
  bool finished = false;
   String value(String key) {
    return getTranslated(context, key);
  }
  @override
  Widget build(BuildContext context) {
    StoreNotifier storeNotifier = Provider.of<StoreNotifier>(context);
   
    storeNotifier
        .getCategoryProduct(widget.categories[categoryIndex].categoryID);
    productsList = storeNotifier.categoryProducts;
    return Scaffold(
        backgroundColor: BACKGROUNDCOLOR, //APPBARCOLOR,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: AppBarWidget(widget.storeDetail),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                 widget.categories[categoryIndex].name + ' Category'  ,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            productsList != null && productsList.length > 0
                ? ProductList(productsList)
                : Container(
                    height: 600,
                    width: 50,
                    child: Center(
                        child: Text(
                      'No Products exist in this Category',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    )),
                  )
          ],
        ),
        drawer: getDrawer(widget.categories, _categoryIndexFunction));
  }
}
