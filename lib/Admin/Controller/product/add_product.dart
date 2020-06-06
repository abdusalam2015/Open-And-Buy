import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:volc/Admin/Controller/store_home_pages/store_home_page.dart';
import 'package:volc/Admin/Service/storeDatabase.dart';
import 'package:volc/SharedModels/product/product.dart';
import 'package:volc/SharedModels/store/category.dart';
import 'package:volc/SharedModels/store/store.dart';
import 'package:volc/SharedWidgets/alert_message.dart';
import 'package:volc/SharedWidgets/constant.dart';
import 'package:volc/SharedWidgets/shared_functions.dart';
import 'package:volc/User/Model/user_detail.dart';

class AddProduct extends StatefulWidget {
   List<Category> categoriesList;
  final BuildContext cont;
  final StoreDetail storeDetail;
  final List<Product> productsList;
  AddProduct(this.cont,this.storeDetail,this.categoriesList,this.productsList);
  @override
  _AddProductState createState() => _AddProductState();
}
class _AddProductState extends State<AddProduct> { 
  List<DropdownMenuItem<Category>> _dropdownMenuItems;
  Category _selectedCategory= new Category(productNumbers: '',name:'',categoryID: '');
 // Product product = new Product('', '', '', '', '');
 Product product = new Product(id:'',name: '',imgPath: '', price:'',info: '') ;

  
  StoreDatabaseService sds;

 onChangeDropdwonItem(Category selectedCategory){
    setState(() {
      _selectedCategory = selectedCategory;
    });
  }

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(widget.categoriesList);
    _selectedCategory = _dropdownMenuItems.length != 0 ?  _dropdownMenuItems[0].value 
    : Category(categoryID: '',name: 'No Categories!!',productNumbers: '0' );
    super.initState();
  }

  final SharedFunctions sharedfun = new SharedFunctions();
  bool loading = false;
  UserDetail userDetail ;
  File img;
 // double c_width;
  String error='';
  //final AuthService _auth = new AuthService();
  final StoreDatabaseService _store = new StoreDatabaseService();
  final _formKey2 = GlobalKey<FormState>();
  //StoreDetail storeDetail = new StoreDetail('','','','','','','','','',) ;
  bool isUploaded = false;
 
  @override
  Widget build(BuildContext context){
  userDetail = Provider.of<UserDetail>(widget.cont);
  //c_width = MediaQuery.of(context).size.width*0.8;
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Now',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Builder(
        builder: (context) => ListView(
          children: <Widget>[
            profilePicture(context),
            categoriesListFun(context),
            _formToAddProduct(userDetail),
          ],
    ), 
  ),
  );
  }
  Widget categoriesListFun(context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Select A Category',style: TextStyle(fontSize: 20.0),),
                  FlatButton(
                    child: Text('Add A Category',style: TextStyle(fontSize: 14.0,color: Colors.blue)),
                    onPressed: () async {
                      
                      
                      createAlertDialog(context).then((onValue){
                        if(onValue != '' && onValue != null) {
                          SnackBar mySnackBar = SnackBar(content: Text('$onValue Added Scuccessfully!'),backgroundColor: Colors.green,);
                          Scaffold.of(context).showSnackBar(mySnackBar); }});
                    },
                  ),
                ],
              ),
              SizedBox(height: 15.0,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 500,
                //  color: Colors.red,
                  child: DropdownButton(
                    value: _selectedCategory,
                    items: _dropdownMenuItems,
                    onChanged: onChangeDropdwonItem,
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Center(
              child: Container(
                color: Colors.grey[200],
                width: 400,
                height: 60,
                child: Center(child: Text(_selectedCategory.name.toString(),style: TextStyle(color: Colors.green,fontSize: 25,fontWeight: FontWeight.bold),))
              )
            ) 
          ],
        ),
      ),
    );

  }
  List<DropdownMenuItem<Category>> buildDropdownMenuItems(List categories){
    List<DropdownMenuItem<Category>> items = List();
    for( Category category in categories){
      items.add(
      DropdownMenuItem(
        value: category,
        child: Text(category.name), 
      )
      );
    }
    return items;

  }
 TextEditingController _mycontroller = new TextEditingController();
 Future<String> createAlertDialog(BuildContext context){
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('The Category Name?'),
          content: TextField(
             controller:_mycontroller ,
             
          ),
          actions: <Widget>[
          
                 MaterialButton(
                elevation: 5.0,
                color: Colors.red,
                child: Text('Cancel'),
                onPressed: (){
                  Navigator.of(context).pop('');
                },
              ),
              SizedBox(width: 100,),
              MaterialButton(
                elevation: 0.0,
                color: Colors.blue,
                child: Text('Submit'),
                onPressed: ()async{
                  Category category = new Category(categoryID: '',name: '',productNumbers: '');
                  category.name = _mycontroller.text.toString();
                  dynamic result;
                  result =  StoreDatabaseService().addCategory(widget.storeDetail, category, userDetail.userID);

                  if(result != null)  { 
                    // StoreDatabaseService obj = new StoreDatabaseService(sid: widget.storeDetail.sid);   
                    //   widget.categoriesList = await obj.getcategories(userDetail.userID);
                    //   setState(() {
                    //     widget.categoriesList = widget.categoriesList;
                    //   });
                    Navigator.of(context).pop(_mycontroller.text.toString());
                  }else {
                    Navigator.of(context).pop('');}
                },
              ), 
            
          ],
          );
      }
      );
  }

  Widget _formToAddProduct(userDetail){
    //print(_selectedCategory.name +"  HHH Yes");
    String error='';
    return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
              child:  Form(
                key: _formKey2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    Text('Product Name',style: TextStyle(fontWeight: FontWeight.bold)),SizedBox(height: 5,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText:'Product Name'),
                      validator: (val) =>  val.isEmpty || val =='' ?'Enter Product Name':null,
                      onChanged: (val){
                        setState(() {
                          product.name = val;
                        });
                      }
                    ),
                    SizedBox(height: 20.0,),
                    Text('Product Price',style: TextStyle(fontWeight: FontWeight.bold)),SizedBox(height: 5,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText:'Price'),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                       ],
                      validator: (val) =>  val.isEmpty || val =='' ?'Enter the Product Price':null,
                      onChanged: (val){
                        setState(() {
                          product.price = val;
                        });
                      }
                    ),
                    SizedBox(height: 20.0,),
                    Text('Product Description:',style: TextStyle(fontWeight: FontWeight.bold)),SizedBox(height: 5,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText:'Description'),
                      validator: (val) =>  val.isEmpty || val =='' ?'Enter product description':null,
                      onChanged: (val){
                        setState(() {
                          product.info = val;
                        });
                      }
                    ),
                    SizedBox(height: 60.0,),
                    ButtonTheme(
                      height: 60,
                      minWidth: 300,
                       child: RaisedButton(
                        color:Colors.black,
                        child: Text(
                          'ADD PRODUCT',
                          style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async{
                             if(_formKey2.currentState.validate()){
                                product.imgPath = img.toString(); 
                               dynamic result = null ;
                               if(_selectedCategory.categoryID != '' ){ 
                                 result  = await _store.addProduct(img,product,userDetail.userID,_selectedCategory,widget.storeDetail);
                                 result = 'added';
                               }else {
                                error = 'No categoy selected!';
                                print('sss');
                                showAlertDialog(widget.cont,'No Category','Please select/add a category!');
                               }                      
                                if(img == null){
                                  setState(() =>loading = false);
                                }else {
                                  setState(() =>loading = true);
                                  isUploaded = true;
                                  loading = false;
                                  setState(() => loading = false);
                                } 
                                if (result == null){
                                  setState(() {
                                    error = 'Error!!';
                                    loading = false;
                                  });
                                }else {
                                  print('GOOOD TO GO');
                                  setState(() => loading = false);
                                  Navigator.pop(context);
                                //   final result = Navigator.of(context).push(
                                //       MaterialPageRoute(
                                //         builder: (context) => EditStoreAccount(
                                //           widget.cont,
                                //           storeDetail,
                                //         )
                                //       )
                                // ); 
                                // make sure that if it is already updated or not
                                //   result != null ? Scaffold.of(context).showSnackBar(SnackBar(
                                //   content: Text('Last Name Updated', style: TextStyle(color: Colors.white),),
                                //   backgroundColor: Colors.green)):Container();

                                }
                               }
                          },
                      ),
                    ),
                    SizedBox(height: 12.0,),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red,fontSize: 14.0),
                    )
                ],),
              )
            );
  }
  Widget button(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonTheme(
        minWidth: 200,
        height: 60,
        child: RaisedButton(
          color:Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Add',style: TextStyle(color: Colors.white,fontSize: 20),),
              ],
          ),
            onPressed: () async{
                  Navigator.pop(context);
                     Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StoreHomePage(
                           widget.cont,
                            widget.storeDetail,
                            widget.categoriesList,
                            widget.productsList
                            
                          )
                        )); 
              // make sure that if it is already updated or not
                // result != null ? Scaffold.of(context).showSnackBar(SnackBar(
                // content: Text('Saved!', style: TextStyle(color: Colors.white),),
                // backgroundColor: Colors.green)):Container();
            }
        ),
      ),
    );
  }

Widget profilePicture(cont){
   return InkWell(
      child: Padding(
       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Stack(
              children: <Widget>[

                // splash screen for updating the profile picture
                loading ? Padding(
                  padding: const EdgeInsets.only(top:30.0,left: 20),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SpinKitFadingCircle(color: Colors.brown,size: 50.0,),//Text('Loading...')
                  ),
                ): Image(
                image: isUploaded ?  FileImage(img):AssetImage('assets/storeImage.png'),
                //radius: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top:65.0,left: 80),
                child: CircleAvatar(
                  backgroundColor: (Colors.grey[800]),
                  child: Icon(Icons.add,color: Colors.white,size:40.0),
                  radius: 20.0,
                ),
              ),
              ]),
                SizedBox(height: 20.0,),
                Divider(color: Colors.grey,thickness: 1, ),
            ],),
     ),
     onTap: () async{
    // File _image;
     try{
       img= await sharedfun.getImage();
       } catch(e){
         print(e);
       }
     },
   );
}
}

// return Scaffold(
//       body: Builder(
//         builder: (context) => CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//               expandedHeight: 100.0,
//               pinned: true,
//               floating: true,
//               flexibleSpace: FlexibleSpaceBar(
//                 title: Text('Add Product',style: TextStyle(fontSize: 22,color: Colors.white),),
//               ),
//               backgroundColor: Colors.black,
//               ),
//                SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   (context, index){
//                     if(index == 0)return profilePicture(context);
//                     else if(index == 1)return CategoriesList(widget.storeDetail,userDetail,widget.categoriesList); 
//                     else if(index == 2)return _form(userDetail);
//                     // else if(index == 2)return location('Location',  widget.storeDetail.location,context);
//                     // else if(index == 3)return phoneNumber('Phone Number', widget.storeDetail.phoneNumber,true,context);
//                     // else if(index == 4)return email('Email', widget.storeDetail.email, false,context );
//                     // else if(index == 5)return password('Password', '.......');
//                     else return SizedBox(height: 300,);  
//                   }, //=>items(index), 
//                   childCount: 4,
//                 ),
//                 ),
//                 ],
//               ), 
               
//           ),

//         );