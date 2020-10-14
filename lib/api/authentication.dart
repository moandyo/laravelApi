import 'package:fluttershop/api/api_utilty.dart';
import 'package:fluttershop/customer/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
class Authentication {

Future<User> register(String first_name, String last_name, String email, String password,double longitude,double latitude) async {
Map<String,String> headers = {
  'Accept' : 'application/json'
};

Map<String,String> body = {
  'first_name' : first_name,
  'last_name' : last_name,
  'email' : email,
  'password' : password,
  'longitude': longitude.toString(),
  'latitude' : latitude.toString()
};

print(body);

 http.Response response = await http.post(ApiUti.AUTH_REGISTER, headers: headers,body: body);
print(response.statusCode);
print(response.body);
  if(response.statusCode ==201){
    
  var body = jsonDecode(response.body);
  var data = body['data'];
   
  return User.fromJosn(data);

  }
   return null;
  }

Future<User> login(String email , String password)async{
  print(email);
  print(password);
Map<String,String> headers = {
  'Accept' : 'application/json'
};

Map<String,String> body = {
  'email' : email,
  'password' : password,
};

http.Response response = await http.post(ApiUti.AUTH_LOGEN,headers: headers,body: body);
 if(response.statusCode ==200){
 var body = jsonDecode(response.body);
 var data = body['data'];
 User user = User.fromJosn(data);
 await _saveUserID(user.user_id,user.api_token);
 return user;
 }
return null;
  }
  Future<void> _saveUserID(int userID,String apiToken) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('user_id', userID);
    sharedPreferences.setString('api_token', apiToken);
  }
}