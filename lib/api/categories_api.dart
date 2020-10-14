
import 'dart:convert';

import 'package:fluttershop/api/api_utilty.dart';
import 'package:fluttershop/product/product.dart';
import 'package:fluttershop/product/product_category.dart';
import 'package:http/http.dart' as http;

class CategoriesApi {

Map<String,String> headers = {
'Accept' : 'application/json'
};

Future<List<ProductCategory>> fetchCategories() async{

  String url = ApiUti.CATEGORIES ;
  http.Response response = await http.get(url, headers: headers);
  switch (response.statusCode){
    case 200:
      List<ProductCategory> categories = [];
      if(response.statusCode == 200){
        var body = jsonDecode(response.body);
        for(var item in body['data']){
          
          ProductCategory category =ProductCategory.fromJson(item);
          categories.add(category);
         }
      }
    return categories;
      break;
    default:
    return null;
  }
  
 }


 Future<List<Product>> fetchCategoriesByCategory(int category, int page) async{

  String url = ApiUti.CATEGORY_PRODUCTS(category,page) ;
  http.Response response = await http.get(url, headers: headers);
  List<Product> product = [];
 
  switch (response.statusCode){
    case 404:
      throw Exception('404');
      break;
   case 301:
   case 302:
   case 303:
    throw Exception('301');
    break;
    case 200:
       var body = jsonDecode(response.body);
        for(var item in body['data']){
           product.add(Product.fromJson(item)
           );
        }
        return product;
      break;
    default:
    return null;
    break;
  }
  
 }
}