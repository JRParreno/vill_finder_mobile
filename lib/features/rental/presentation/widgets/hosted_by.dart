import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vill_finder/core/utils/utils_url_laucher.dart';

import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class HostedBy extends StatelessWidget {
  const HostedBy({
    super.key,
    required this.host,
  });

  final BusinessUserProfileEntity host;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (host.profilePhoto != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  height: 30,
                  width: 30,
                  imageUrl: host.profilePhoto!,
                ),
              )
            ] else ...[
              const Icon(
                Icons.account_circle,
                size: 30,
              )
            ],
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hosted by ${host.user.getFullName}',
                  style: textTheme.bodySmall,
                ),
                Text(
                  'Superhost',
                  style: textTheme.bodySmall
                      ?.copyWith(color: ColorName.darkerGreyFont),
                )
              ],
            )
          ],
        ),
        if (host.contactNumber != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
                onPressed: () =>
                    UtilsUrlLaucher.makePhoneCall(host.contactNumber!),
                icon: const Icon(
                  Icons.phone,
                  size: 30,
                )),
          )
      ],
    );
  }
}
