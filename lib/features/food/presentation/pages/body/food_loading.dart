import 'package:flutter/material.dart';
import 'package:vill_finder/core/common/widgets/shimmer_loading.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class FoodLoadingWidget extends StatelessWidget {
  const FoodLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ShimmerLoading(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.45,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Divider(height: 30, color: ColorName.borderColor),
                  ShimmerLoading(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  const Divider(height: 30, color: ColorName.borderColor),
                  ShimmerLoading(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  const Divider(height: 30, color: ColorName.borderColor),
                  ShimmerLoading(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
