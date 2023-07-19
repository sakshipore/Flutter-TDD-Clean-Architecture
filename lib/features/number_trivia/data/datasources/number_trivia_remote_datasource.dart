import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return await _getTriviaFromUrl("http://numbersapi.com/$number");
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    return await _getTriviaFromUrl("http://numbersapi.com/random");
  }

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    Uri uri = Uri.parse(url);
    final response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
