// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/router/index.dart';
import 'package:vill_finder/features/navigation/presentation/cubit/navigator_index_cubit.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class ScaffoldWithBottomNav extends StatefulWidget {
  const ScaffoldWithBottomNav({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ScaffoldWithBottomNav> createState() => _ScaffoldWithBottomNavState();
}

class _ScaffoldWithBottomNavState extends State<ScaffoldWithBottomNav> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigatorIndexCubit, NavigatorIndexState>(
      listener: (context, state) {
        handleonItemTapped(state.currentIndex);
        context.read<NavigatorIndexCubit>().onChangeIndex(selectedIndex);
      },
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            buttonBackgroundColor: ColorName.primary,
            index: selectedIndex,
            color: ColorName.primary,
            items: List.generate(
              state.indexes.length,
              (i) => buildIcon(
                i: i,
                icon: state.indexes[i],
                selectedItemIndex: selectedIndex,
              ),
            ),
            onTap: (value) {
              context.read<NavigatorIndexCubit>().onChangeIndex(value);
              handleonItemTapped(value);
            },
          ),
          body: widget.child,
        );
      },
    );
  }

  Widget buildIcon({
    required int i,
    required IconData icon,
    required int selectedItemIndex,
  }) {
    return Icon(
      icon,
      size: 30,
      color: Colors.white.withOpacity(selectedItemIndex == i ? 1 : 0.65),
    );
  }

  void handleonItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    switch (index) {
      case 0:
        context.go(AppRoutes.home.path);
        break;
      case 1:
        context.go(AppRoutes.favorite.path);
        break;
      case 2:
        context.go(AppRoutes.map.path);
        break;
      case 3:
        context.go(AppRoutes.profile.path);
        break;
      default:
    }
  }
}
