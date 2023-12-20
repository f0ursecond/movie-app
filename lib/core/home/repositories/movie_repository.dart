import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/constant/url_constant.dart';
import 'package:movie_app/utils/failure.dart';

final dio = Dio();

class MovieRepository {
  Future<Either<Failure, bool>> getMovieDiscover() async {
    final apiKey = dotenv.env['API_KEY'];
    final accessToken = dotenv.env['ACCESS_TOKEN'];

    try {
      final response = await dio.get(
        '${UrlConstant.baseUrl}/3/discover/movie?api_key=$apiKey',
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        }),
      );

      final body = jsonDecode(response.data);
      debugPrint(body);
      return const Right(true);
    } on Error catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } on SocketException catch (e) {
      return Left(ServerFailure(message: 'No Connection $e'));
    }
  }
}
