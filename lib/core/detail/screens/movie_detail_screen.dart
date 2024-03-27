// ignore_for_file: avoid_print

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/constant/color_constant.dart';
import 'package:movie_app/constant/url_constant.dart';
import 'package:movie_app/core/detail/bloc/add_favorite_bloc.dart';
import 'package:movie_app/core/detail/cubit/movie_detail_cubit.dart';
import 'package:movie_app/core/models/res_movie_detail.dart';
import 'package:movie_app/core/repositories/movie_repository.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movieId});

  final String movieId;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final movieDetailCubit = MovieDetailCubit();
  late var addFavoriteBloc = AddFavoriteBloc();
  Future<bool?>? isFavoriteFuture;

  Future<bool?> checkIsFavoriteMovie() async {
    bool? isFavorite;
    final movieRepository = MovieRepository();
    final result = await movieRepository.getFavoriteMovie();

    result.fold((l) => print(l), (r) {
      for (var i = 0; i < r.length; i++) {
        final String listIdFromFavoritesMovie = r[i].id.toString();
        print('njir => $listIdFromFavoritesMovie');
        if (widget.movieId.contains(listIdFromFavoritesMovie)) {
          isFavorite = true;
          break;
        }
      }
    });
    print('OOK => $isFavorite');
    return isFavorite;
  }

  @override
  void initState() {
    isFavoriteFuture = checkIsFavoriteMovie();
    addFavoriteBloc = context.read<AddFavoriteBloc>();
    super.initState();
  }

  @override
  void dispose() {
    addFavoriteBloc.add(ResetAddFavoriteMovie());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: FutureBuilder<bool?>(
          future: isFavoriteFuture,
          builder: (context, snapshot) {
            print('njir ${snapshot.data}');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return SingleChildScrollView(
                child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
                  bloc: movieDetailCubit..getMovieDetail(widget.movieId),
                  builder: (context, state) {
                    if (state is MovieDetailSuccess) {
                      var data = state.result;
                      String title = data.title ?? "";
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: 'backgroundImage',
                            child: CachedNetworkImage(
                              progressIndicatorBuilder: (context, url, error) {
                                return const Center(
                                  child: CircularProgressIndicator(color: Colors.white),
                                );
                              },
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              imageUrl: '${UrlConstant.imageBackdropUrl}${data.backdropPath}',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 12.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AutoSizeText(
                                      title,
                                      style: TextStyle(
                                        fontSize: title.length >= 20 ? 18.sp : 24.sp,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    const Spacer(),
                                    favoriteWidget(snapshot)
                                  ],
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  data.tagline ?? '',
                                  style: const TextStyle(fontStyle: FontStyle.italic),
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_filled_rounded,
                                      size: 14.sp,
                                      color: Colors.grey.shade300,
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(formatMinutes(data.runtime ?? 0)),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Divider(color: Colors.grey.shade300, thickness: 1),
                                releaseDateWidget(data),
                                Divider(color: Colors.grey.shade300, thickness: 1),
                                genreWidget(data),
                                Divider(color: Colors.grey.shade300, thickness: 1),
                                SizedBox(height: 5.h),
                                Text(
                                  'Description',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  data.overview ?? '',
                                  overflow: TextOverflow.fade,
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    } else if (state is MovieDetailFailure) {
                      return Center(child: Text(state.failure.message));
                    } else {
                      return const Center(child: Text('Loading'));
                    }
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  GestureDetector favoriteWidget(AsyncSnapshot<bool?> snapshot) {
    return GestureDetector(
      onTap: () {
        if (snapshot.data == false || snapshot.data == null) {
          addFavoriteBloc.add(AddFavoriteMovie(widget.movieId));
        } else {
          print('udah ditambah ke film favorit');
        }
      },
      child: BlocConsumer<AddFavoriteBloc, AddFavoriteState>(
        listener: (context, state) async {
          if (state is AddFavoriteFailure) {
            var snackbar = SnackBar(content: Text(state.failure.message));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          } else if (state is AddFavoriteSuccess) {
            var snackbar = const SnackBar(content: Text('Film Favoritmu Berhasil Ditambahkan'));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        },
        builder: (context, state) {
          print('statee $state');
          if (state is AddFavoriteLoading) {
            return const CircularProgressIndicator();
          } else if (state is AddFavoriteSuccess) {
            return const Icon(
              Icons.favorite,
              color: Color(0xFFF44336),
              size: 45,
            );
          } else {
            return snapshot.data == null
                ? const Icon(
                    Icons.favorite_border,
                    size: 45,
                  )
                : const Icon(
                    Icons.favorite,
                    color: Color(0xFFF44336),
                    size: 45,
                  );
          }
        },
      ),
    );
  }

  SizedBox genreWidget(ResMovieDetail data) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        itemCount: data.genres!.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, idx) => SizedBox(width: 4.w),
        itemBuilder: (context, index) {
          return Chip(
            label: Text(data.genres![index].name ?? ''),
          );
        },
      ),
    );
  }

  SizedBox releaseDateWidget(ResMovieDetail data) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Release Date',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.h),
            Text(
              formatedDate(data.releaseDate ?? ''),
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}

String formatMinutes(int minutes) {
  Duration duration = Duration(minutes: minutes);
  int hours = duration.inHours;
  int remainingMinutes = duration.inMinutes.remainder(60);

  String formattedTime = '$hours h $remainingMinutes m';
  return formattedTime;
}

String formatedDate(String date) {
  DateTime stringToDateTime = DateTime.tryParse(date) ?? DateTime.now();
  final formatedDate = DateFormat('MMMM dd, yyyy').format(stringToDateTime);
  return formatedDate;
}
