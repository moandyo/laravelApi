import 'package:flutter/material.dart';
import 'package:fluttershop/api/authentication.dart';
import 'package:fluttershop/customer/user.dart';
import 'package:fluttershop/screen/login.dart';
import 'package:geolocator/geolocator.dart';


class UpdateUserScreen extends StatefulWidget {
  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {

  TextEditingController _ferstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  Authentication authentication = Authentication();

  var _formKey = GlobalKey<FormState>();
  bool _loading = false;
  var longT;
  var latT;
   @override
  void dispose() {
    _ferstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24,top: 22),
        child:Transform.translate(offset:Offset(0, -10),
        child: SingleChildScrollView(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Text('sign up', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 33),),
              SizedBox(height: 16,),
              Text('Login to continue to your account', style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey),),
                ],
              ),
               Padding(
                 padding: const EdgeInsets.only(top: 24, bottom: 24),
                 child: _loginForm(context),
               ),

                Container(
                  width: double.infinity,
                  height: 65,
                  margin: EdgeInsets.only(top: 24, bottom: 24),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
                    color: Colors.lightBlue.shade700,
                    child:(_loading) ? Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),)
                    : Text('sign up', style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color:Colors.white),
                       ),
                       onPressed: (_loading)?null:_registerUser,),
                                      ),
                                    //  Row(
                                     //  crossAxisAlignment: CrossAxisAlignment.center,
                                     //   mainAxisAlignment: MainAxisAlignment.center,
                                        //children: <Widget>[
                                       //   Transform.translate(offset: Offset(0,3)),
                                       //   Text('Dont\'t have an acconut?', style: TextStyle(fontWeight: FontWeight.w800,color: Colors.grey),),
                                      ///    FlatButton(
                                      //     child: Text('Sign in'),
                                       //    onPressed: (){},
                                      //     )
                                      //  ],
                                    //  ),
                                     
                                            ],
                                          ),
        ),
                            ),
                            ),
                                    );
                                  }
                                
                                Widget _loginForm(BuildContext context) {
                                   return Form(
                                     key: _formKey,
                                     child: Column(
                                       children: <Widget>[
                                         SizedBox(height: 16,),
                                          TextFormField(
                                            controller: _ferstNameController,
                                           decoration: InputDecoration(
                                             hintText: 'fires name',
                                             helperStyle: TextStyle(fontSize: 24),
                                             labelStyle: TextStyle(fontSize: 24),
                                           ),
                                           style: TextStyle(fontSize: 24),
                                            validator: (value){
                                             if(value.isEmpty){
                                               return 'fires name is required';
                                             }
                                             return null;
                                            }
                                         ),
                                         SizedBox(height: 16,),
                                          TextFormField(
                                            controller: _lastNameController,
                                           decoration: InputDecoration(
                                             hintText: 'last name',
                                             helperStyle: TextStyle(fontSize: 24),
                                             labelStyle: TextStyle(fontSize: 24),
                                           ),
                                           style: TextStyle(fontSize: 24),
                                            validator: (value){
                                             if(value.isEmpty){
                                               return 'last name is required';
                                             }
                                             return null;
                                            }
                                         ),
                                         TextFormField(
                                           controller: _emailController,
                                           decoration: InputDecoration(
                                             hintText: 'Email',
                                             helperStyle: TextStyle(fontSize: 24),
                                             labelStyle: TextStyle(fontSize: 24),
                                           ),
                                           style: TextStyle(fontSize: 24),
                                           validator: (value){
                                             if(value.isEmpty){
                                               return 'Email is required';
                                             }
                                             return null;
                                           },
                                         ),
                                          SizedBox(height: 16,),
                                          TextFormField(
                                            controller: _passwordController,
                                            obscureText: true,
                                           decoration: InputDecoration(
                                             hintText: 'Password',
                                             helperStyle: TextStyle(fontSize: 24),
                                             labelStyle: TextStyle(fontSize: 24),
                                           ),
                                           style: TextStyle(fontSize: 24),
                                            validator: (value){
                                             if(value.isEmpty){
                                               return 'Email is required';
                                             }
                                             return null;
                                            }
                                         ),
                                      Row(
                                        children: [
                                            OutlineButton(color: Colors.blue,child: Icon(Icons.location_on),onPressed: ()async{
                                          setState(() async{
                                             Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                                            var long =position.longitude;
                                            var lat= position.latitude;
                                            longT=long;
                                            latT=lat;
                                          });
                                            //print(long);
                                           // print(lat);
                                         //   longT=long;
                                           // latT=lat;
                                            print(longT);
                                            print(latT);
                                        }) ,
                                        Text('lont : $longT'),
                                        SizedBox(width: 11,),
                                        Text('lat : $latT'),
                                        ],
                                      ),
                                       ],
                                     ),
                                   );
                                }
                      
                        void _registerUser() async{

                          if(_formKey.currentState.validate()){
                        setState(() {
                              _loading = true;
                            });
                          
                          String first_name = _ferstNameController.text;
                          String last_name = _lastNameController.text;
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          User user = await authentication.register(first_name,last_name,email, password,latT,longT);
                          if(user != null){
                            setState(() {
                              _loading = false;
                            });
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                          }else{
                           
                           setState(() {
                              _loading = false;
                            });
                          }
                          
              }
          }
}