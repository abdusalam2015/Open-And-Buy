import 'package:OpenAndBuy/Controller/loading.dart';
import 'package:OpenAndBuy/Service/store_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:OpenAndBuy/Model/category.dart';
import 'package:OpenAndBuy/Model/store.dart';
import 'package:OpenAndBuy/Controller/product_card.dart';
import 'package:OpenAndBuy/Controller/authenticate/authenticate.dart';
import 'package:OpenAndBuy/Controller/home/app_bar.dart';
import 'package:OpenAndBuy/Controller/home/new_drawer.dart';
import 'package:OpenAndBuy/Model/cart_bloc.dart';
import 'package:OpenAndBuy/Model/user.dart';
import 'package:OpenAndBuy/Model/product.dart';

class StorePage extends StatefulWidget {
  final String storeID;
  StorePage({this.storeID});
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: StoreNotifier(sid: widget.storeID),
        child: MaterialApp(home: StorePage2()));
  }
}

class StorePage2 extends StatefulWidget {
  // final StoreDetail storeDetail;
  // final BuildContext cont;
  // final List<Category> categoryList;
  // final List<Product> productsList;
  // StorePage({this.storeDetail,this.cont,this.categoryList,this.productsList});
  @override
  _StorePage2State createState() => _StorePage2State();
}

class _StorePage2State extends State<StorePage2>
    with SingleTickerProviderStateMixin {
  StoreDetail storeDetail;
  List<Category> categories;
  List<Product> productsList;
  int categoryIndex = 0;
  void _categoryIndexFunction(int index) {
    setState(() {
      categoryIndex = index;
    });
  }

  bool finished = false;
  @override
  Widget build(BuildContext context) {
    void getTheData() async {
      StoreNotifier storeNotifier = Provider.of<StoreNotifier>(context);
      await storeNotifier.getStoreInfo();
      await storeNotifier.getStoreCategories();
      storeDetail = storeNotifier.storeDetail;
      categories = storeNotifier.categories;
      categories != null
          ? storeNotifier
              .getCategoryProduct(categories[categoryIndex].categoryID)
          : null;
      productsList = storeNotifier.categoryProducts;
      finished = true;
    }

    getTheData();

    var bloc = Provider.of<CartBloc>(context);
    int totalCount = 0;
    if (bloc.cart.length > 0) {
      totalCount = bloc.cart.values.reduce((a, b) => a + b);
    } else {
      totalCount = totalCount;
    }
    // Product product ;
    void _increment(String index, Product product) {
      setState(() {
        bloc.addToCart(index, product);
      });
    }

    void _decrement(String index, Product product) {
      setState(() {
        bloc.subToCart(index, product);
      });
    }

    return !finished
        ? Loading()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(55.0),
              // here the desired height
              /// we need to send StoreID to the appbar, because we need to check
              /// if we are already inside a store or still in the home page.
              /// if we are already inside a store then we can open the shopping cart for the user,
              /// if not then we need to make it disable.
              child: AppBarWidget(context, storeDetail),
            ),
            body: ListView(
              children: <Widget>[
                productsList != null && productsList.length > 0
                    ? productsGridList(
                        _increment, _decrement, productsList, context, false)
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
            drawer: getDrawer(categories, _categoryIndexFunction,
                context) // DrawerWidget(widget.cont,widget.storeDetail,widget.categoryList),

            );
  }
}
