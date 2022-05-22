
import 'package:social_app/models/user_model.dart';

abstract class LogInSIgnUpState{}

class InitialLogInState extends LogInSIgnUpState{}

class LogInSuccessState extends LogInSIgnUpState{
  final String uid;

  LogInSuccessState(this.uid);
}

class LogInLoadState extends LogInSIgnUpState{}

class LogInErrorState extends LogInSIgnUpState{
  final String error;

  LogInErrorState(this.error);
}

class ChangePasswordVisibilityState extends LogInSIgnUpState{}

class ChangeIsSignUpState extends LogInSIgnUpState{}

class SignUpSuccessState extends LogInSIgnUpState{}

class SignUpLoadState extends LogInSIgnUpState{}

class SignUpErrorState extends LogInSIgnUpState{
  final String error;

  SignUpErrorState(this.error);
}

class CreateSuccessState extends LogInSIgnUpState{
  final UserModel? user;

  CreateSuccessState(this.user);
}

class CreateLoadState extends LogInSIgnUpState{}

class CreateErrorState extends LogInSIgnUpState{
  final String error;

  CreateErrorState(this.error);
}