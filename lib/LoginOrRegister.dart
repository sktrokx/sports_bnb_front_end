import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sportsbnb/DatabaseHelper.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:sportsbnb/HomeBar.dart';
import 'package:sportsbnb/UserCredentials.dart';

import 'package:sqflite/sqflite.dart';

import 'LogIn.dart';
import 'SignUp.dart';

class LoginOrRegister extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return LoginOrRegisterState();
  }
  
}

class LoginOrRegisterState extends State<LoginOrRegister>
{
@override
  void initState() {
    
    super.initState();
    checkIfUserIsLoggedIn();
      }
    
    
      
      @override
      Widget build(BuildContext context) {
      double customHeight = MediaQuery.of(context).size.height;
      double customWidth = MediaQuery.of(context).size.width;
        
        return Scaffold(
          appBar: AppBar(
            title:Text(Language.Language.sportsBnb),
            backgroundColor: Theme.of(context).bottomAppBarColor,
    
          ),
    
    body: ListView(
      children:<Widget>[
        Padding(
          padding: const EdgeInsets.only(top:50.0,left:45),
          child: Container(
            // color: Colors.purple.shade300.withOpacity(.8),
            height: MediaQuery.of(context).size.height/8,
            // width: MediaQuery.of(context).size.width/2,
                  child: Stack(
              
                    children:<Widget>[ 
                      
                       ClipRRect(
                         borderRadius: BorderRadius.only(
                           bottomLeft: Radius.circular(50),
                           topLeft: Radius.circular(15),
                           topRight: Radius.circular(15),
                           bottomRight: Radius.circular(15)
                         ),
                                            child: Container(
            color: Colors.blue.shade300.withOpacity(.8),
            height: MediaQuery.of(context).size.height/8,
            width: MediaQuery.of(context).size.width/1.28,
                         ),
                       ),
                      Row(
                children: <Widget>[
                  Text(Language.Language.sports,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 70
                  ),
                  ),
                  Text(Language.Language.bnb,
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 70
                  ),
                  )
                ],
              ),]
            ),
          ),
        ),
    
        Padding(
          padding: const EdgeInsets.only(top:480),
          child: GestureDetector(
                child: Card(
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              color: Theme.of(context).buttonColor,
              child: Container(
                height:MediaQuery.of(context).size.height/18,
                width:MediaQuery.of(context).size.width-30,
                child:Center(child: Text(Language.Language.signUp
                ,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white
                ),
                )),
              ),
            
            ),
            onTap: ()
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
              {
                return SignUp();
              }
              ));
            },
          ),
        ),
    
    
    
        Padding(
          padding: const EdgeInsets.only(top:15.0),
          child: GestureDetector(
                child: Card(
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              color: Theme.of(context).buttonColor,
              child: Container(
                height:MediaQuery.of(context).size.height/18,
                width:MediaQuery.of(context).size.width-30,
                child:Center(
                  child: Text(Language.Language.logIn,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white
                  ),
                  ),
                ),
              ),
            
            ),
            onTap: ()
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)
              {
                  return LogIn();
              } ));
            },
          ),
        ),
      ]
    ),
        );
        }
    
      Future checkIfUserIsLoggedIn()
      async
      {
         var db =await DatabaseHelper.instance.database;
         
         if(db != null)
         {

var count = Sqflite
         .firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM user_credentials'));
     if(count != 0)
   {  
     Map<String,dynamic> json = await DatabaseHelper.instance.fetch();
     UserCredentials.credentialsInstance.setIdOfUser(json['user_id']);
     UserCredentials.credentialsInstance.setTokenOfUser(json['Authorization']);
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
           
           {
              return HomeBar();
           }
           ));
   }
         }
      }
  
  }