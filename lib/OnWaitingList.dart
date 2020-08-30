import 'package:flutter/material.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:sportsbnb/OrganizerMAtchDetails.dart';

class OnWaitingList extends StatefulWidget {
  
  int matchId;
  int totalPlayers;
  int matchType;

  OnWaitingList(matchId,totalPlayers,matchType)
  {
this.matchId = matchId;
this.totalPlayers = totalPlayers;
this.matchType = matchType;
  }
  
  @override
  _OnWaitingListState createState() => _OnWaitingListState(matchId,totalPlayers,matchType);
}

class _OnWaitingListState extends OrganizerMatchDetailsState {
  
  int matchId;
  int totalPlayers;
  int matchType;
  
  _OnWaitingListState(matchId, totalPlayers, matchType) : super(matchId, totalPlayers, matchType)
  {
    this.matchId = matchId;
    this.totalPlayers = totalPlayers;
    this.matchType = matchType;
  }

  @override
  // TODO: implement appBarTitle
  String get appBarTitle => Language.Language.onWaiting;

 @override
  String get nothingFound => Language.Language.onWaiting0;

//yet to override
@override
  String get pathToGetDetails => 'http://192.168.10.26:8000/organize_matches/show_organizer_waiting_list_of_match/${matchId}';
}