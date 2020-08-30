import 'dart:convert';
import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:sportsbnb/ErrorConnecting.dart';
import 'package:sportsbnb/LogIn.dart';
import 'package:sportsbnb/LoginOrRegister.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;

class SignUp extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
 return SignUpState();
  }
  
  }

  class SignUpState extends State<SignUp>
  {

    bool isOrganiser = false;
    String responseFromNetwork;
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
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

          body: ListView(
                    children:
                    <Widget>[
                     Form(
              key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(left:25,right: 25),
                        child: Column(
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(top:50),
                   child: Text(Language.Language.signUp,
                   style:TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 50
                   )
                   
                   ),
                   
                 ),

            Padding(
              padding: const EdgeInsets.only(top:15),
              child: Container(
                child: (responseFromNetwork !=null)?
                
                Text(responseFromNetwork):
                Text("")
              ),
            ),

                 Padding(
                   padding: const EdgeInsets.only(top:50),
                     child: TextFormField(
                       controller: firstNameController,
                         decoration: InputDecoration(
                        border:OutlineInputBorder(
                           borderSide: new BorderSide(color: Colors.deepOrange)),
                          
                            labelText: Language.Language.enterFirstName,

                        ),
                       validator: (value)
                       {
                            if(value.isEmpty)
                            {
                              return Language.Language.enterFirstName;
                            }
                       }
                     )
                 ),



                 Padding(
                   padding: const EdgeInsets.only(top:25),
                   child:TextFormField(
                       controller: lastNameController,
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                           borderSide: new BorderSide(color: Colors.deepOrange)),
                          
                            labelText: Language.Language.enterLastName,

                        ),
                       validator: (value)
                       {
                            if(value.isEmpty)
                            {
                              return Language.Language.enterLastName;
                            }
                       },
                     ),
                   
                 ),

                 Padding(
                   padding: const EdgeInsets.only(top:25),
                   child:  TextFormField(
                       controller: phoneNumberController,
                   
                      decoration: InputDecoration(
                        border:OutlineInputBorder(
                           borderSide: new BorderSide(color: Colors.deepOrange)),
                          
                            labelText: Language.Language.phoneNumber,

                        ),
                       validator: (value)
                       {
                            if(value.isEmpty)
                            {
                              return Language.Language.enterPhoneNumber;
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
                            
                              labelText: Language.Language.email,

                          ),
                   
                       controller: emailController,
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
                       obscureText: true,
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
                   padding: const EdgeInsets.only(top:25),
                   child: TextFormField(
                       obscureText: true,

                          decoration: InputDecoration(
                          border:OutlineInputBorder(
                             borderSide: new BorderSide(color: Colors.deepOrange)),
                            
                              labelText: Language.Language.confirmPassword,

                          ),
                       controller: confirmPasswordController,
                       validator: (value)
                       {
                            if(value.isEmpty)
                            {
                              return Language.Language.enterConfirmPassword;
                            }
                       },
                     ),
                 ),


                //  Padding(
                //    padding: const EdgeInsets.only(top:25),
                //    child: Card(
                //      elevation: 5,
                //      child: CheckboxListTile( 
                //        title: Text("sign up as organiser"),
                       
                       
                //        value: timeDilation !=1
                //        ,onChanged: (bool value)
                //      {

                //        setState(() {
                //          isOrganiser = value;
                //          timeDilation = value? 2:1;
                //        });
                //      }
                //      ),
                //    ),
                //  ),
                 

                 Padding(
                   padding: const EdgeInsets.only(right:25,top:25),
                   child: GestureDetector(
                                    child: Card(
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(15)
                           
                       ),
                       color: Theme.of(context).buttonColor,
                       child: Container(
                           height: MediaQuery.of(context).size.height/18,
                           width: MediaQuery.of(context).size.width,
                           child: Center(child: Icon(Icons.arrow_forward)),
                       ),
                     ),
                     onTap :() 
                     {
                       registerUser(context);
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
                      //  registerUserWithFacebook();
                     },
                   ),
                ),

      Padding(
        padding: const EdgeInsets.only(top:18.0,bottom: 50),
        child: GestureDetector(
                child: Center(child: Text
          (
              Language.Language.alreadyHaveAnAccount,
              style: TextStyle(
                  fontSize: 18
              ),
          )),
          onTap: ()
          {
              Navigator.push(context, MaterialPageRoute(builder: (context)
              {
                return LogIn();
              }
              ));
          },
        ),
      )

               ],
              ),
                      ),
            ),
                    ]
          ),
                           
      ),
    );
    
    }
    
    Future registerUser(BuildContext context)
    async
    {
bool androidPhone,iosPhone = false;

      String pathToRegisterUser = 'http://192.168.10.26:8000/registration/register_user/';
      String firstName,lastName,email,password,confirmPassword,phoneNumber;
      if(_formKey.currentState.validate())
      {

        setState(() {
        firstName = firstNameController.text;
        lastName =lastNameController.text;
        email = emailController.text;
        password = passwordController.text;
        confirmPassword = confirmPasswordController.text;
        phoneNumber = phoneNumberController.text;

        });

  if(Platform.isAndroid)
  {
    androidPhone = true;
  }
  else if(Platform.isIOS)
  {
    iosPhone = true;
  }
      try{
      
      var response = await http.post(pathToRegisterUser,
      headers: <String,String>
      {
        'Content-Type': 'application/json',
        
        },
        body: jsonEncode(<String,dynamic>
        {
          'phone_number':phoneNumber,
          'email':email,
          'first_name':firstName,
          'last_name':lastName,
          'password':password,
          'confirm_password':confirmPassword,
          'is_organizer':isOrganiser,
          'android_phone':androidPhone,
          'ios_phone':iosPhone
         


        }
        )
      );

        if(response.statusCode == 200)
        {
          // Map<String,dynamic> json = jsonDecode(response.body);
          // setState(() {
          // });
            responseFromNetwork ="";
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
          {
              return LogIn();
          }
          ));
        } 
        else if(response.statusCode == 400)
        {
            setState(() {
              responseFromNetwork = Language.Language.passwordDoesNotMAtch;
            });
        }  

    else if(response.statusCode == 500)
    {
         setState(() {
           responseFromNetwork = Language.Language.internalServerError;
         });  
      }
      else if(response.statusCode == 203)
      {
        setState(() {
          responseFromNetwork = Language.Language.emailIsIncorrect;
        });
      }


      else
      {
        setState(() {
          responseFromNetwork = Language.Language.someErrorOccured;
        });
      }
      }
catch(e)
{
  // Navigator.pop(context);
  ErrorConnecting.ConnectingIssue(context);
}

        
    }     

      }


}

  
  