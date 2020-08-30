import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sportsbnb/DatabaseHelper.dart';
import 'package:sportsbnb/ErrorConnecting.dart';
import 'package:sportsbnb/LoginData.dart';
import 'package:sportsbnb/NotAuthorizaed.dart';
import 'package:sportsbnb/TeamData.dart';

import 'UserCredentials.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;


class SelectTeam extends StatefulWidget
{
  

  @override
  State<StatefulWidget> createState() {
 return SelectTeamState();
  }
  
}

class SelectTeamState extends State<SelectTeam>
{
  List<TeamData> teams =  List<TeamData>();
  DatabaseHelper instance;
 

  Future getTeams;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
getTeams = _getOrganizerTeams;
  }
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        title: Text(Language.Language.selectTeam),
      ),
      body: FutureBuilder(
        future: getTeams,
        builder: (context,snapshot)
      {
          if(snapshot.data == null)
          {
            return Container(
              child:
              Text(Language.Language.noTeams)
            );
          }
          else if(snapshot.connectionState == ConnectionState.waiting||snapshot.connectionState == ConnectionState.active)
          {
              return SpinKitSpinningCircle(
                size:50,
                color: Colors.brown,
              );
          }
          else if(snapshot.connectionState == ConnectionState.done)
          {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,index)
            {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                   ),
color: Colors.brown,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: 
                        Text(snapshot.data[index].titleOfTeam)
                        ),

                        Expanded(
                          flex: 9,
                                                  child: ListView.builder(
                            itemCount: snapshot.data[index].listOfPlayers.length,
                            itemBuilder: (context,i)
                          {
                            return Card(

                                                          child: Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10)

                                      ),
                                      child: Image.file(snapshot.data[index].listOfPlayers[i].userPictire),

                                    ),
                                    Text(snapshot.data[index].listOfPlayers[i].firstName + snapshot.data[index].listOfPlayers[i].lastName)
                                    ,
                                    Text(snapshot.data[index].listOfPlayers[i].phoneNumber)
                                  ],
                              ),
                            );
                          }
                          ),
                        ),
                      ],
                    ) ,
                  );
            }
            );

            }
      }
      ),
    );
  }
 Future get _getOrganizerTeams
 async
 {
   try{
   String pathToGetTeams = 'http://192.168.10.26:8000/organize_matches/user_teams';
  var response = await http.post(pathToGetTeams,
  headers: <String,String>
  {
    'Content-Type':'application/json',
    'Authorization':'Token '+ UserCredentials.credentialsInstance.getTokenOfUser
  },
  body: jsonEncode(<String,dynamic>
  
  {
    'user_id':UserCredentials.credentialsInstance.getIdOfUser,
  
  }
  )

  );
  if(response.statusCode == 200)
  {
    List<dynamic> json = jsonDecode(response.body);
    for(var item in json)
    { 
      TeamData currentTeam = TeamData(item);
      teams.add(currentTeam);
      }
      return teams;
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
}