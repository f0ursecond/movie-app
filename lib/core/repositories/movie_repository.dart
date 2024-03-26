import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/constant/url_constant.dart';
import 'package:movie_app/core/detail/models/res_add_favorite.dart';
import 'package:movie_app/core/models/res_movie.dart';
import 'package:movie_app/core/models/res_movie_detail.dart';
import 'package:movie_app/utils/failure.dart';
import 'package:movie_app/utils/secure_storage.dart';

final dio = Dio();

class MovieRepository {
  Future<Either<Failure, List<ResMovie>>> getMovieDiscover() async {
    final apiKey = dotenv.env['API_KEY'];
    final accessToken = dotenv.env['ACCESS_TOKEN'];

    try {
      final response = await dio.get(
        '${UrlConstant.baseUrl}3/discover/movie?apiKey=$apiKey',
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        }),
      );

      log('code => ${response.statusCode}');
      // debugPrint('body => ${response.data['results']}');

      switch (response.statusCode) {
        case 200:
          final List<dynamic> data = response.data['results'];
          final result = data.map((e) => ResMovie.fromJson(e)).toList();
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
            ServerFailure(message: 'Something Error With Server'),
          );
      }
    } on Error catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } on SocketException catch (e) {
      return Left(ServerFailure(message: 'No Connection $e'));
    } on TimeoutException catch (e) {
      return Left(TimeoutFailure(message: 'Timeout | $e'));
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          message: 'Error | ${e.response?.statusCode}\n${e.response?.statusMessage}',
        ),
      );
    }
  }

  Future<Either<Failure, List<ResMovie>>> getTrendingMovie() async {
    final apiKey = dotenv.env['API_KEY'];
    final accessToken = dotenv.env['ACCESS_TOKEN'];

    try {
      final response = await dio.get(
        '${UrlConstant.baseUrl}3/trending/movie/day?api_key=$apiKey',
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        }),
      );

      log('code => ${response.statusCode}');
      //debugPrint('body => ${response.data['results']}');

      switch (response.statusCode) {
        case 200:
          final List<dynamic> data = response.data['results'];
          final result = data.map((e) => ResMovie.fromJson(e)).toList();
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
          return const Left(ServerFailure(message: 'Something Error With Server'));
      }
    } on Error catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } on SocketException catch (e) {
      return Left(ServerFailure(message: 'No Connection $e'));
    } on TimeoutException catch (e) {
      return Left(TimeoutFailure(message: 'Timeout | $e'));
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          message: 'Error | ${e.response?.statusCode}\n${e.response?.statusMessage}',
        ),
      );
    }
  }

  Future<Either<Failure, ResMovieDetail>> getMovieDetail(String movieId) async {
    try {
      final apiKey = dotenv.env['API_KEY'];
      final accessToken = dotenv.env['ACCESS_TOKEN'];

      final response = await dio.get(
        '${UrlConstant.baseUrl}/3/movie/$movieId?api_key=$apiKey',
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        }),
      );

      switch (response.statusCode) {
        case 200:
          return Right(ResMovieDetail.fromJson(response.data ?? {}));
        case 400:
          return Left(
            BadRequestFailure(message: 'Error | ${response.statusCode}'),
          );
        case 401:
          return const Left(UnauthorizedFailure(message: 'Unauthenticated'));
        case 404:
          return const Left(ServerFailure(message: 'Not Found'));
        default:
          return const Left(ServerFailure(message: 'Something Error With Server'));
      }
    } on Error catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } on TimeoutException catch (e) {
      return Left(TimeoutFailure(message: 'Timeout | $e'));
    } on SocketException {
      return const Left(ServerFailure(message: 'No Internet Connection'));
    }
  }

  Future<Either<Failure, List<ResMovie>>> getFavoriteMovie() async {
    final apiKey = dotenv.env['API_KEY'];
    final accessToken = dotenv.env['ACCESS_TOKEN'];

    try {
      final response = await dio.get(
        '${UrlConstant.baseUrl}3/account/20439781/favorite/movies?apiKey=$apiKey',
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        }),
      );

      log('code => ${response.statusCode}');

      switch (response.statusCode) {
        case 200:
          final List<dynamic> data = response.data['results'];
          final result = data.map((e) => ResMovie.fromJson(e)).toList();
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
            ServerFailure(message: 'Something Error With Server'),
          );
      }
    } on Error catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } on SocketException catch (e) {
      return Left(ServerFailure(message: 'No Connection $e'));
    } on TimeoutException catch (e) {
      return Left(TimeoutFailure(message: 'Timeout | $e'));
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          message: 'Error | ${e.response?.statusCode}\n${e.response?.statusMessage}',
        ),
      );
    }
  }

  Future<Either<Failure, ResAddFavorite>> postFavoriteMovie(String movieId) async {
    try {
      final apiKey = dotenv.env['API_KEY'];
      final accessToken = dotenv.env['ACCESS_TOKEN'];

      final response = await dio.post('${UrlConstant.baseUrl}/3/account/20439781/favorite?api_key=$apiKey',
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken',
          }),
          data: {
            "media_type": "movie",
            "media_id": movieId,
            "favorite": true,
          });

      print('cok => ${response.data}');

      switch (response.statusCode) {
        case 201:
          await SecureStorage.write("movieId", movieId);
          await SecureStorage.write("isFavorite", response.data['favorite']);
          return Right(ResAddFavorite.fromJson(response.data ?? {}));
        case 400:
          return Left(
            BadRequestFailure(message: 'Error | ${response.statusCode}'),
          );
        case 401:
          return const Left(UnauthorizedFailure(message: 'Unauthenticated'));
        case 404:
          return const Left(ServerFailure(message: 'Not Found'));
        default:
          return const Left(ServerFailure(message: 'Something Error With Server'));
      }
    } on Error catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } on TimeoutException catch (e) {
      return Left(TimeoutFailure(message: 'Timeout | $e'));
    } on SocketException {
      return const Left(ServerFailure(message: 'No Internet Connection'));
    }
  }
}
