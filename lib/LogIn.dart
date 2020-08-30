import 'dart:convert';
import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:sportsbnb/DatabaseHelper.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:sportsbnb/ErrorConnecting.dart';
import 'package:sportsbnb/HomeBar.dart';
import 'package:sportsbnb/LoginOrRegister.dart';
import 'package:sportsbnb/UserCredentials.dart';

import 'package:sqflite/sqlite_api.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LogIn extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
 return LogInState();
  }

  

}

class LogInState extends State<LogIn>
{
            // LoginData user_credentials;

 
Map<String,dynamic> reservedData;
  String responceFromNetwork;
  TextEditingController emailController  = TextEditingController();
  TextEditingController passwordController  = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
 
 return WillPopScope(
   onWillPop: ()
   {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
     {
       return LoginOrRegister();
     }
     ));
   }
   ,
    child: Scaffold(
     appBar: AppBar(
      
           title: Center(
              child: Row(
                children: <Widget>[
                  Text(Language.Language.sports,
                  style: TextStyle(
                    color: Colors.blue,

                  ),

                  ),
                  Text(Language.Language.bnb,
                  style: TextStyle(
                    color: Colors.brown
                  ),
                  )

                ],
              ),
              
            ),
            backgroundColor: Theme.of(context).bottomAppBarColor,
     ),


      body: Padding(
        padding: const EdgeInsets.only(top:50,left: 25,right:25),
        child: ListView(
                children:<Widget>[ Form(
                key: _formKey,
                        child: Column(
                 children: <Widget>[
                   Text(Language.Language.logIn,
                   style:TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 50
                   )
                   
                   ),


    Container(
      child: Center(
        child:(responceFromNetwork != null)?
        Text(responceFromNetwork):
        Text("")

      ),
    ),

                   Padding(
                     padding: const EdgeInsets.only(top:75),
                     child: TextFormField(
                     
                              decoration: InputDecoration(
                              border:OutlineInputBorder(
                               ),
                                
                                  labelText: Language.Language.email,

                              ),
                     
                         controller: emailController,
                         cursorColor: Theme.of(context).cursorColor,
                         validator: (value)
                         {
                            if(value.isEmpty)
                            {
                              return Language.Language.enterEmail;
                            }
                         },
                       ),
                   ),
                   



                  Padding(
                    padding: const EdgeInsets.only(top:25),
                    child: TextFormField(


                              decoration: InputDecoration(
                              border:OutlineInputBorder(
                                 borderSide: new BorderSide(color: Colors.deepOrange)),
                                
                                  labelText: Language.Language.password,

                              ),
                         controller: passwordController,
                         validator: (value)
                         {
                            if(value.isEmpty)
                            {
                              return Language.Language.enterPassword;
                            }
                         },
                       ),
                  ),
                   

                     Padding(
                    padding: const EdgeInsets.only(top:25,right:25),
                    child: GestureDetector(
                                      child: Card(
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(15)
                             
                         ),
                         color: Theme.of(context).buttonColor,
                         child: Container(
                             height: MediaQuery.of(context).size.height/18,
                             width: MediaQuery.of(context).size.width,
                             child: Center(child: Text(Language.Language.logIn,
                             style: TextStyle(
                               fontSize: 20,color: Colors.white
                             ),
                             )),
                         ),
                       ),
                       onTap :() 
                       {
                         loginUser(context);
                       },
                     ),
                  ),

                   

              

                   Padding(
                    padding: const EdgeInsets.only(top:15,right:25),
                    child: GestureDetector(
                                      child: Card(
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(15)
                             
                         ),
                         color: Theme.of(context).buttonColor,
                         child: Container(
                             height: MediaQuery.of(context).size.height/18,
                             width: MediaQuery.of(context).size.width,
                             child: Center(child: Text(Language.Language.signUpWithFacebook,
                             style: TextStyle(
                               fontSize: 20,color: Colors.white
                             ),
                             )),
                         ),
                       ),
                       onTap :() 
                       {
                         loginUserWithFacebook();
                                                },
                                              ),
                                           ),
                         
                                          ],
                                         ),
                                       ),
                                         ]
                                 ),
                               ),
                         
                         
                              
                            ),
                          );
                           }
                          Future loginUser(BuildContext context)
                          async
                          {
                            String pathToLoginUser = 'http://192.168.10.26:8000/registration/login_user/';
                            String email,password;
                            if(_formKey.currentState.validate())
                            {
                              setState(() {
                                email = emailController.text;
                                password = passwordController.text;
                         
                              });
                                 try{
                                 var response = await http.post(pathToLoginUser,
                                 headers: <String,String>
                                 {
                                   'Content-Type': 'application/json'
                                 },
                                 body: jsonEncode(<String,String>
                                 {
                                   'email':email,
                                   'password':password,
                         
                                 }
                                 )
                                 );
                         
                                 if(response.statusCode == 200)
                                 {
                                     setState(() {
                                       responceFromNetwork = "";
                                     });
                                   Map<String,dynamic> json = jsonDecode(response.body);
                                 await DatabaseHelper.instance.insert({
                                     DatabaseHelper.user_id: json['user_id'],
                                     DatabaseHelper.Autorization : json['Authorization']      
                                           }
                                           );
                                           UserCredentials.credentialsInstance.setIdOfUser(json['user_id']);   
                                           UserCredentials.credentialsInstance.setTokenOfUser(json['Authorization']);
                                  await postMobileInfo();
                                  
                                      
                         
                                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                                   {
                                     return HomeBar();
                                   }
                                   ));
                                 }
                                 else if(response.statusCode == 400)
                                 
                                   {
                                 
                                   setState(() {
                                     responceFromNetwork = Language.Language.emailOrPasswordDoesNotMatch;
                                   });
                                   }
                                  else if(response.statusCode == 500)
                             {
                               setState(() {
                                 
                               responceFromNetwork = Language.Language.internalServerError;
                               });
                             } 
                                 
                                 
                            }
                         catch(e)
                         {
                           ErrorConnecting.ConnectingIssue(context);
                         }
                            }
                          }
                         
                          Future postMobileInfo()
                          async
                          {
                         
                               FirebaseMessaging firebaseMessaging = FirebaseMessaging();
                         
                               String fcmToken = await firebaseMessaging.getToken();
                               debugPrint('FCM token :'+fcmToken);
                               //  reservedData = await getInstanceQuery();
                               
                                  String pathTopostMobileInfo = 'http://192.168.10.26:8000/registration/update_mobile_info/';
                               
                               
                                  http.Response mobileResponse = await http.post(
                                                   pathTopostMobileInfo,
                                                   headers:<String,String>
                                                   {
                                                       'Content-Type':'application/json',
                                                       'Authorization': 'Token ' + UserCredentials.credentialsInstance.getTokenOfUser
                                                   },
                                                   body: jsonEncode(<String,dynamic>
                                                   {
                                                     'participant':UserCredentials.credentialsInstance.getIdOfUser,
                                                     'token': fcmToken,
                                                     'platform':(Platform.isAndroid)?'Android':
                                                     'iOS'
                                                   }
                                                   )
                               
                                                   
                                                   
                                               );
                                }
                         
                           Future loginUserWithFacebook()
                       async
                          {
                            final facebookLogin = FacebookLogin();
final result = await facebookLogin.logInWithReadPermissions(['email']);

switch (result.status) {
  case FacebookLoginStatus.loggedIn:
    _sendTokenToServerForFacebook(result.accessToken.token);
        // _showLoggedInUI();
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showCancelledMessage();
                break;
              case FacebookLoginStatus.error:
                _showErrorOnUI(result.errorMessage);
                                break;
                            }
                            
                                                      }
                            
                          Future     _sendTokenToServerForFacebook(String token)
                         async
                               {
                                String pathToSingInUserUsingFacebook = 'http://192.168.10.26:8000/registration/oauth/login/';
        var response = await http.post(pathToSingInUserUsingFacebook
        ,
headers: <String,String>
{
  'Content-Type':'application/json',
},
body: jsonEncode(<String,dynamic>
{
  'provider':'facebook',
  'access_token':token
}
)
        );
        if(response.statusCode == 200)
        {
          Map<String,dynamic> json = jsonDecode(response.body);

     await DatabaseHelper.instance.insert({
                                     DatabaseHelper.user_id: json['user_id'],
                                     DatabaseHelper.Autorization : json['Authorization']      
                                           }
                                           );
        
          UserCredentials.credentialsInstance.setIdOfUser(json['user_id']);
          UserCredentials.credentialsInstance.setTokenOfUser(json['Authorization']);
      await postMobileInfo();

Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)

{
  return HomeBar();
}
));
        } 
                               }
                        
                          void _showCancelledMessage() 
                          {
                            errorOnDialogue(Language.Language.youCanceledTheLogin);
                          }
                
                  void _showErrorOnUI(String errorMessage)
                   {
                     errorOnDialogue(Language.Language.somethingWentWrong);
                     debugPrint(errorMessage);
                   }
      
      //   getInstanceQuery() 
      //  async 
      //  {
      //     return  await DatabaseHelper.instance.fetch();
      //   } 

      void errorOnDialogue(String toShow)
       {
showDialog(
   context: context,
                                     builder: (context)
                                     {
                                         return AlertDialog(
                                             title: Text(toShow) );
                                                                           
   
                                                                   }
                                                   

                                                   );
}
      }
