import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vill_finder/gen/assets.gen.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class HeaderInfo extends StatelessWidget {
  const HeaderInfo({
    super.key,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
  });

  final String title;
  final String subTitle;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
              opacity: 0.25,
              child: CachedNetworkImage(
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Assets.images.placeholder.imagePlaceholder.image(),
              )),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  color: ColorName.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                subTitle,
                style: textTheme.labelSmall?.copyWith(
                  color: ColorName.primary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
