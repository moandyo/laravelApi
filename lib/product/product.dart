


import 'package:fluttershop/product/product_category.dart';

class Product{
  int product_id,product_tag;
  String product_title,product_description;
  double product_price,product_total;
  ProductCategory productCategory;
  List<String> images;

  Product(this.product_id,this.product_tag,this.product_description,this.images,this.productCategory,
  this.product_price,this.product_title, this.product_total,);

  Product.fromJson(Map<String,dynamic> jsonObject){
    this.product_id = jsonObject['product_id'];
    this.product_tag= jsonObject['product_tag'];
    this.product_title = jsonObject['product_title'];
    this.product_description = jsonObject['product_description'];
    this.product_total = double.tryParse(jsonObject['product_total']);
    this.product_price = double.tryParse(jsonObject['product_price']);
    
    this.productCategory = ProductCategory.fromJson(jsonObject['product_category']);

   this.images =[];
   if(jsonObject['product_images'] != null){
     _setImages(jsonObject['product_images']);
   }
  }

  void _setImages(List<dynamic> jsonImages){
  images =[];
   if(jsonImages.length > 0){
      for(var image in jsonImages){
        if(image != null){
          this.images.add(image['image_url']);
        }
      }
    }
  }

  String featureImage(){
    if(this.images.length > 0){
    return this.images[0];
    }
    return 'https://picjumbo.com/wp-content/uploads/sunset-ocean-free-photo-DSC04212-1080x720.jpg';
  }
}