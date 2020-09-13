import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:colaboreapp/Model/ong.dart';
import 'package:colaboreapp/repositories/FirestoreOngs.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  UserRepository userRepository;
  HomeBloc({this.userRepository}) : super(HomeState.initial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    try {
      if (event is LoadingOngs) {
        yield* _mapGetOngs();
      }
    } on PlatformException catch (e) {
      yield HomeState.failure(message: e.message);
    }

    // if (event is LogOutButtonPressedEvent) {
    //   await userRepository.singOut();
    //   yield LogOutSucess();
    // }
  }

  Stream<HomeState> _mapGetOngs() async* {
    yield HomeState.loading();
    try {
      var ongsFirestore = FirestoreOngs();

      var ongs = await ongsFirestore.allOngs();

      yield HomeState.sucess(ongs: ongs);
    } on Exception catch (e) {
      HomeState.failure(message: e.toString().replaceAll('Exception', ''));
    }
  }
}
