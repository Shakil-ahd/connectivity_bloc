import 'dart:async';

import 'package:connectivity_bloc/bloc/internet_event.dart';
import 'package:connectivity_bloc/bloc/internet_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetBloc() : super(InternetInitialState()) {
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetConnectedEvent>((event, emit) => emit(InternetConnectedState()));
    _startListening();
  }

  void _startListening() {
    connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      result,
    ) {
      print("Connectivity Result: $result");
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(InternetConnectedEvent());
      } else {
        add(InternetLostEvent());
      }
    });
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
