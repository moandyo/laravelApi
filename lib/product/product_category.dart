
class ProductCategory{
  int category_id;
  String category_name,category_image;

  ProductCategory(this.category_id,this.category_name,this.category_image);

  ProductCategory.fromJson(Map<String,dynamic> jsonObject){
   this.category_id = jsonObject['category_id'];
   this.category_name = jsonObject['category_name'];
   this.category_image= jsonObject['category_image'];
  }
}