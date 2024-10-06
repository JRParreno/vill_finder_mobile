import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_food/home_food_bloc.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_rental/home_rental_bloc.dart';
import 'package:vill_finder/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Vill Finder',
            style: textTheme.titleLarge?.copyWith(
              fontSize: 24,
              color: ColorName.blackFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<HomeFoodBloc>().add(const GetHomeFoodEvent());
              context
                  .read<HomeRentalListBloc>()
                  .add(const GetHomeRentalEvent());
            },
            icon: const Icon(
              Icons.notifications_outlined,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
