class MatchOverViewData
{
  int numberOfConfirmedPlayers;
  int matchType;
  int numberOfPlayersDeclined;
  int numberOfPlayersOnWaitingList;
  bool benchListExist;
  int numberOfPlayersOnBenchList;
  int numberOfPlayersAnswered;
  int numberOfPlayersInvited;
  String city;
  String address;
  int frequency;
  int pendingPlayers;
  String dateAndTime;
  String date;
  String time;
String title;
int benchListLimit;
  MatchOverViewData(Map<String,dynamic> json)
  {
    this.benchListLimit = json['bench_list_limit'];
    this.dateAndTime = json['date_and_time'];
    this.date = dateAndTime.substring(0,10);
    this.time = dateAndTime.substring(11,16);
    this.title = json['title'];
    this.pendingPlayers = json['number_of_pending_players'];
    this.numberOfConfirmedPlayers = json['number_of_confirmed_players'];
    this.matchType = json['match_type'];
    this.numberOfPlayersDeclined = json['number_of_declined_players'];
    this.numberOfPlayersOnWaitingList = json['number_of_players_on_waiting_list'];
    this.benchListExist = json['bench_list'];
    this.numberOfPlayersOnBenchList = json['number_of_players_on_bench_list'];
    this.numberOfPlayersAnswered = json['number_of_players_answered'];
    this.numberOfPlayersInvited = json['number_of_players_invited'];
    this.city = json['city'];
    this.address = json['address_of_stadium'];
    this.frequency = json['frequency'];
  }
}