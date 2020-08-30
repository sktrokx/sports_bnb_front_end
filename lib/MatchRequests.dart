import 'dart:convert';
import 'dart:ui';

import 'package:sportsbnb/ErrorConnecting.dart';
import 'package:sportsbnb/Loading.dart' as Loading ;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:sportsbnb/FoundMatchData.dart';
import 'package:sportsbnb/LoginData.dart';
import 'package:sportsbnb/MatchRequestData.dart';
import 'package:sportsbnb/NotAuthorizaed.dart';
import 'package:sportsbnb/PlayerMatches.dart';
import 'package:sportsbnb/UserCredentials.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;

class MatchRequests extends StatefulWidget
{



@override
State<StatefulWidget> createState() {
return MatchRequestsState();
}

}


class MatchRequestsState extends PlayerMatchesState
{

TextEditingController commentController = TextEditingController();

@override 
String get noWhat
{
  return Language.Language.noMatchRequests;
}

// String  getUrlToAddPlayerToMatchOfThree = 'http://192.68.10.26:8000/organize_matches/add_player_to_match_of_three/';
// String getUrlToAddPlayerToMatchOfSeven = 'http://192.68.10.26:8000/organize_matches/add_player_to_match_of_seven/';
@override
String getUrlToAddPlayerToMatchOfEleven = 'http://192.168.10.26:8000/organize_matches/add_player_to_match_of_eleven/';


// String urlToDeletePlayerFromMatchOfThree = 'http://192.168.10.26:8000/organize_matches/delete_player_request_of_match_of_three/<match_id>/<player_id>';//yet to override
// String urlToDeletePlayerFromMatchOfSeven = 'http://192.168.10.26:8000/organize_matches/delete_player_request_of_match_of_seven/<match_id>/<player_id>';//yet to override
@override 
String urlToDeletePlayerFromMatchOfEleven = 'http://192.168.10.26:8000/organize_matches/delete_player_match_request/';//yet to override



  @override
  String get getRequestsOfEleven
{
  return 'http://192.168.10.26:8000/organize_matches/show_player_requests_of_matches_of_eleven/${UserCredentials.credentialsInstance.getIdOfUser}';

}
// @override
// String get getRequestsOfSeven
// {
//     return 'http://192.168.10.26:8000/organize_matches/show_player_requests_of_matches_of_seven/${UserCredentials.credentialsInstance.getIdOfUser}';
// ;
// }
// @override
// String get getRequestsOfThree
// {
//     return 'http://192.168.10.26:8000/organize_matches/show_player_requests_of_matches_of_three/${UserCredentials.credentialsInstance.getIdOfUser}';
// }

List<MatchRequestData> listOfMatchRequestData; 
@override
String get appBarTitle
{
  return Language.Language.matchRequests;
}



@override 
Widget getPlayersOfMatch(context,snapshotData,urlToPostRequest,urlToDelete)
{
  

  return Container(
      height: MediaQuery.of(context).size.height/20,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).buttonColor,
      child:(snapshotData.hasAccepted ==  false && snapshotData.hasDeclined == false)?
      Row(
        children: [

          Padding(
            padding: const EdgeInsets.only(left:25),
            child: getCustomButton(Language.Language.accept,
            ()
            async
            {
              Loading.ShowLoadingDialog.showLoaderDialog(context);
              debugPrint('yes');
try{
              var response = await http.post(urlToPostRequest,
              headers: <String,String>
              {
                'Content-Type':'application/json',
                'Authorization':'Token ' + UserCredentials.credentialsInstance.getTokenOfUser
              },
              body: jsonEncode(<String,dynamic>
              {
                'user_id':UserCredentials.credentialsInstance.getIdOfUser,
                // 'Authorization':UserCredentials.credentialsInstance.getTokenOfUser,
                'match_id':snapshotData.matchData.matchId,
                'request_id':snapshotData.id,
                'comment':commentController.text
              })
              );
              if (response.statusCode == 200)
              {
                commentController.text = '';
                Navigator.pop(context);
                setState(() {
                  
                });
              }
              else if(response.statusCode == 401)
{
  NotAuthorizaed.showNotAuthorizedAlert(context);
}
}
catch(e)
{
  Navigator.pop(context);
  ErrorConnecting.ConnectingIssue(context);
}
            },
            true
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:25),
            child: getCustomButton(Language.Language.decline,
            ()
         async
            {
              Loading.ShowLoadingDialog.showLoaderDialog(context);
              
              debugPrint(snapshotData.id.toString());
    // try{

                var response = await http.post('${urlToDelete}',
                headers: <String,String>
                {
                  'Content-Type':'application/json',
                'Authorization':'Token ' + UserCredentials.credentialsInstance.getTokenOfUser
                },
                body: jsonEncode(<String,dynamic>
                
                  {
                'user_id':UserCredentials.credentialsInstance.getIdOfUser,
                'match_id':snapshotData.matchData.matchId,
                'request_id':snapshotData.id,
                'comment':commentController.text
                }
                )
                
                );
            

             if (response.statusCode == 200)
              {
                commentController.text = '';
                Navigator.pop(context);
                Navigator.pop(context);
                setState(() {
                  
                });
              }
              else if(response.statusCode == 401)
{
  NotAuthorizaed.showNotAuthorizedAlert(context);
}


            // }

            // catch(e)
// {
//   Navigator.pop(context);
//   ErrorConnecting.ConnectingIssue(context);
// }
}
,
            true
            ),
          )
        ],
      ):
      (snapshotData.hasAccepted == true && snapshotData.hasDeclined == false)?
      getCustomActionButton(Language.Language.accepted):
      (snapshotData.hasAccepted == false && snapshotData.hasDeclined == true)?
      getCustomActionButton(Language.Language.declined):
      Container()
      );

    
  
}
             
Widget getCustomButton(option,Function toDo,bool okToDo)
{
  return GestureDetector(
    onTap: ()
   async
    {
      if(okToDo==true)
     
      {
debugPrint('chal raha hai matchrequests');
dialogForComment(toDo, Language.Language.addComment);
      } 
    }
    ,
      child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child:Container(
      height: MediaQuery.of(context).size.height/22,
      width: MediaQuery.of(context).size.width/3,
      color: Theme.of(context).buttonColor,
      child: Center(
        child: Text(
          option,
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    ),
  )
  );
}




Widget getCustomActionButton(option)
{
  return  ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child:Container(
      height: MediaQuery.of(context).size.height/22,
      width: MediaQuery.of(context).size.width-30,
      color: Theme.of(context).buttonColor,
      child: Text(
        option
      ),
    )
  );
  
  
}
 

 @override
 Future getFutureBuilderData(getRequestsOfEleven)   async
              {
                try{
              
                var response =await http.get(getRequestsOfEleven
                ,
                headers: <String,String>
                {
                  'Content-Type':'application/json',
                  'Authorization':'Token '+UserCredentials.credentialsInstance.getTokenOfUser
                }
                );
                if(response.statusCode == 200)
                {
                  listOfMatchRequestData  = List<MatchRequestData>();
                  List<dynamic> json = jsonDecode(response.body);
                  if(json.isNotEmpty)
                  {
                    for(var item in json)
                    {
                      MatchRequestData data = MatchRequestData(item);
                      listOfMatchRequestData.add(data);
              
                    }
                    return listOfMatchRequestData;
                  }
                }
                else if(response.statusCode == 401)
{
  NotAuthorizaed.showNotAuthorizedAlert(context);
}
              }
catch(e)
{
  // Navigator.pop(context);
  ErrorConnecting.ConnectingIssue(context);
}
              }
              
 
 dialogForComment(Function function,String string)
{
showDialog(context: context,
        builder:(context)
        {
      return AlertDialog(
      title: Text(string),
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
      
          getTextForm(this.commentController,string),
          SizedBox(height:10),
      
      getSubmitButton(function)
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

           Widget getSubmitButton(Function function)
          
          {
            return InkWell(
        
        onTap: ()
       async
        {
          function();
          
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
}