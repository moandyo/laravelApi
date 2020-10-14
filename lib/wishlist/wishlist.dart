import 'package:fluttershop/product/product.dart';

class Wishlist{
  
  int wishlistID;
  Product product;

  Wishlist(this.wishlistID,this.product);

  Wishlist.fromJson(Map<String,dynamic> jsonObject){
    this.wishlistID = jsonObject['wishlist_id'];
    this.product   =  Product.fromJson(jsonObject['product']);

  }
}