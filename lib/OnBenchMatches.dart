import 'package:flutter/material.dart';
import 'package:sportsbnb/PlayerMatches.dart';
import 'package:sportsbnb/UserCredentials.dart';

class OnBenchMatches extends StatefulWidget {
  @override
  _OnBenchMatchesState createState() => _OnBenchMatchesState();
}

class _OnBenchMatchesState extends PlayerMatchesState {

 @override
  // TODO: implement getRequestsOfEleven
 //yet to override
  String get getRequestsOfEleven 
  {
      return 'http://192.168.10.26:8000/organize_matches/show_player_matches_on_bench/${UserCredentials.credentialsInstance.getIdOfUser}';

  }

  
}