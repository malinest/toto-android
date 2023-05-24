import 'globals.dart';

// Strings used in the app
class Strings {
  static String home = 'Home';
  static String boards = 'Boards';
  static String login = 'Log In';
  static String signup = 'Sign up';
  static String logout = 'Log out';
  static String no = 'No.';
  static String responseToPrefix = '>';
  static String successLogOutMsg = 'Successfully logged out.';
  static String failureGetDataMsg = 'Failed to load data.';
  static String unhandledStateMsg = 'Unhandled State.';
  static String unknownErrorMsg = 'Unknown error.';
  static String askRequestedFieldsMsg = 'Please fill all fields.';
  static String notMatchingPasswordMsg = "Passwords doesn't match.";
  static String emailInvalidMsg = 'Email not valid';
  static String passwordTooShortMsg = 'Password must be at least ${Globals.passwordMinLenght} characters long';
  static String usernameMsg = 'Username ';
  static String isAlreadyTakenMsg = ' is already taken.';
  static String userCreatedMsg = ' is already taken.';
  static String failedLoginMsg = "Username and password doesn't exists.";
  static String successSetComment = 'Comment published successfully';
  static String notFoundPostId = 'There is no post that has this id';
  static String unsupportedMediaPost = 'Invalid file format, only this formats are accepted: ';
}