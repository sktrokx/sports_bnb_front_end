
class UserCredentials
{
  static final credentialsInstance = UserCredentials();
int _idOfUser;
String _AuthorizationOfUser;


 

  int get getIdOfUser => _idOfUser;

setIdOfUser(int idOfUser) {
    _idOfUser = idOfUser;
  } 

 String get getTokenOfUser => _AuthorizationOfUser;

setTokenOfUser(String token)
 {
   _AuthorizationOfUser = token;
 }
}