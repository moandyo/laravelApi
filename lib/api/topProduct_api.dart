import 'dart:convert';

import 'package:fluttershop/models/topProduct.dart';

import 'api_utilty.dart';
import 'package:http/http.dart' as http;
class TopProductsApi {

  Future<List<TopProduct>> fetchTopProducts(int page)async{
    Map<String,String> headers  ={
       'Accept' : 'application/json'
    };

    String url = ApiUti.TOPPRODUCTS +'?page'+page.toString();

    http.Response response = await http.get(url, headers:headers);
     List<TopProduct> topProduct =[];
     if(response.statusCode == 200){
        var body = jsonDecode(response.body);
        for(var item in body['data']){
           topProduct.add(TopProduct.fromJson(item));
        }
        return topProduct;
     }
   
  }

}