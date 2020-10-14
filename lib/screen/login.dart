import 'package:flutter/material.dart';
import 'package:fluttershop/api/authentication.dart';
import 'package:fluttershop/customer/user.dart';
import 'package:fluttershop/screen/HomePage.dart';
import 'package:fluttershop/screen/register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Authentication authentication = Authentication();

  var _formKey = GlobalKey<FormState>();
  bool _loading = false;
  
   @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child:Transform.translate(offset:Offset(0, -100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Text('sign in', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 33),),
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
                  : Text('LOGIN', style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color:Colors.white),
                     ),
                     onPressed: (_loading)?null:_loginUser,),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Transform.translate(offset: Offset(0,3)),
                                        Text('Dont\'t have an acconut?', style: TextStyle(fontWeight: FontWeight.w800,color: Colors.grey),),
                                        FlatButton(
                                         child: Text('Sign in'),
                                         onPressed: (){
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                                         },
                                         )
                                      ],
                                    ),
                                   
                                          ],
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
                                       ],
                                     ),
                                   );
                                }
                      
                        void _loginUser() async{

                          if(_formKey.currentState.validate()){
                        setState(() {
                              _loading = true;
                            });
                   
                          String email = _emailController.text;
                          String password = _passwordController.text;
                          User user = await authentication.login(email, password);
                          if(user != null){
                            setState(() {
                              _loading = false;
                            });
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                          }else{
                           
                           setState(() {
                              _loading = false;
                            });
                          }
                          
              }
          }
}