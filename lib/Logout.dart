import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:share/share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sportsbnb/DatabaseHelper.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:sportsbnb/ErrorConnecting.dart';
import 'package:sportsbnb/LoginOrRegister.dart';
import 'package:sportsbnb/NotAuthorizaed.dart';
import 'package:sportsbnb/ReportAnInjury.dart';
import 'package:sportsbnb/SetCharacteristics.dart';
import 'package:sportsbnb/UserCredentials.dart';
import 'package:sportsbnb/UserInformation.dart';
import 'package:sportsbnb/Loading.dart' as Loading;
import 'package:sqflite/sqlite_api.dart';

class Logout extends StatefulWidget
{



@override
State<StatefulWidget> createState() {
return LogoutState();
}

}

class LogoutState extends State<Logout>
{

TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController customMessageController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();


DatabaseHelper instance;

LogoutState()
{
createInstanceForAllMatches();
}

Future createInstanceForAllMatches()
async
{

this.instance = DatabaseHelper.instance;

}




UserInformation userProfile;
Future getUserInformation;
@override
void initState() {
getUserInformation = userInformation();
super.initState();
}

int selectedFootValue = 1;

@override
Widget build(BuildContext context) {
return 
Scaffold(
appBar: AppBar(
leading: Container(),
title: Text(
Language.Language.settings
,
),
elevation: 10,
backgroundColor: Theme.of(context).bottomAppBarColor,),

body: FutureBuilder(
future: getUserInformation,
builder: (context,snapshot)
{
if(snapshot.data == null)
{
return SpinKitChasingDots(
size: 50,
color: Theme.of(context).bottomAppBarColor
);
}
else if(snapshot.connectionState == ConnectionState.active
||snapshot.connectionState == ConnectionState.waiting
)
{
return SpinKitChasingDots(
size: 50,
color: Theme.of(context).bottomAppBarColor,

);

}
else if(snapshot.connectionState == ConnectionState.done)
{
if(snapshot.data == null)
{
debugPrint('snapshot null hai bc');
}
else if(snapshot.data !=null)
{
return Container(
height:  MediaQuery.of(context).size.height,
width: MediaQuery.of(context).size.width,
child: 
Stack(
children: <Widget>[

Container(

child:   BackdropFilter(filter: ImageFilter.blur(
sigmaX:1, 
sigmaY:1
),
child:
Container(
height: MediaQuery.of(context).size.height,
color: Colors.black.withOpacity(0.3),
),
),
)
,


Container(
height: 350,
width: 425,
// color: Colors.red,
child: BackdropFilter(filter: ImageFilter.blur(
sigmaX: 5,
sigmaY: 10,

),
child: Container(
decoration: BoxDecoration(
gradient: LinearGradient

(
begin: Alignment.bottomLeft,
colors: 
[
Theme.of(context).bottomAppBarColor,
Theme.of(context).primaryColor,
Theme.of(context).buttonColor,
]
,

)
),
),
),
)
,

Positioned(
top: 75,
left: 134,
child: 
ClipRRect(
borderRadius: BorderRadius.circular(100),
child:Container(
color: Colors.white,
height: 150,
width: 150,


child: (snapshot.data.userPicture != null)? Image.memory(snapshot.data.userPicture,
height: MediaQuery.of(context).size.height/8,
width: MediaQuery.of(context).size.width/8,
)
:
Center(child: Text(Language.Language.uploadPicture)),
),
// ),
// ),


)
)

,

Positioned(child: 

GestureDetector(
onTap: ()
{
if(snapshot.data.userPicture == null)
{
uploadProfilePicture();
}
else
{
changeProfilePicture();
}
}
,
child: Icon(Icons.edit)),   
right: 10,
top: 10,
),



Positioned(
// left: 160,
top: 240,
child:Container(
height:MediaQuery.of(context).size.height/12,
// color: Colors.red,
width: MediaQuery.of(context).size.width,
// color: Colors.white,
child: 
Center(
child:   Stack(
children:<Widget>[  
//  Positioned(
//   left: 145,
// child:
Column(
children: <Widget>[
Text('${snapshot.data.firstName} ${snapshot.data.lastName}',
style: TextStyle(
fontSize: 25,
color: Colors.white
),
),

Text((snapshot.data.phoneNumber != null)?snapshot.data.phoneNumber
:
Language.Language.noNumber
,
style: TextStyle(
fontSize: 25,
color: Colors.white
),

)
],
),
// ),


]

),
)
,
) ,

),


Positioned(
left: MediaQuery.of(context).size.width/1.2,

top:MediaQuery.of(context).size.height/3.39,
child: GestureDetector(
onTap: ()
{
updateUserInformation(context,snapshot.data.firstName, snapshot.data.lastName,
snapshot.data.phoneNumber, snapshot.data.email) ;
},
child: Icon(Icons.edit)
)
),


Positioned(
left: MediaQuery.of(context).size.width-60,
top :MediaQuery.of(context).size.height/2,    
child: GestureDetector(
onTap: ()
{
// if(snapshot.data.playerCharacteristics == null)
// {
//   postUserCharacteristics();
//           }
//           else if(snapshot.data.playerCharacteristics != null)
//           {
//             updateUserCredentials();
//           }
//           // setUserCredentials();
screenForUserCharacteristics(context,snapshot.data);

},
child: Icon(Icons.edit)
)
),


Positioned(
top: 450,
child: Container(
height: 400,
width: 425,
// color: Colors.red,
child: Column(
children: <Widget>[

(snapshot.data.playerCharacteristics != null)?
snapshot.data.playerCharacteristics.leftFoot ==true?
customTileForAttr(Language.Language.playsWith, Language.Language.leftFoot, Icons.local_play):
customTileForAttr(Language.Language.playsWith, Language.Language.rightFoot, Icons.local_play)
:
customTileForAttr(Language.Language.playsWith, '- - -', Icons.local_play)
,         

(snapshot.data.playerCharacteristics != null)?


snapshot.data.playerCharacteristics.isGoalKeeper == true?
customTileForAttr(Language.Language.goalKeeper, Language.Language.yes, Icons.local_play):
customTileForAttr(Language.Language.goalKeeper, Language.Language.no, Icons.local_play)
:
customTileForAttr(Language.Language.goalKeeper, '- - -', Icons.local_play)            
,
(snapshot.data.playerCharacteristics != null)?
customTileForAttr(Language.Language.position, snapshot.data.playerCharacteristics.position, Icons.gps_fixed)
:
customTileForAttr(Language.Language.position, '- - -', Icons.local_play)
,




],
),
)),



Positioned(
top:320,
left:80,
child: Card(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15)
),
elevation: 10,
child: Container(

height: 50,
width:250,
color:Colors.white,
child:
Padding(
padding: const EdgeInsets.only(left:12),
child: Row(children: <Widget>[
Text(Language.Language.available,
style: TextStyle(
fontSize: 20
),
),
Padding(
padding: const EdgeInsets.only(left:  80),
child: CupertinoSwitch(value: snapshot.data.available,

onChanged: (bool value)
{
changeAvailabily(value);
}
),
),



],),
) 
),
) 
),



// Positioned(
//   bottom:10,
//   child:   Card(
//   shape: RoundedRectangleBorder(
//   borderRadius: BorderRadius.circular(10)

//   ),
//   child: Padding(
//   padding: const EdgeInsets.only(top:25),
//   child: Container(
//   height: MediaQuery.of(context).size.height/5.5,
//   width: MediaQuery.of(context).size.width-60,
//   child: Column(
//   children: <Widget>[
//   getCardForinfo(snapshot.data.firstName),

//   getCardForinfo(snapshot.data.lastName),


//   getCardForinfo(snapshot.data.email),
//   getCardForinfo(snapshot.data.phoneNumber),

//   ],
//   ),
//   ),
//   ),

//   ),
// ),
// Positioned(child:GestureDetector(
// onTap: ()
// {
// updateUserInformation(snapshot.data.firstName,snapshot.data.lastName,snapshot.data.phoneNumber
// ,snapshot.data.email);
// }
// ,
// ,
//                               child: Icon(Icons.edit

// ,size:25,
// ),
// ), 
// bottom:175 ,
// right: 60,
// ),




Positioned(
top: 10,
left: 25,
child:   InkWell(
onTap: ()
{
logoutUser(context);
}
,
child: Card(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10)

),
color: Theme.of(context).buttonColor,
child: Container(
height: MediaQuery.of(context).size.height/25,
width: MediaQuery.of(context).size.width/3,
child: Center(
child: Text(Language.Language.logOut,
style: TextStyle(
fontSize: 20,
color: Colors.white
),
),
),
),
),
),
),




Positioned(
top: 100,
left: 10,
child:   InkWell(
onTap: ()
{
// invite(context);
showDialogForCustomMessage();

          }
          ,
                child: ClipRRect(
borderRadius: BorderRadius.circular(150),
                
          child: Container(
          height: MediaQuery.of(context).size.height/13,
          width: MediaQuery.of(context).size.width/6,
          color: Theme.of(context).buttonColor,
          child: Center(
            child: Text(Language.Language.invite,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white
            ),
            ),
          ),
                            ),
                          ),
        ),
      ),

      
                  
      ]
      )
                                        );
                                      }
                                      }
                                      
                        
                                    }
                                  )
                              );
                          
                          }
                        
                          Future logoutUser(BuildContext context)
                          async
                          {
                            Loading.ShowLoadingDialog.showLoaderDialog(context);
                            String pathToLogoutUser = 'http://192.168.10.26:8000/registration/logout_user/';
                            try{
                            var response = await http.post(pathToLogoutUser,
                            headers: <String,String>
                            {
                              'Content-Type': 'application/json',
                              // 'Authorization': "Token "+UserCredentials.credentialsInstance['Authorization']
                              'Authorization': "Token "+UserCredentials.credentialsInstance.getTokenOfUser

                            },
                            body: jsonEncode(<String,dynamic>
                            {
                              'user_id':UserCredentials.credentialsInstance.getIdOfUser
                            }
                            )
                            );
                        
                            if(response.statusCode == 200)
                            {
                              Navigator.pop(context);
                              instance.delete();
                              instance.initializeDatabaseToNull();
                            
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
          {
              return LoginOrRegister();
          }
          ));                    
                      }
                                else if(response.statusCode == 500)
                            {
                              Navigator.pop(context);
                                        showDialog(context: context,builder: (context)
                                  {
                                      return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)
                        
                                          ),
                                          child: Center(
                                            child: Container(
                                              height: 30,
                                              
                                                child: Text(Language.Language.internalServerError),
                                            )
                                          ),
                                      );  
                                  }
                                  );
                                }  
                                else if(response.statusCode ==401)
                                {
                                  NotAuthorizaed.showNotAuthorizedAlert(context);
                                }

                                }
catch(e)
{
ErrorConnecting.ConnectingIssue(context);
}
                          }
                          Future<UserInformation> userInformation()
                        async
                          {
                            debugPrint('user information method chal raha hai');
                            String pathToGetUserInformation = 'http://192.168.10.26:8000/registration/get_user_information/${UserCredentials.credentialsInstance.getIdOfUser}';
                        
                        try{
                          var response = await http.get(pathToGetUserInformation,
                          headers: <String,String>
                          {
                            'Content-Type':'application/json',
                            // 'Authorization':'Token '+UserCredentials.credentialsInstance['Authorization']
                            'Authorization':'Token '+UserCredentials.credentialsInstance.getTokenOfUser

                          }
                          
                          );
                          if(response.statusCode == 200)
                          {
                            Map<String,dynamic> json = jsonDecode(response.body);
                            userProfile = UserInformation(json);
                            return userProfile;
                          }
else if(response.statusCode == 401)
{
NotAuthorizaed.showNotAuthorizedAlert(context);
}

                          else if(response.statusCode != 200)
                          {
                        debugPrint('nae yaar');
                          }
}
catch(e)
{
ErrorConnecting.ConnectingIssue(context);
}

                          }
                        
                          Widget getCardForinfo(data)
                          {
                            return Card(
                            child: Container(
                              height:30,
                              width: MediaQuery.of(context).size.width/1.2,
                              child: (data !=null)?Center(
                                child: Text(data,
                                style: TextStyle(
                                  fontSize: 20
                                ),
                                ),
                              ):
                              Text('-      -')
                            ),
                            );
                          }
      
      // Widget getCardForcharacteristics(leftFoot, rightFoor) 
      // {
      
      // }
      
      Future changeProfilePicture()
      async
      {
        Loading.ShowLoadingDialog.showLoaderDialog(context);
      final ImagePicker picker = ImagePicker();
      var pickedImage = await picker.getImage(source: ImageSource.gallery);
      if(pickedImage != null)
      {
      File img = File(pickedImage.path);
      
      String pathToChangeProfilePicture = 'http://192.168.10.26:8000/registration/set_profile_picture/';
      try{
      var response = http.MultipartRequest('PUT',Uri.parse(pathToChangeProfilePicture));
      response.files.add(await http.MultipartFile.fromPath('profile_picture', img.path));
      response.fields['user_id'] = UserCredentials.credentialsInstance.getIdOfUser.toString();
      response.headers['Authorization'] ='Token ' +  UserCredentials.credentialsInstance.getTokenOfUser;
      var result = await response.send();
      if(result.statusCode == 200)
      {
        Navigator.pop(context);
        setState(() {
          
        });
      }
      else if(result.statusCode == 401)
{
NotAuthorizaed.showNotAuthorizedAlert(context);
}
      
      else if(result.statusCode != 200)
      {
        Navigator.pop(context);
      showDialog(context: context,
      builder:(context)
      
      
      {
      return AlertDialog(
      title: Text(Language.Language.sorry),
      content: Text(Language.Language.photoCannotBeUploaded),
      );
      }
      );
      }
      }
catch(e)
{
ErrorConnecting.ConnectingIssue(context);
}
      }
      
      }
      
      Future updateUserInformation(context,firstName,lastName,phoneNumber,email)
      async 
      {
        
        return showDialog(context: context,
        builder:(context)
        {
      return AlertDialog(
      title: Text(Language.Language.enterPhoneNumber),
      actions: <Widget>[
      Form(
      // key: formKey,
      child:
      Container(
      height: MediaQuery.of(context).size.height/6,
      width: 250,
      child: Center(
      child: Column(
      children: <Widget>[
          // getTextForm(this.firstNameController,Language.Language.firstName),
          // SizedBox(height:10),
          // getTextForm(this.lastNameController,Language.Language.lastName),
          // SizedBox(height:10),
      
          getTextForm(this.phoneNumberController,Language.Language.phoneNumber),
          SizedBox(height:10),
      
      
          // getTextForm(this.emailController,Language.Language.email),
          // SizedBox(height:10),
      
      getSubmitButton()
      
      ]
      )
      )
      )
      )
      ]
      );
        }
        );
      
      }
      
        Widget getTextForm(TextEditingController customController , String s)
          {
              return TextFormField(
      obscureText: false,
      
      decoration: InputDecoration(
      border:OutlineInputBorder(
      //  borderSide: new BorderSide(color: Colors.deepOrange),
      borderRadius: BorderRadius.circular(20)
      ),
      
      labelText: s,
      
      ),
      
      controller: customController,
      validator: (value)
      {
      if(value.isEmpty)
      {
      return Language.Language.reequired;
      }
      },
      );
      
      
          }
      
        Widget getSubmitButton()
          
          {
            return InkWell(
        
        onTap: ()
        {
          saveUserInformation(context);
          
            }
        
        ,
        splashColor: Colors.green.shade50,
                                                        child: Card(
          color: Theme.of(context).buttonColor,
          child: Container(
            height:30,
            width: 200,
                    child: Center(child: Text(Language.Language.save,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    )),
          )
          ,
        ),
      );
          
          }
      
          Future saveUserInformation(BuildContext context)
          async
          {
            Loading.ShowLoadingDialog.showLoaderDialog(context);
            String pathToPostUserInformation = 'http://192.168.10.26:8000/registration/update_user_information/';
            
            try{
            var response = await http.put(pathToPostUserInformation,
            headers: <String,String>
            {
              'Content-Type':'application/json',
              'Authorization':'Token ' + UserCredentials.credentialsInstance.getTokenOfUser
            },
            body: jsonEncode(<String,dynamic>
            {
              'user_id':UserCredentials.credentialsInstance.getIdOfUser,
              'phone_number':phoneNumberController.text,
              // 'email':emailController.text,
              // 'first_name':firstNameController.text,
              // 'last_name':lastNameController.text
            }
            
            )
            );
            if(response.statusCode == 200)
            {
          // userInformation();
            Navigator.pop(context);
            Navigator.pop(context);
            setState(() {
              
            });
            }
            else if(response.statusCode == 401)
{
NotAuthorizaed.showNotAuthorizedAlert(context);
}
            else if(response.statusCode!=200)
            {
        {
      showDialog(context: context,
      builder:(context)
      
      
      {
      return AlertDialog(
      title: Text(Language.Language.sorry),
      content: Text(Language.Language.dataCanNotBeUploaded),
      );
      }
      );
      }
            
            }
      }
catch(e)
{
ErrorConnecting.ConnectingIssue(context);
}
          }
      
        Future uploadProfilePicture()
  async
  {
    Loading.ShowLoadingDialog.showLoaderDialog(context);
  final ImagePicker picker = ImagePicker();
  try{
  var pickedImage = await picker.getImage(source: ImageSource.gallery);
  if(pickedImage != null)
  {
  File img = File(pickedImage.path);
  
  String pathToChangeProfilePicture = 'http://192.168.10.26:8000/registration/set_profile_picture/';
  var response = http.MultipartRequest('POST',Uri.parse(pathToChangeProfilePicture));
  response.files.add(await http.MultipartFile.fromPath('profile_picture', img.path));
  response.fields['user_id'] = UserCredentials.credentialsInstance.getIdOfUser.toString();
  
  response.headers['Authorization'] ='Token ' +  UserCredentials.credentialsInstance.getTokenOfUser;
  var result = await response.send();
  if(result.statusCode == 200)
  {
  Navigator.canPop(context);
  setState(() {
    
  });
  }
else if(result.statusCode == 401)
{
NotAuthorizaed.showNotAuthorizedAlert(context);
}

  else if(result.statusCode == 400)
  {
    Navigator.pop(context);
  showDialog(context: context,
  builder:(context)
  
  
  {
  return AlertDialog(
  title: Text(Language.Language.sorry),
  content: Text(Language.Language.photoCannotBeUploaded),
  );
  }
  );
  }
  
  }
  }
catch(e)
{
ErrorConnecting.ConnectingIssue(context);
}
  
  }
  
    Widget customTileForAttr(String title,String titleAns,IconData iconData)
    
    {
        return Container(
          height: 75,
          // color: Colors.red,
                              child: Padding(
                                padding: const EdgeInsets.only(left:25),
                                child: Row(
              children: <Widget>[
              Icon(iconData,
              size: 30,),
                Padding(
                  padding: const EdgeInsets.only(left:25,top: 20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 17
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0,left:50),
                        child: Text(titleAns,
                        style: TextStyle(
                          fontSize: 16
                        ),),
                      )
                    ],
                  ),
                )
              ],

          ),
                              ),
        );

    }

void changeAvailabily(bool value)
{
if(value == false)
{
Navigator.push(context, MaterialPageRoute(builder: (context)
{
return ReportAnInjury(); 
}));
}
else if(value == true)
{
userIsAvailable(value);
}
}


Future userIsAvailable(bool value)
async
{
Loading.ShowLoadingDialog.showLoaderDialog(context);
String pathToSetUserAvailabilityToTrue = 'http://192.168.10.26:8000/period_of_unavail/set_user_available/';
try{
var response = await http.post(pathToSetUserAvailabilityToTrue
,
headers: <String,String>
{
'Content-Type':'application',
'Authorization':'Token ' + UserCredentials.credentialsInstance.getTokenOfUser
},
body: jsonEncode(<String,dynamic>
{
'is_active':value,
'user_id':UserCredentials.credentialsInstance.getIdOfUser
}
)
);
if(response.statusCode == 200 || response.statusCode != 200)
{
Navigator.pop(context); 
if(response.statusCode == 200)
{
setState(() {

});
}
}
else if(response.statusCode == 401)
{
NotAuthorizaed.showNotAuthorizedAlert(context);
}


}
catch(e)
{
ErrorConnecting.ConnectingIssue(context);
}
}

void invite(BuildContext context)
{
final RenderBox box = context.findRenderObject();
String text;
if(Platform.isIOS)
{
text = 'link to app store of apple';
}
else if (Platform.isAndroid)
{
text = 'link to playstore of google';
}
try{
Share.share('''${customMessageController.text}    
${text}''',
subject: 'link',
sharePositionOrigin: box.localToGlobal(Offset.zero)& box.size,
);
}
catch(e)
{

showDialog(context: context,
builder: (context)
{
return AlertDialog(
  title: Text(Language.Language.sorryCantBeSent),
  content: Text(Language.Language.viaChossenOption),
  
                            );
                        }
        );
      }

}


void screenForUserCharacteristics(BuildContext context,snap) 
{
Navigator.push(context, MaterialPageRoute(builder: (context)
{
return SetCharacteristics(snap);
}
));
}

void showDialogForCustomMessage() 
{
showDialog(context: context,
        builder:(context)
        {
      return AlertDialog(
      title: Text(Language.Language.enterPhoneNumber),
      actions: <Widget>[
      Form(
      // key: formKey,
      child:
      Container(
      height: MediaQuery.of(context).size.height/6,
      width: 250,
      child: Center(
      child: Column(
      children: <Widget>[
          // getTextForm(this.firstNameController,Language.Language.firstName),
          // SizedBox(height:10),
          // getTextForm(this.lastNameController,Language.Language.lastName),
          // SizedBox(height:10),
      
          getTextForm(this.customMessageController,Language.Language.enterCustomMessage),
          SizedBox(height:10),
      
      getaAddButton()
          // getTextForm(this.emailController,Language.Language.email),
          // SizedBox(height:10),
      
      
      ]
      )
      )
      )
      )
      ]
      );
        }
        );
      
}





Widget getaAddButton()
          
          {
            return InkWell(
        
        onTap: ()
        {
          Navigator.pop(context);
          invite( context);
          
            }
        
        ,
        splashColor: Colors.green.shade50,
                                                        child: Card(
          color: Theme.of(context).buttonColor,
          child: Container(
            height:30,
            width: 200,
                    child: Center(child: Text(Language.Language.add,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    )),
          )
          ,
        ),
      );
          



          
          }

}