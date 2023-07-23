import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:flutter_tdd_clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(Empty()) {
    on<GetTriviaForConcreteNumber>(_handleGetNumberTriviaEvent);
    on<GetTriviaForRandomNumber>(_handleGetRandomTriviaEvent);
  }

  String getStringByFailure(Failure failure) {
    if (failure is ServerFailure) {
      return "Server Failure";
    } else if (failure is CacheFailure) {
      return "Cache Failure";
    } else {
      return "Unexpected Error";
    }
  }

  Future _handleGetNumberTriviaEvent(
      GetTriviaForConcreteNumber event, Emitter emit) async {
    final input = inputConverter.stringToUnsignedInteger(event.numberString);
    await input.fold((error) {
      emit(
        Error(
          message: "Invalid Input",
        ),
      );
    }, (n) async {
      emit(Loading());
      final failureOrTrivia = await getConcreteNumberTrivia(n);
      failureOrTrivia.fold((failure) {
        emit(
          Error(
            message: getStringByFailure(failure),
          ),
        );
      }, (trivia) {
        emit(
          Loaded(trivia: trivia),
        );
      });
    });
  }

  Future _handleGetRandomTriviaEvent(
      GetTriviaForRandomNumber event, Emitter emit) async {
    emit(Loading());
    final failureOrTrivia = await getRandomNumberTrivia(NoParams());
    failureOrTrivia.fold(
      (failure) {
        emit(
          Error(
            message: getStringByFailure(failure),
          ),
        );
      },
      (trivia) {
        emit(
          Loaded(trivia: trivia),
        );
      },
    );
  }
}
