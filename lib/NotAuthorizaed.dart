import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sportsbnb/EnglishLanguage.dart' as Language;
import 'package:sportsbnb/LogIn.dart';
import 'package:sportsbnb/LoginOrRegister.dart';

class NotAuthorizaed extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
 static Widget showNotAuthorizedAlert(context)
{
 showDialog(
   barrierDismissible: false,
   context: context,
                                     builder: (context)
                                     {
                                         return AlertDialog(
                                             title: Text(Language.Language.notLoggedIng),
                                            //  content: Text(Language.Language.continueToLeave),
                                            
                                             actions: <Widget>[
                                             GestureDetector(
                                               onTap: ()
                                               {
                                                 Navigator.popUntil(context, (route) => false);
                                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                                                 {
                                                    return LoginOrRegister();
                                                 }
                                                 ));
                                               },
                                                                                            child: ClipRRect(
                                                 borderRadius: BorderRadius.circular(15),
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height/15,
                                                        width: MediaQuery.of(context).size.width/4,
                                                        color: Theme.of(context).buttonColor,
                                                        child: Center(
                                                          child: Text(Language.Language.logIn),
                                                        ),
                                                      ),
                                               ),
                                             )
                                             ]
                                                              );
                                                                           
   
                                                                   }
                                                   

                                                   );
}

}