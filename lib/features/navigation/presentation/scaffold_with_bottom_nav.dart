// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/router/index.dart';

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
  int selectedItemIndex = 0;

  final icons = [
    Icons.home,
    CupertinoIcons.heart_fill,
    Icons.map,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: List.generate(
          icons.length,
          (i) => buildIcon(i),
        ),
        onTap: (value) {
          handleonItemTapped(value);
        },
      ),
      body: widget.child,
    );
  }

  Widget buildIcon(int i) {
    return Icon(
      icons[i],
      size: 30,
      color: Colors.black.withOpacity(selectedItemIndex == i ? 1 : 0.65),
    );
  }

  void handleonItemTapped(int index) {
    setState(() => selectedItemIndex = index);

    switch (index) {
      case 0:
        context.go(AppRoutes.home.path);
        break;
      case 1:
        context.go(AppRoutes.map.path);
        break;
      case 2:
        context.go(AppRoutes.favorite.path);
        break;
      case 3:
        context.go(AppRoutes.profile.path);
        break;
      default:
    }
  }
}
