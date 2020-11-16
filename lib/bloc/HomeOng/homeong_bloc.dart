import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:colaboreapp/repositories/UserRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'homeong_event.dart';
part 'homeong_state.dart';

class HomeongBloc extends Bloc<HomeongEvent, HomeongState> {
  UserRepository userRepository;
  HomeongBloc({this.userRepository}) : super(HomeongInitial());

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
    yield HomeongState.loading();
    try {} on Exception catch (e) {
      HomeongState.failure(message: e.toString().replaceAll('Exception', ''));
    } catch (e) {
      print(e);
    }
  }
}
