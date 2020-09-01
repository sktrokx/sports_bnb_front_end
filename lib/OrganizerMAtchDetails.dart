import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sportsbnb/BenchListOfPlayers.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:sportsbnb/ErrorConnecting.dart';
import 'package:sportsbnb/FoundMatchData.dart';
import 'package:sportsbnb/FoundMatchDetails.dart';
import 'package:sportsbnb/NotAuthorizaed.dart';
import 'package:sportsbnb/SearchPlayers.dart';
import 'package:sportsbnb/TeamForMatch.dart';
import 'package:sportsbnb/UserCredentials.dart';
import 'package:sportsbnb/WaitingListPlayers.dart';
class OrganizerMatchDetails extends StatefulWidget {
int matchId;
int matchType;
int totalPlayers;
OrganizerMatchDetails(int matchId,int totalPlayers,int matchType)
{
this.matchId = matchId;
this.totalPlayers = totalPlayers;
this.matchType = matchType;
}
@override
OrganizerMatchDetailsState createState() => OrganizerMatchDetailsState(matchId,totalPlayers,matchType);
}
List<FoundMatchDetails> listOfMatcheDetails;
Future getMatchDetails;

class OrganizerMatchDetailsState <T extends StatefulWidget> extends State<T>
{
int matchId;
int totalPlayers;
int matchType;
OrganizerMatchDetailsState(matchId,totalPlayers,matchType)
{
this.matchId = matchId;
this.matchType = matchType;
this.totalPlayers=totalPlayers;
}

@override
void initState() {

super.initState();
getMatchDetails  = matchDetails();
}
String get nothingFound
{
return Language.Language.noPlayersAdded;
}

String get appBarTitle
{
return Language.Language.confirmedPlayers;
}

@override
Widget build(BuildContext context) {
return 

Scaffold(
// floatingActionButton: getFloatingActionButton(),
appBar: AppBar(
backgroundColor: Theme.of(context).bottomAppBarColor,
title: Text(appBarTitle

),
),

body:                FutureBuilder(
future: getMatchDetails
,builder:(context,snapshot)
{

if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.waiting)
{
return SpinKitChasingDots(
color:Theme.of(context).bottomAppBarColor,
);
}

if (snapshot.connectionState == ConnectionState.done)
{
if(snapshot.data.isEmpty)
{
return Center(
child: ClipRRect(
borderRadius: BorderRadius.circular(50),
child: Container(
height: MediaQuery.of(context).size.height/15,
width: MediaQuery.of(context).size.width/1.8,
color: Theme.of(context).buttonColor,
child: Center(
child: Stack(
children: [

Text(nothingFound,
style: TextStyle(
color: Colors.white,
fontSize: 18,
fontWeight: FontWeight.bold
),

),
//  addIcon

],
),
),
),
),
);
}

else if(snapshot.data != null)
{
return ListView.builder(
itemCount: snapshot.data.length,
itemBuilder: (context,index)
{
return playerDateGui(snapshot.data[index]);
}
);
}
}
}
)
) 

;
}

Widget get addIcon
{
return Icon(Icons.add,
color: Colors.white);
}

String get pathToGetDetails
{
return 'http://192.168.10.26:8000/organize_matches/show_organizer_match_detail/${matchId}';
}

Future matchDetails()
async
{
String pathToGetMAtchDetails = pathToGetDetails;
try{
var response = await http.get(pathToGetMAtchDetails,
headers: <String,String>
{
'Content-Type':'application/json',
'Authorization':'Token '+ UserCredentials.credentialsInstance.getTokenOfUser

}
);
if(response.statusCode == 200)
{
listOfMatcheDetails = List<FoundMatchDetails>();

List<dynamic> json = jsonDecode(response.body);
for(var item in json)
{
FoundMatchDetails currentMatch =  FoundMatchDetails(item);
listOfMatcheDetails.add(currentMatch);
// debugPrint(currentMatch.title + 'current match title');
}
return listOfMatcheDetails;
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

Widget playerDateGui(snapshotData)
{
return Padding(
padding: const EdgeInsets.all(8.0),
child: Card(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15)
),
elevation: 10,

child: Container(
height: MediaQuery.of(context).size.height/6,
decoration: BoxDecoration(

),
// color: Colors.red,

width: MediaQuery.of(context).size.width-20,
child: Stack(
children: <Widget>[
Positioned(
top: MediaQuery.of(context).size.height/100,
right: MediaQuery.of(context).size.width/1.4,

child:ClipRRect(
borderRadius: BorderRadius.circular(150),
child: Container(
height: MediaQuery.of(context).size.height/10,
width:MediaQuery.of(context).size.width/5
,child: (snapshotData.playerImage == null)
?
Image.asset('assets/noImage.jpeg',
height: MediaQuery.of(context).size.height/20,
width:MediaQuery.of(context).size.width/6
,
):
(snapshotData.playerImage!=null)?
Image.memory(snapshotData.playerImage,
height: MediaQuery.of(context).size.height/20,
width:MediaQuery.of(context).size.width/6
):
Container()
,
),
) 

),
Positioned(
bottom: MediaQuery.of(context).size.height/9,
left: MediaQuery.of(context).size.width/3.8,
child: Text(snapshotData.playerName,
style: TextStyle(
fontSize: 18,
fontWeight:FontWeight.bold
),
),
),

Positioned(
left: MediaQuery.of(context).size.width/3,
bottom: MediaQuery.of(context).size.height/13,

child:(snapshotData.playerPhoneNumber != null)?

Text(snapshotData.playerPhoneNumber):

Text(Language.Language.noNumber)
),

Positioned(
left: MediaQuery.of(context).size.width/3,
bottom: MediaQuery.of(context).size.height/19,

child: Text(snapshotData.playerEmailId)),
Positioned(
left: MediaQuery.of(context).size.width/3,
bottom: MediaQuery.of(context).size.height/33,

child:(snapshotData.comment == null)?
printNullComment():
printComment(snapshotData.comment)
                                            
                                              ),
  Positioned(
    top: MediaQuery.of(context).size.height/50,
    left: MediaQuery.of(context).size.width-120,
    child: columnForOnly(snapshotData) 
      
      // Container(
      //   height: 10,
      //   width: 10,
      //   color: Colors.red,
      // )
      )
    
                      
                                    ]
                                  )
                                  )
                                  )
                                  );
                                              }
                                                Widget getFloatingActionButton()
                                              {
                                                return FloatingActionButton(
                                                  child: Icon(Icons.add),
                                                  backgroundColor: Theme.of(context).buttonColor,
                                                  onPressed:()
                                                  {
                      
                    
                      
                        return showDialog(context: context,
                                        builder: (context)
                                        {
                                            return AlertDialog(
                                                title: Text(Language.Language.whereToMOve),
                                               content: Text(Language.Language.continueToLeave),
                                              
                                              
                                                actions: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                
                                                                      dontDelete(Language.Language.teams,context),
                                                    yesDelete(Language.Language.searchPlayers,matchId)
                                                                            
                                                                      ],
                                                                )
                                                                              ],
                                                                          );
                                                                      }
                                                      );
                                                    }
                      
                    
                      
                                                  
                                                  
                                                  );
                                              } 
                      goTo()
                      
                      {
                      
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)
                      
                      {
                        return SearchPlayers(matchId);
                      }
    
                      ));
                      }
                      
                      Widget dontDelete(String res,context)
                                                      {
                                                        
                                                          return GestureDetector(
                                                            onTap: ()
                                                            
                                                            { 
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)
                                                          {
                                                            return TeamForMatch(matchId);
                                                          }  
                                                          ));             
                                                            }
                                                            ,
                                                            child: Card(
                                                              shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10)
                                                              ),
                                                              child: Container(
                                                                
                                                                child: Center(child: Text(res))),
                                                            )
                                                            
                                                            );
                                                      }
                      
                                                        Widget yesDelete(String res,int matchIde)
                                                      {
                                                        
                                                          return GestureDetector(
                                                            onTap: ()
                                                            async
                                                            { 
                                                              goTo();
                                                            }
                                                            ,
                                                            child: Card(
                                                              shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10)
                                                              ),
                                                              child: Text(res),
                                                            )
                                                            
                                                            );
                                                      }
                      
                      dialogBoxForMenu()
                        {
              return showDialog(context: context,
                                        builder: (context)
                                        {
                                            return AlertDialog(
                                                title: Text(Language.Language.detailsDialog),
                                                content: Text(Language.Language.detailsDialogContent),
                                                actions: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                                  dialogButton(
                                                                    Language.Language.onWaiting,
                                                                    ()
                                                                    {
                                                                      Navigator.push(context, MaterialPageRoute(builder: (context)
                                                                      {
                                                                          return WaitingListOfPlayers(matchId, totalPlayers, matchType);
                                                                      }  
                                                                      ));
                                                                    }
                                                                  ),
            
                                                                  dialogButton(
                                                                    Language.Language.onBench,
                                                                    ()
                                                                    {
                                                                      Navigator.push(context, MaterialPageRoute(builder: (context)
                                                                      {
                                                                          return BenchListOfPlayers(matchId, totalPlayers, matchType);
                                                                      }  
                                                                      ));
                                                                    }
                                                                  ),
                                                                  
                                                                                                                          
                                                                          ],
                                                                )
                                                                              ],
                                                                          );
                                                                      }
                                                      );
                                                    }
                      
                                  
            Widget dialogButton(String str,Function function)
            {
              return GestureDetector(
                onTap: () 
                {
            function();
                },
                child: Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width/4,
                    height: MediaQuery.of(context).size.height/30,
                    color: Theme.of(context).buttonColor,
                  child: Center(
            child:        Text(str,
            style: TextStyle(
              color: Colors.white
            ),
            )
                  ),
                  ),
                ),
              );
            }
            
            Widget getActionButton() 
            {
              return GestureDetector(
              onTap: () => dialogBoxForMenu(),
                                child: Container(
                          // height:MediaQuery.of(context).size.height/50,
                          width: MediaQuery.of(context).size.height/16,
                          child: Icon(Icons.more_vert,
                          size: MediaQuery.of(context).size.width/12,
                          ),
                          // color: Colors.red,
                        ),
                      );
            }
    
      Widget columnForOnly(snap)
        {
              
    return 
    (snap.available!=null)?
    cantSend(snap.available):
    cantSend(Language.Language.available);
        }         
  
        setStateForChildClass()
        {
          setState(() {
            
          });
        }
  
    Widget printNullComment()
    {
      return Text(Language.Language.noComment);
    }

printComment(comment) 
{
  return Text(comment);
}

Widget cantSend(String str) 
              {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Theme.of(context).bottomAppBarColor,
                      height: MediaQuery.of(context).size.height/30,
                      width: MediaQuery.of(context).size.width/4,
                      child: Center(
                        child: Text(
                          str,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    );
              }

}