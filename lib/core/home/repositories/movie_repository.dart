import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/constant/url_constant.dart';
import 'package:movie_app/core/home/models/res_movie.dart';
import 'package:movie_app/utils/failure.dart';

final dio = Dio();

class MovieRepository {
  Future<Either<Failure, List<ResDiscoverMovie>>> getMovieDiscover() async {
    final apiKey = dotenv.env['API_KEY'];
    final accessToken = dotenv.env['ACCESS_TOKEN'];

    try {
      final response = await dio.get(
        '${UrlConstant.baseUrl}/3/discover/movie?api_key=$apiKey',
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        }),
      );

      log('code => ${response.statusCode}');
      debugPrint('body => ${response.data['results']}');

      switch (response.statusCode) {
        case 200:
          final List<dynamic> data = response.data['results'];
          final result = data.map((e) => ResDiscoverMovie.fromJson(e)).toList();
          return Right(result);
        case 400:
          return Left(
            BadRequestFailure(message: 'Error | ${response.statusCode}'),
          );
        case 401:
          return const Left(UnauthorizedFailure(message: 'Unauthenticated'));
        case 404:
          return const Left(ServerFailure(message: 'Not Found'));

        default:
          return const Left(
              ServerFailure(message: 'Something Error With Server'));
      }
    } on Error catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } on SocketException catch (e) {
      return Left(ServerFailure(message: 'No Connection $e'));
    } on TimeoutException catch (e) {
      return Left(TimeoutFailure(message: 'Timeout | $e'));
    }
  }
}
