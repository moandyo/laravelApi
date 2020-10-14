class  User {
  String first_name;
  String last_name;
  String email;
  String api_token;
  int user_id;
  double longitude,latitude;
  User(this.first_name,this.last_name,this.email,this.latitude,this.longitude,[this.api_token,this.user_id]);

  User.fromJosn(Map<String,dynamic> jsonObject){
   this.user_id = jsonObject['user_id'];
   this.first_name = jsonObject['first_name'];
   this.email = jsonObject['email'];
   this.longitude = jsonObject['longitude'];
   this.latitude = jsonObject['latitude'];
   this.api_token = jsonObject['api_token'];
  }
}