import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/constant/url_constant.dart';
import 'package:movie_app/core/home/cubit/discover_movie_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final discoverMovieCubit = DiscoverMovieCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<DiscoverMovieCubit, DiscoverMovieState>(
              bloc: discoverMovieCubit..getMovieDiscover(),
              builder: (context, state) {
                if (state is DiscoverMovieSuccess) {
                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          final data = state.result[index];
                          return Container(
                            width: 100,
                            height: 400,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    '${UrlConstant.imageUrl}${data.posterPath}'),
                              ),
                            ),
                          );
                        }),
                  );
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
          ],
        ),
      ),
    );
  }
}
