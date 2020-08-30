import 'package:flutter/material.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:sportsbnb/OrganizerMAtchDetails.dart';

class DeclinedRequests extends StatefulWidget {
  
  int matchId;
  int totalPlayers;
  int matchType;

  DeclinedRequests(matchId,totalPlayers,matchType)
  {
this.matchId = matchId;
this.totalPlayers = totalPlayers;
this.matchType = matchType;
  }
  
  @override
  _DeclinedRequestsState createState() => _DeclinedRequestsState(matchId,totalPlayers,matchType);
}

class _DeclinedRequestsState extends OrganizerMatchDetailsState {
  
  int matchId;
  int totalPlayers;
  int matchType;
  
  _DeclinedRequestsState(matchId, totalPlayers, matchType) : super(matchId, totalPlayers, matchType)
  {
    this.matchId = matchId;
    this.totalPlayers = totalPlayers;
    this.matchType = matchType;
  }

  @override
  // TODO: implement appBarTitle
  String get appBarTitle => Language.Language.declined;

 @override
  String get nothingFound => Language.Language.noDeclinedRequests;


@override
  String get pathToGetDetails => 'http://192.168.10.26:8000/organize_matches/show_declined_requests_of_match_to_organizer/${matchId}';
}