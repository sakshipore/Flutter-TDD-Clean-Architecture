import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  const Failure({this.properties=const[]});
}

//? General failures
abstract class ServerFailure extends Failure {}

abstract class CacheFailure extends Failure {}

