import 'package:flutter_architecture_data/flutter_architecture_data.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'bloc_factory.config.dart';

@InjectableInit()
void inititalizeBlocs() {
  initializeServices();
  $initGetIt(GetIt.I);
}