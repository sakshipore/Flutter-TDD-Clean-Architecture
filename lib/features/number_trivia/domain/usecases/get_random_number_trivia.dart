import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/number_trivia.dart';
import 'package:flutter_tdd_clean_architecture/core/usecases/usecase.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia({required this.repository});

  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    Either<Failure, NumberTrivia> res =
        await repository.getRandomNumberTrivia();

    return res;
  }
}
