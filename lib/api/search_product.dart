
import 'dart:convert';

import 'package:fluttershop/api/api_utilty.dart';
import 'package:fluttershop/product/product.dart';
import 'package:http/http.dart' as http;

class SearchProduct{

  Future<List<Product>> search(String search) async{
    print(search);
    Map<String,String> headers = {
  'Accept' : 'application/json'
};

Map<String,String> body = {
  'search' : search,
  
};
 String url = ApiUti.SEARCH;
  http.Response response = await http.post(url, headers: headers, body: body);     
       List<Product> product =[];
     if(response.statusCode == 200){
        var body = jsonDecode(response.body);
        // print(body);
        for(var item in body['data']){
           print(Product.fromJson(item));
           product.add(Product.fromJson(item));
        }
       
        return product;
     }
  }
}