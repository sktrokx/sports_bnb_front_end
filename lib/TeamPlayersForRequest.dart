import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:sportsbnb/ErrorConnecting.dart';
import 'package:sportsbnb/NotAuthorizaed.dart';
import 'package:sportsbnb/OrganizerMAtchDetails.dart';
import 'package:sportsbnb/PlayerDataForTeamForMatch.dart';
import 'package:sportsbnb/SearchPlayersForTeam.dart';
import 'package:sportsbnb/UserCredentials.dart';
import 'package:http/http.dart' as http;
import 'package:sportsbnb/Loading.dart' as Loading;

class TeamPlayersForRequest extends StatefulWidget {
 int teamId;
 int matchId;
 TeamPlayersForRequest(teamId,matchId,noUse)
 {
   this.teamId = teamId;
   this.matchId = matchId;
 }
 
  @override
  _TeamPlayersForRequestState createState() => _TeamPlayersForRequestState(teamId,matchId,0);
}

class _TeamPlayersForRequestState extends OrganizerMatchDetailsState {
 
 List<PlayerDataForTeamForMatch> listOFPlayers;
 int teamId;
 int matchId;

  _TeamPlayersForRequestState(teamId, matchId, matchType) : super(teamId, matchId, matchType)
  {
    this.teamId  =teamId;
    this.matchId = matchId;
  }
 @override
  Widget columnForOnly(snap) {
    
    return 
    (snap.available!=null)?
    cantSend(snap.available):
    (snap.playing == true)?
    cantSend(Language.Language.playing):
        (snap.alreadyRequested == true )?
        cantSend(Language.Language.requested):
        (snap.onBenchList ==true )?
        cantSend(Language.Language.onBench):
        (snap.onWaitingList == true)?
        cantSend(Language.Language.onWaiting):
        // (snap.sent == true)?
        // requestSent(Language.Language.sent):
            
                canSend(Language.Language.ask,snap.playerId);
              }
            
            
                                      Future matchDetails()
                                                     async
                                                     {
                                                             String pathToGetMAtchDetails = pathToGetDetails;
                                                        
                                                         var response = await http.get(pathToGetMAtchDetails,
                                                         headers: <String,String>
                                                         {
                                                           'Content-Type':'application/json',
                  'Authorization':'Token '+ UserCredentials.credentialsInstance.getTokenOfUser
                                                         }
                                                         );
                                                         if(response.statusCode == 200)
                                                      {
                                                   listOFPlayers = List<PlayerDataForTeamForMatch>();
                                                   
                                                             List<dynamic> json = jsonDecode(response.body);
                                                             for(var item in json)
                                                             {
                                                               PlayerDataForTeamForMatch currentMatch =  PlayerDataForTeamForMatch(item);
                                                               listOFPlayers.add(currentMatch);
                                                               // debugPrint(currentMatch.title + 'current match title');
                                                             }
                                                             return listOFPlayers;
                                                           }
                                                           else if(response.statusCode == 401)
        {
          NotAuthorizaed.showNotAuthorizedAlert(context);
        }
        // }
        // catch(e)
        // {
        //   // Navigator.pop(context);
        //   ErrorConnecting.ConnectingIssue(context);
        // }
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
        
        
        
        Widget canSend(str,playerId) 
              {
                    return GestureDetector
                    (onTap: ()
                    
                    {
                      setState(() {
                        // sent = true;
                      });
                      askToJoin(playerId);
        
                    },
                                  child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: Theme.of(context).buttonColor,
                        height: MediaQuery.of(context).size.height/30,
                        width: MediaQuery.of(context).size.width/4,
                        child: Center(
                          child: Text(
                            str,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      ),
                    );
              }
        @override
          // TODO: implement pathToGetDetails
          String get pathToGetDetails => 'http://192.168.10.26:8000/organize_matches/show_team_players_for_match_request/${matchId}/${teamId}';
        
        
        String pathTOAddRequest()
        {
          return 'http://192.168.10.26:8000/organize_matches/add_request_to_player_of_match_of_eleven/';
        }
        
        Future askToJoin(playerId)
        async
        {
          Loading.ShowLoadingDialog.showLoaderDialog(context);
        String pathToAddRequestToUserMatches = pathTOAddRequest();
        try{
        var response =await http.post(pathToAddRequestToUserMatches
        ,
        headers: <String,String>
        {
        'Content-Type':'application/json',
                  'Authorization':'Token '+ UserCredentials.credentialsInstance.getTokenOfUser
        },
        body: jsonEncode(<String,dynamic>
        {
        'user_id':UserCredentials.credentialsInstance.getIdOfUser
        ,
        mapForId:matchId,
        mapForPlayer:playerId
        
        }
        )
        );
        
        if(response.statusCode == 200)
        {
          setState(() {
          
        });
        Navigator.pop(context);
        
        }
        else if(response.statusCode == 401)
        {
          Navigator.pop(context);
          NotAuthorizaed.showNotAuthorizedAlert(context);
        }
        }
        catch(e)
        {
          Navigator.pop(context);
          ErrorConnecting.ConnectingIssue(context);
        }
        }
        
        
        String get mapForId
        {
          return 'match_id';
        }
        
        String get mapForPlayer
        {
          return 'recieving_player_id';
        }
        
        @override
          Widget printNullComment() {
            // TODO: implement printNullComment
            return Container();
          }
          @override
          printComment(comment) {
            // TODO: implement printComment
            return Container();
          }
        
          // Widget requestSent(String sent)
          //  {
          //      return ClipRRect(
          //             borderRadius: BorderRadius.circular(15),
          //           child: Container(
          //             color: Theme.of(context).bottomAppBarColor,
          //             height: MediaQuery.of(context).size.height/30,
          //             width: MediaQuery.of(context).size.width/4,
          //             child: Center(
          //               child: Text(
          //                 sent,
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   color: Colors.white
          //                 ),
          //               ),
          //             ),
          //           ),
          //           );
          //  }


          @override
  Widget getFloatingActionButton() {
    // TODO: implement getFloatingActionButton
    return FloatingActionButton(
                                                child: Icon(Icons.add),
                                                backgroundColor: Theme.of(context).buttonColor,
                                                onPressed:()
                                                {
                                                  goTo();
                                                });
  
    
  }

  @override
  goTo() {
    Navigator.push(context, MaterialPageRoute(builder: (context)
    {
      return SearchPlayersForTeam(teamId);
    }
    ));
  } 
  
  }
