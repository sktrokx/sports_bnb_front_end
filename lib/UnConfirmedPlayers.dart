

import 'package:flutter/material.dart';
import 'package:sportsbnb/OrganizerMAtchDetails.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;

class UnConfirmedPlayers extends StatefulWidget {
  int matchId;
  int totalPlayers;
  int matchType;
  UnConfirmedPlayers(matchId,totalPlayers,matchType)
  {
    this.matchId = matchId;
    this.totalPlayers = totalPlayers;
    this.matchType = matchType;
  }
  @override
  _UnConfirmedPlayersState createState() => _UnConfirmedPlayersState(matchId,totalPlayers,matchType);
}

class _UnConfirmedPlayersState extends OrganizerMatchDetailsState {
 int matchId;
 int totalPlayers;
 int matchType;
 
  _UnConfirmedPlayersState(matchId, totalPlayers, matchType) : super(matchId, totalPlayers, matchType)
{
  this.matchId = matchId;
  this.totalPlayers = totalPlayers;
  this.matchType = matchType;
}
@override
  // TODO: implement appBarTitle
  String get appBarTitle => Language.Language.pendingPlayers;

@override
  // TODO: implement nothingFound
  String get nothingFound => Language.Language.noRequestsSent;

@override
  // TODO: implement pathToGetDetails
  String get pathToGetDetails => 'http://192.168.10.26:8000/organize_matches/show_unconfirmed_list_of_players_of_match/${matchId}';

 
}