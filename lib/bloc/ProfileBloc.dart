import 'dart:async';
import 'package:javizen/Models/LoginModel.dart';

class GetProfileBloc {
  final streamController = StreamController.broadcast();

  Stream get getStream => streamController.stream;

  LoginModel? profile;

  void getProfile(LoginModel? item) {
    profile = item;
    streamController.sink.add(this.profile);
  }

}

final GetProfileBloc getProfileBlocInstance = new GetProfileBloc();
