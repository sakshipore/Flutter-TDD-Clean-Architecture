import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, int> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia({required this.repository});

  @override
  Future<Either<Failure, NumberTrivia>> call(int number) async {
    Either<Failure, NumberTrivia> res =
        await repository.getConcreteNumberTrivia(number);
    return res;
  }
}
