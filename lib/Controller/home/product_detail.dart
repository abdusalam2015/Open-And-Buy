import 'package:OpenAndBuy/Controller/constants/colors.dart';
import 'package:OpenAndBuy/Model/product.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  ProductDetailPage(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUNDCOLOR,
        appBar: AppBar(
          backgroundColor: APPBARCOLOR,
          title: Center(child: Text(product.name)),
        ),
        body: Container(
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              product.imgPath != ''
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Image.network(product.imgPath)),
                  )
                  : noImage(),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0,0,0,0),
                child: Text(
                  product.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0,0,0,0),
                child: Text(
                  product.price,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,0,0,0),
                child: Text(product.info, style: TextStyle(fontSize: 18,fontStyle:FontStyle.italic),),
              )
            ],
          ),
        ),
        );
  }

  Widget noImage() {
    return Center(
        child: Container(
            child: Text(
      'No Image!',
      style: TextStyle(
        fontSize: 18,
      ),
    )));
  }
}

//  ListView(
//         children: <Widget>[
//           Hero(
//                   tag: product.imgPath + product.id,
//                   child: product.imgPath.toString() != '' &&
//                           product.imgPath.toString() != 'null'
//                       ? Stack(children: [
//                           // Padding(
//                           //   padding: const EdgeInsets.only(top: 30.0),
//                           //   child: Center(
//                           //     child: Container(
//                           //         height: 40,
//                           //         width: 40,
//                           //         child: SpinKitFadingCircle(
//                           //           color: Colors.red,
//                           //           size: 30.0,
//                           //           // controller: AnimationController(  duration: const Duration(milliseconds: 1200)),
//                           //         )
//                           //         // CircularProgressIndicator()
//                           //         ),
//                           //   ),
//                           // ),
//                           Container(
//                             height: 500.0,
//                             width: 200.0,
//                             child: FadeInImage.memoryNetwork(
//                               height: 100,
//                               // fadeOutCurve: Curves.bounceIn,
//                               fadeInDuration: const Duration(seconds: 1),
//                               placeholder: kTransparentImage,
//                               image: product.imgPath,
//                             ),
//                           ),

//                         ])
//                       : Container(
//                           height: 90,
//                           width: 90,
//                           child: Center(child: Text('No image!'))),
//                 ),
//         ],
//       )
