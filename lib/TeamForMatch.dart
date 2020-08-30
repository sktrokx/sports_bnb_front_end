import 'package:flutter/material.dart';
import 'package:sportsbnb/TeamPlayersForRequest.dart';
import 'package:sportsbnb/Teams.dart';

class TeamForMatch extends StatefulWidget {
  int matchId;
  TeamForMatch(matchId)
  {
this.matchId = matchId;
  }
  @override
  _TeamForMatchState createState() => _TeamForMatchState(matchId);
}

class _TeamForMatchState extends TeamsState {
  int matchId;
  _TeamForMatchState(matchId)
  {
    this.matchId = matchId;
  }

  @override
  void goToAbout(BuildContext context, snapshotData) {
    Navigator.push(context, MaterialPageRoute(builder: (context)
    {
      return TeamPlayersForRequest(snapshotData.id,matchId,0);
    }
    ));
  }
 
}