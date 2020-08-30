import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;

class ErrorConnecting extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
 static Widget ConnectingIssue(context)
{
  showDialog(
   context: context,
                                     builder: (context)
                                     {
                                         return AlertDialog(
                                             title: Text(Language.Language.coneectingIssue),

                                             content: Text(Language.Language.checkInternetConnection),
                                            
                                                                                                         );
                                                                           
   
                                                                   }
                                                   

                                                   );
}

}