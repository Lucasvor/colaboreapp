import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/Model/usuario.dart';
import 'package:colaboreapp/repositories/FirestoreOngs.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

part 'homeong_event.dart';
part 'homeong_state.dart';

class HomeongBloc extends Bloc<HomeongEvent, HomeongState> {
  UserRepository userRepository;
  User user;
  HomeongBloc({this.userRepository, this.user}) : super(HomeongState.initial());

  @override
  Stream<HomeongState> mapEventToState(
    HomeongEvent event,
  ) async* {
    try {
      if (event is LoadHomeOng) {
        yield* _mapHomeLoad();
      }
    } on PlatformException catch (e) {
      yield HomeongState.failure(message: e.message);
    }
    // TODO: implement mapEventToState
  }

  Stream<HomeongState> _mapHomeLoad() async* {
    try {
      var ongsFirestore = FirestoreOngs();
      var ong = await ongsFirestore
          .getOng(user.email.replaceAll('@colaboreapp.com', ""));
      yield HomeongState.sucess(ong: ong);
    } on Exception catch (e) {
      HomeongState.failure(message: e.toString().replaceAll('Exception', ''));
    } catch (e) {
      print(e);
    }
  }
}
