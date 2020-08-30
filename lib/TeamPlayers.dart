import 'package:flutter/material.dart';
import 'package:sportsbnb/OrganizerMAtchDetails.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:sportsbnb/SearchPlayersForTeam.dart';
class TeamPlayers extends OrganizerMatchDetails {
  int matchId;
  int totalPlayers;
  int matchType;
  TeamPlayers(matchId,totalPlayers,matchType) : super(matchId, totalPlayers, matchType)
  {
    this.matchId = matchId;
    this.totalPlayers = totalPlayers;
    this.matchType = matchType;
  }
  @override
  TeamPlayersState createState() => TeamPlayersState(matchId,totalPlayers,matchType);
}

class TeamPlayersState extends OrganizerMatchDetailsState {
  int matchId;
  int totalPlayers;
  int matchType;
  TeamPlayersState(matchId, totalPlayers, matchType) : super(matchId, totalPlayers, matchType)
  {
    this.matchId = matchId;
    this.totalPlayers = totalPlayers;
    this.matchType = matchType;
  }
  
  @override
  // TODO: implement nothingFound
  String get nothingFound => Language.Language.noPlayersAdded;

 @override
  // TODO: implement pathToGetDetails
  String get pathToGetDetails => 'http://192.168.10.26:8000/organize_matches/show_players_of_team/${matchId}';

  @override
  // TODO: implement appBarTitle
  String get appBarTitle => Language.Language.players;
  @override
  goTo() {
    Navigator.push(context, MaterialPageRoute(builder: (context)
    {
      return SearchPlayersForTeam(matchId);
    }
    ));
  } 
@override
  Widget getFloatingActionButton() {
 return FloatingActionButton(
                                                child: Icon(Icons.add),
                                                backgroundColor: Theme.of(context).buttonColor,
                                                onPressed:()
                                                {
                                                  goTo();
                                                });
  
    
  }
  
}