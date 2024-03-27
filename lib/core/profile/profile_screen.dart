import 'package:flutter/material.dart';
import 'package:movie_app/constant/color_constant.dart';
import 'package:movie_app/core/shared_widgets/custom_card.dart';
import 'package:movie_app/router/route_path.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: Column(
              children: [
                Text('Username'),
                SizedBox(height: 20),
                CustomCard(
                  color: Colors.grey.shade700,
                  onTap: () {
                    Navigator.pushNamed(context, RoutePath.favoriteScreen);
                  },
                  child: ListTile(
                    title: Text('Favorite'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
