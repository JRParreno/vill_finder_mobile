// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:vill_finder/core/utils/utils_url_laucher.dart';

import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class FoodHosted extends StatelessWidget {
  const FoodHosted({
    super.key,
    required this.host,
    this.contactNumber,
    this.contactName,
  });

  final BusinessUserProfileEntity host;
  final String? contactNumber;
  final String? contactName;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contactName ?? "",
                  style: textTheme.bodySmall,
                ),
                Text(
                  'Establishment',
                  style: textTheme.bodySmall
                      ?.copyWith(color: ColorName.darkerGreyFont),
                )
              ],
            )
          ],
        ),
        if (contactNumber != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
                onPressed: () => UtilsUrlLaucher.makePhoneCall(contactNumber!),
                icon: const Icon(
                  Icons.phone,
                  size: 30,
                )),
          )
      ],
    );
  }
}
