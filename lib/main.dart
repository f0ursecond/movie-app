import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/constant/color_constant.dart';
import 'package:movie_app/core/detail/bloc/add_favorite_bloc.dart';
import 'package:movie_app/core/detail/cubit/movie_detail_cubit.dart';
import 'package:movie_app/core/home/bloc/discover_movie/discover_movie_bloc.dart';
import 'package:movie_app/core/home/bloc/trending_movie/trending_movie_bloc.dart';
import 'package:movie_app/core/settings/bloc/anjay_bloc.dart';
import 'package:movie_app/core/settings/cubit/counter_cubit.dart';
import 'package:movie_app/router/route_path.dart';
import 'package:movie_app/router/router.dart';

Future main() async {
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieDetailCubit(),
        ),
        BlocProvider(
          create: (context) => CounterCubit(),
        ),
        BlocProvider(
          create: (context) => AnjayBloc(),
        ),
        BlocProvider(
          create: (context) => DiscoverMovieBloc(),
        ),
        BlocProvider(
          create: (context) => TrendingMovieBloc(),
        ),
        BlocProvider(
          create: (context) => AddFavoriteBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 712),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: RoutePath.homeScreen,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.kPrimaryColor,
            ),
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                color: Colors.white,
              ), // You can customize other styles as needed
              displayMedium: TextStyle(color: Colors.white),
              displaySmall: TextStyle(color: Colors.white),
              headlineMedium: TextStyle(color: Colors.white),
              headlineSmall: TextStyle(color: Colors.white),
              titleLarge: TextStyle(color: Colors.white),
              titleMedium: TextStyle(color: Colors.white),
              titleSmall: TextStyle(color: Colors.white),
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
              labelLarge: TextStyle(color: Colors.white),
              bodySmall: TextStyle(color: Colors.white),
              labelSmall: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            useMaterial3: false,
            fontFamily: 'Lato',
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
