
class Category{
  String categoryID;
  String name;
  String productNumbers;
  Category({this.categoryID,this.name,this.productNumbers});
  
  static List<Category> getCategories(){
    return  <Category>[
      Category(categoryID: '1',name: 'Drings',productNumbers: '44'),
      Category(categoryID: '2',name: 'Food',productNumbers: '3'),
      Category(categoryID: '3',name: 'Clean',productNumbers: '14'),
      Category(categoryID: '4',name: 'Cloths',productNumbers: '40'),
    ];
  }
}
