import 'package:flutter/material.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:sportsbnb/WaitingListPlayers.dart';

class BenchListOfPlayers extends StatefulWidget {
   int matchId;
   int totalPlayers;
   int matchType;
  BenchListOfPlayers(matchId,totalPlayers,matchType)
  {
    this.matchId = matchId;
    this.totalPlayers = totalPlayers;
    this.matchType  = matchType;
  }
  
  @override
  BenchListOfPlayersState createState()
  {
   return BenchListOfPlayersState(matchId,totalPlayers,matchType);
  }
}

class BenchListOfPlayersState extends WaitingListOfPlayersState
 {
   int matchId;
   int totalPlayers;
   int matchType;
  BenchListOfPlayersState(int matchId, int totalPlayers, int matchType) : super(matchId, totalPlayers, matchType)
{
  this.matchId = matchId;
  this.totalPlayers = totalPlayers;
  this.matchType = matchType;
}


@override
  // TODO: implement nothingFound
  String get nothingFound => Language.Language.onBench0;

@override

  String get appBarTitle 
 {
   return Language.Language.onBench;
 }

 @override
  String get pathToGetDetails 
  {
return 'http://192.168.10.26:8000/organize_matches/show_organizer_bench_list_of_match/${matchId}';
  }

 
}