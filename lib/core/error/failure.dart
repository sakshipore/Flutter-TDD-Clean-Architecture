import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  const Failure({this.properties=const[]});
}

//? General failures
 class ServerFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
 }

class CacheFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}

