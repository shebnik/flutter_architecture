import 'dart:async';

import 'package:flutter_architecture_data/flutter_architecture_data.dart';
import 'package:flutter_architecture_model/flutter_architecture_model.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_bloc.freezed.dart';

@injectable
class MainBloc {
  final UserService userService;
  final StreamController<MainBlocEvent> _eventsController = StreamController();
  final StreamController<MainBlocState> _stateController =
      StreamController.broadcast();

  Stream<MainBlocState> get state => _stateController.stream;

  MainBloc({
    required this.userService,
  }) {
    _eventsController.stream.listen(
      (event) {
        event.map<void>(
          init: (_) async {
            _stateController.add(
              const MainBlocState.loading(),
            );
            _stateController.add(
              MainBlocState.loaded(
                userData: await userService.getDefaultUser(),
              ),
            );
          },
          setUser: (event) async => _stateController.add(
            MainBlocState.loaded(
              userData: await userService.getUserById(event.userId),
            ),
          ),
        );
      },
    );
  }

  void add(MainBlocEvent event) {
    if (_eventsController.isClosed) return;
    _eventsController.add(event);
  }

  void dispose() {
    _eventsController.close();
    _stateController.close();
  }
}

@freezed
class MainBlocState with _$MainBlocState {
  const factory MainBlocState.loading() = MainLoadingState;
  const factory MainBlocState.loaded({required UserData userData}) =
      MainLoadedState;
}

@freezed
class MainBlocEvent with _$MainBlocEvent {
  const factory MainBlocEvent.init() = _MainInitEvent;
  const factory MainBlocEvent.setUser({required int userId}) = _MainSetEvent;
}
