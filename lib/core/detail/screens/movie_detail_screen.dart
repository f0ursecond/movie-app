import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/constant/color_constant.dart';
import 'package:movie_app/constant/url_constant.dart';
import 'package:movie_app/core/detail/cubit/movie_detail_cubit.dart';
import 'package:movie_app/core/models/res_movie_detail.dart';

class MovieDetailScreen extends StatelessWidget {
  MovieDetailScreen({super.key, required this.movieId});

  final String movieId;

  final movieDetailCubit = MovieDetailCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
            bloc: movieDetailCubit..getMovieDetail(movieId),
            builder: (context, state) {
              if (state is MovieDetailSuccess) {
                var data = state.result;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'backgroundImage',
                      child: CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, error) {
                          return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          );
                        },
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageUrl:
                            '${UrlConstant.imageBackdropUrl}${data.backdropPath}',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h),
                          Text(
                            data.originalTitle ?? '',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 2,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            data.tagline ?? '',
                            style: TextStyle(fontStyle: FontStyle.italic),
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
                return Center(
                  child: Text(state.failure.message),
                );
              } else {
                return const Text('Loading');
              }
            },
          ),
        ),
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
