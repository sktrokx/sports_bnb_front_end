import 'dart:convert';
import 'dart:ui';
import 'package:sportsbnb/ErrorConnecting.dart';
import 'package:sportsbnb/Loading.dart' as Loading;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:sportsbnb/LoginData.dart';
import 'package:sportsbnb/MatchRequests.dart';
import 'package:sportsbnb/NotAuthorizaed.dart';
import 'package:sportsbnb/PlayerMatches.dart';
import 'package:sportsbnb/TeamData.dart';
import 'package:sportsbnb/UserCredentials.dart';


class TeamRequests extends StatefulWidget
{

@override
State<StatefulWidget> createState() {
return TeamRequestsState();
}

}

class TeamRequestsState extends State<TeamRequests>
{

List<TeamDataRequest> listOfTeamRequests;

  @override
  Widget build(BuildContext context) {
      return Container(

        child: FutureBuilder
        (
          future: getTeamRequests(),
          builder: (context,snapshot)
        {
         if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.waiting)
         
            {
              return SpinKitChasingDots(
                color: Theme.of(context).bottomAppBarColor,
                size: 50,
              );
            }


           else if(snapshot.connectionState == ConnectionState.done)
                if(snapshot.data.isEmpty)
          {
              return Center(
                
                 
                                        child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  color:  Theme.of(context).primaryColor,
                      child: Container(
                        height: MediaQuery.of(context).size.height/15,
                        width: MediaQuery.of(context).size.width/1.5,
                        
                        child: 
                              Center(
                                child: Text(Language.Language.noTeamRequests,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                              ),
                                                  ),
                                              ),
                   
                
                                          );
                              
                                          
                                        
                              
          }
          else if (snapshot.data != null)
          {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,index)
              {
                  return getCardForTeamRequest(snapshot.data[index]);
              }
              );
          }
         } 
        )
      );
  }
Widget getCardForTeamRequest(snapshotData)
{
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      shape: RoundedRectangleBorder(

    borderRadius: BorderRadius.circular(15),
      ),
    child: Container(
      height: MediaQuery.of(context).size.height/6,
      // width: MediaQuery.of(context).size.width-30,
      child: Stack(
        children: [
              Positioned(
                right: MediaQuery.of(context).size.width/1.4,
                top: MediaQuery.of(context).size.height/30,
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Container(
                    height: MediaQuery.of(context).size.height/10,
                    width: MediaQuery.of(context).size.width/5,
                    child: (snapshotData.organizerImage == null)?
                    Image.asset('assets/noImage.jpeg'):
                    Image.memory(snapshotData.organizerImage)
                    ,
                  ),
                ) 
              ),

    Positioned(
                              top: MediaQuery.of(context).size.height/9,
                              child: 
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                                
                              ),
                              elevation: 10,
                              child: Container(
                                height: MediaQuery.of(context).size.height/30,
                                width: MediaQuery.of(context).size.width/3,
                                // color: Colors.red,
                              child: Center(child: Text(snapshotData.organizerName)),
                              ),
                            )
                            ),

              Positioned(
                left:MediaQuery.of(context).size.width/3.5 ,
                top: MediaQuery.of(context).size.height/20,
                child: Text(snapshotData.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,

                ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width/1.5,
                child: Container(
                  height: MediaQuery.of(context).size.height/6,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:25),
                        child: responseButton(snapshotData,Theme.of(context).buttonColor,()
                        async
                        {
                          Loading.ShowLoadingDialog.showLoaderDialog(context);
                          String pathToAcceptFriendRequest = 'http://192.168.10.26:8000/organize_matches/add_player_to_team/';
try{
                          var response = await http.post(pathToAcceptFriendRequest
                          ,
                          headers: <String,String>
                          {
                            'Content-Type':'application/json',
                            'Authorization': 'Token ' + UserCredentials.credentialsInstance.getTokenOfUser
                          },
                          body: jsonEncode(<String,dynamic>
                          {
                            'user_id':UserCredentials.credentialsInstance.getIdOfUser,
                            'request_id':snapshotData.id,
                            'team_id':snapshotData.teamId

                          }
                          )

                          );
                          if(response.statusCode == 200)
                          {
                            Navigator.pop(context);
                            setState(() 
                            {
                              
                            });
                          }
                          else if(response.statusCode == 401)
{
  NotAuthorizaed.showNotAuthorizedAlert(context);
}
                          else if (response.statusCode !=200 && response.statusCode == 401)
                          {
                            Navigator.pop(context);
                          }
}
catch(e)
{
  Navigator.pop(context);
  ErrorConnecting.ConnectingIssue(context);
}
                        }
                        ,
                        'Accept'
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:25),
                        child: responseButton(snapshotData,Theme.of(context).bottomAppBarColor,()
                        async
                        {
                          Loading.ShowLoadingDialog.showLoaderDialog(context);
                          String pathToAcceptFriendRequest = 'http://192.168.10.26:8000/organize_matches/delete_player_team_request/${snapshotData.id}';
try{
                          var response = await http.delete(pathToAcceptFriendRequest
                          ,
                          headers: <String,String>
                          {
                            'Content-Type':'application/json',
                            'Authorization':'Token '+ UserCredentials.credentialsInstance.getTokenOfUser
                          },
                          
                          

                          );
                          if(response.statusCode == 200)
                          {
                            Navigator.pop(context);
                            setState(() 
                            {
                              
                            });
                          }
                          else if(response.statusCode == 401)
{
  NotAuthorizaed.showNotAuthorizedAlert(context);
}
                          else if (response.statusCode !=200 && response.statusCode !=401)
                          {
                            Navigator.pop(context);
                          }
}
catch(e)
{
  Navigator.pop(context);
  ErrorConnecting.ConnectingIssue(context);
}
                        }
                        ,
                        'Decline'
                        ),
                      ),

                      
                    ],
                  ),
                ) 
                                
                                )
                        ],
                
                        )
                      ),
                    
                    ),
                  );
                }
                
                Future getTeamRequests()
                async
                {
                  
                  String pathToGetTeams = 'http://192.168.10.26:8000/organize_matches/show_team_requests_to_user/';
                try{
                var response = await http.post(pathToGetTeams,
                headers: <String,String>
                {
                  'Content-Type':'application/json',
                  'Authorization':'Token '+ UserCredentials.credentialsInstance.getTokenOfUser
                },
                body: jsonEncode(<String,dynamic>
                {
                  'user_id':UserCredentials.credentialsInstance.getIdOfUser,
                  
                })
                );
                if(response.statusCode == 200)
                {
                listOfTeamRequests = List<TeamDataRequest>();
                List<dynamic> json = jsonDecode(response.body);
                for(var item in json)
                {
                  TeamDataRequest currentData  = TeamDataRequest(item);
                  listOfTeamRequests.add(currentData);
                
                }
                return listOfTeamRequests;
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
                
                 Widget responseButton(snapshotData,Color clr,Function function,String toDo) 
                 {
                   return GestureDetector(
                     onTap: ()
                     {
                       function();
                     }
                     ,
                                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height:MediaQuery.of(context).size.height/20,
                          width: MediaQuery.of(context).size.width/4,
                          color: clr,
                            child: Center(child: Text(toDo,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                            )),
                        ),
                     ),
                   );
                 }
}