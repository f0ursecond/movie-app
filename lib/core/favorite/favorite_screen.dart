import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/constant/color_constant.dart';
import 'package:movie_app/constant/url_constant.dart';
import 'package:movie_app/core/favorite/bloc/favorite_movie_bloc.dart';
import 'package:movie_app/core/models/res_movie.dart';
import 'package:movie_app/core/shared_widgets/custom_card.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final favMovieBloc = FavoriteMovieBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      appBar: AppBar(
        title: Text(
          'Film Yang Kamu Tambahkan Ke Favorit',
          style: TextStyle(fontSize: 14.sp),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
          bloc: favMovieBloc..add(GetFavoriteMovie()),
          builder: (context, state) {
            if (state is FavoriteMovieSuccess) {
              return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: favoriteItemWidget(state.result, index),
                ),
              );
            } else if (state is FavoriteMovieFailure) {
              return Center(child: Text(state.failure.message));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  CustomCard favoriteItemWidget(List<ResMovie> data, int index) {
    String formatedDate = DateFormat('dd MMMM yyyy').format(data[index].releaseDate ?? DateTime.now());

    return CustomCard(
      color: AppColors.kPrimaryColor,
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.blueGrey.shade300),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            width: 100,
            height: 150,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                placeholder: (context, url) => loadingWidget(),
                fit: BoxFit.fitWidth,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: '${UrlConstant.imageUrl}${data[index].posterPath}',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data[index].originalTitle ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(height: 30),
              Text('Rating : ${data[index].voteAverage!.toStringAsFixed(1)}'),
              Text('Release Date : $formatedDate'),
            ],
          ),
        ],
      ),
    );
  }

  Center loadingWidget() {
    return const Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: AppColors.kPrimaryColor,
        ),
      ),
    );
  }
}
