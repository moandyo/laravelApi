
import 'dart:convert';

import 'package:fluttershop/customer/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_utilty.dart';
import 'package:http/http.dart' as http;

class UserProfile{

  Future<User> getUserProfile() async{
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    // print(apiToken);
    int userId = sharedPreferences.getInt('user_id');
    // print(userId);
   String url = ApiUti.USER_PROFILE+userId.toString();
  //  print(url);
   Map<String,String>headers = {
     'Accept' : 'application/json',
     'Authorization' : 'Bearer ' + apiToken
   };


    http.Response response = await http.get(url, headers:headers);
    // print(response.body);
     if(response.statusCode ==200){
    
  var body = jsonDecode(response.body);
 var data = body['data'];
   //print(User.fromJosn(data).first_name);
  return User.fromJosn(data);

  }
   return null;
     
   
  }
}