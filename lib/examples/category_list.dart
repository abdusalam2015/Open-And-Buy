import 'package:flutter/material.dart';
import 'package:volc/Admin/Service/storeDatabase.dart';
import 'package:volc/SharedModels/store/category.dart';
import 'package:volc/SharedModels/store/store.dart';
import 'package:volc/User/Model/user_detail.dart';

class CategoriesList extends StatefulWidget {
  final UserDetail userDetail;
  final StoreDetail storeDetail;
  final List<Category> categoriesList;
  CategoriesList(this.storeDetail,this.userDetail,this.categoriesList);
  
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  // List<Category> _categories = new List<Category>();
  //  _categories = categoriesList;      //Category.getCategories();
  
  List<DropdownMenuItem<Category>> _dropdownMenuItems;
  Category _selectedCategory= new Category(productNumbers: '',name:'',categoryID: '');
  StoreDatabaseService sds;

  @override
  void initState() {
    //print(_categories[0].name + ' HEEL');
    _dropdownMenuItems = buildDropdownMenuItems(widget.categoriesList);
    _selectedCategory = _dropdownMenuItems[0].value;
    super.initState();
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
  onChangeDropdwonItem(Category selectedCategory){
    setState(() {
      _selectedCategory = selectedCategory;
    });
  }

  
  @override
  Widget build(BuildContext context) {
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
                    onPressed: (){
                      createAlertDialog(context).then((onValue){
                        if(onValue != '' && onValue != null){
                          SnackBar mySnackBar = SnackBar(content: Text('$onValue Added Scuccessfully!'),backgroundColor: Colors.green,);
                          Scaffold.of(context).showSnackBar(mySnackBar);
                        }
                      });
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
                child: Center(child: Text(_selectedCategory.name,style: TextStyle(color: Colors.green,fontSize: 25,fontWeight: FontWeight.bold),))))
            ],
              ),
      ),
    );
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
                onPressed: (){
                  Category category = new Category(categoryID: '',name: '',productNumbers: '');
                  category.name = _mycontroller.text.toString();
                  dynamic result;
                  result =  StoreDatabaseService().addCategory(widget.storeDetail, category, widget.userDetail.userID);
                  result != null ? Navigator.of(context).pop(_mycontroller.text.toString())
                  :Navigator.of(context).pop('');
                },
              ), 
            
          ],
          );
      }
      );
  }
}