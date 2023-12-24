import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/constant/color_constant.dart';
import 'package:movie_app/constant/url_constant.dart';
import 'package:movie_app/core/detail/screens/movie_detail_screen.dart';
import 'package:movie_app/core/home/cubit/discover_movie/discover_movie_cubit.dart';
import 'package:movie_app/core/home/cubit/trending_movie/trending_movie_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final discoverMovieCubit = DiscoverMovieCubit();
  final trendingMovieCubit = TrendingMovieCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      appBar: AppBar(
        title: const Text('Movie App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Discover Movie',
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            SizedBox(height: 15.h),
            BlocBuilder<DiscoverMovieCubit, DiscoverMovieState>(
              bloc: discoverMovieCubit..getMovieDiscover(),
              builder: (context, state) {
                if (state is DiscoverMovieSuccess) {
                  return discoverMovieWidget(state);
                } else if (state is DiscoverMovieFailure) {
                  return Center(
                    child: Text('${state.failure.message}\nCOK'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Trending Movie',
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            SizedBox(height: 10.h),
            BlocBuilder<TrendingMovieCubit, TrendingMovieState>(
              bloc: trendingMovieCubit..getTrendingMovie(),
              builder: (context, state) {
                if (state is TrendingMovieSuccess) {
                  return trendingMovieWidget(state);
                } else if (state is TrendingMovieFailure) {
                  return Center(
                    child: Text('${state.failure.message}\nCOK'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  SizedBox discoverMovieWidget(DiscoverMovieSuccess state) {
    return SizedBox(
      child: CarouselSlider.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index, int pageViewIndex) {
          var data = state.result[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(
                      movieId: data.id.toString(),
                    ),
                  ),
                );
              },
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: '${UrlConstant.imageUrl}${data.posterPath}',
              ),
            ),
          );
        },
        options: CarouselOptions(
          //enlargeCenterPage: true,
          aspectRatio: 9 / 7,
          autoPlay: true,
          viewportFraction: 0.60,
        ),
      ),
    );
  }
}

SizedBox trendingMovieWidget(TrendingMovieSuccess state) {
  return SizedBox(
    child: CarouselSlider.builder(
      itemCount: state.result.length,
      itemBuilder: (BuildContext context, int index, int pageViewIndex) {
        var data = state.result[index];
        return SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(
                            movieId: data.id.toString(),
                          ),
                        ),
                      );
                    },
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageUrl: '${UrlConstant.imageUrl}${data.posterPath}',
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  data.title ?? '',
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                )
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 240.h,
        aspectRatio: 5 / 3,
        autoPlay: true,
        viewportFraction: 0.40,
      ),
    ),
  );
}
