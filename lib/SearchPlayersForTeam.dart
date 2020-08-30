import 'package:flutter/widgets.dart';
import 'package:sportsbnb/SearchPlayers.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
class SearchPlayersForTeam extends StatefulWidget {
  int id;
  SearchPlayersForTeam(int id )
  {
    this.id = id;
  }

  @override
  State<StatefulWidget> createState() {
  return SearchPlayersForTeamState(id);
  }
  
   
}




class  SearchPlayersForTeamState extends SearchPlayersState 
{
  int id;
  SearchPlayersForTeamState(int id) : super(id)
  {   
  this.id = id;
  }

@override
  // TODO: implement mapForId
  String get mapForId => 'team_id';

  @override
  // TODO: implement alreadyPlaying
  String get alreadyPlaying => Language.Language.onTeam;


@override
String whereToAdd() {
  return Language.Language.whereToAddSearchPlayersForTeam;
  }

@override
  String pathTOAddRequest() {
   return  'http://192.168.10.26:8000/organize_matches/add_team_request_to_player/';
  }


  @override
  // TODO: implement searchPlayerWithName
  String get searchPlayerWithName => 'http://192.168.10.26:8000/organize_matches/search_players_for_team/';
}