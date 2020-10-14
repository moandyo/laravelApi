import 'dart:async';
import 'dart:convert';
import 'package:fluttershop/api/api_utilty.dart';
import 'package:fluttershop/product/product.dart';
import 'package:http/http.dart' as http;

class ProductsApi {

  Future<List<Product>> fetchProductsType1()async{
    Map<String,String> headers  ={
       'Accept' : 'application/json'
    };

    String url = ApiUti.PRODUCTStype +1.toString();//'?page'+page.toString();
//print(url);
    http.Response response = await http.get(url, headers:headers);
    // print(response.body);
     List<Product> product =[];
     if(response.statusCode == 200){
        var body = jsonDecode(response.body);
   //      print(body);
        for(var item in body['data']){
           product.add(Product.fromJson(item));
        }
        return product;
     }
  }

    Future<List<Product>> fetchProductsType2()async{
    Map<String,String> headers  ={
       'Accept' : 'application/json'
    };

    String url = ApiUti.PRODUCTStype +2.toString();//'?page'+page.toString();
     print(url);
    http.Response response = await http.get(url, headers:headers);
    // print(response.body);
     List<Product> product =[];
     if(response.statusCode == 200){
        var body = jsonDecode(response.body);
   //      print(body);
        for(var item in body['data']){
           product.add(Product.fromJson(item));
        }
        return product;
     }
  }

  Future<List<Product>> fetchProductsTag(int tag)async{
    Map<String,String> headers  ={
       'Accept' : 'application/json'
    };

    String url = ApiUti.PRODUCTStag +tag.toString();//'?page'+page.toString();
print(url);
    http.Response response = await http.get(url, headers:headers);
    // print(response.body);
     List<Product> product =[];
     if(response.statusCode == 200){
        var body = jsonDecode(response.body);
   //      print(body);
        for(var item in body['data']){
           product.add(Product.fromJson(item));
        }
        return product;
     }
   
  }

}