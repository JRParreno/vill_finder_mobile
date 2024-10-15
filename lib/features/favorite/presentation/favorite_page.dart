import 'package:flutter/material.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/gen/assets.gen.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Favorites',
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(),
            Text(
              'Sorry, this feature',
              style: textTheme.labelLarge,
            ),
            Text(
              'is unavailable right now 😄',
              style: textTheme.labelLarge,
            ),
            Assets.lottie.profileUnlock.lottie(),
          ].withSpaceBetween(height: 10),
        ),
      ),
    );
  }
}
