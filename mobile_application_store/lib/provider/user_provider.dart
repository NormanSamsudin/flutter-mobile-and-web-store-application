import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_application_store/models/user.dart';
// make the data accessible within the application
final userProvider =
    StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());

class UserProvider extends StateNotifier<User?> {
  // contructor initializing with default user object

  //purpose: Manage the state of the user object allowing updates
  UserProvider()
      : super(User(
          id: '',
          fullName: '',
          email: '',
          state: '',
          city: '',
          locality: '',
          password: '',
          token: '',
        ));

  // Getter method to extract value from an object
  User? get user => state;

  //method to set user state from json
  //porpuse : updates the user state base on the json string representation of user object

  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

  //method to clear user state
  void signOut(){
    state = null;
  }



}
