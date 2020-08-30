import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class FoundMatchData
{
  String title;
  String city;
  String address;
  String date;
  String time;
  int frequency;
  bool benchListExist;
  int matchType;
  int totalPlayers;
  String dateAndTime;
int id;
int benchListLimit;
  FoundMatchData(Map<String,dynamic> json)
  {
    this.benchListLimit = json['bench_list_limit'];
    this.benchListExist = json['bench_list'];
    this.city = json['city'];
    this.address = json['address_of_stadium'];
this.id = json['id'];
      this.title = json['title'];
       this.dateAndTime = json['date_and_time'];
       this.date = dateAndTime.substring(0,10);
       this.time = dateAndTime.substring(11,16);
      this.frequency = json['frequency'];
      this.matchType = json['match_type'];
    this.totalPlayers = json['total_players'];
  this.matchType = json['match_type'];
  }
}