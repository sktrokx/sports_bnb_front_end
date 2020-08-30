import 'package:flutter/material.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:sportsbnb/OrganizerMAtchDetails.dart';

class OnBenchList extends StatefulWidget {
  
  int matchId;
  int totalPlayers;
  int matchType;

  OnBenchList(matchId,totalPlayers,matchType)
  {
this.matchId = matchId;
this.totalPlayers = totalPlayers;
this.matchType = matchType;
  }
  
  @override
  _OnBenchListState createState() => _OnBenchListState(matchId,totalPlayers,matchType);
}

class _OnBenchListState extends OrganizerMatchDetailsState {
  
  int matchId;
  int totalPlayers;
  int matchType;
  
  _OnBenchListState(matchId, totalPlayers, matchType) : super(matchId, totalPlayers, matchType)
  {
    this.matchId = matchId;
    this.totalPlayers = totalPlayers;
    this.matchType = matchType;
  }

  @override
  // TODO: implement appBarTitle
  String get appBarTitle => Language.Language.onBench;

 @override
  String get nothingFound => Language.Language.onBench0;

//yet To override
@override
  String get pathToGetDetails => 'http://192.168.10.26:8000/organize_matches/show_organizer_bench_list_of_match/${matchId}';
}