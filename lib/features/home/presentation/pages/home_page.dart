import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/core/router/index.dart';
import 'package:vill_finder/features/home/presentation/blocs/cubit/carousel_dots_cubit.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_food/home_food_bloc.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_rental/home_rental_bloc.dart';
import 'package:vill_finder/features/home/presentation/pages/body/index.dart';
import 'package:vill_finder/features/home/presentation/widgets/search_field.dart';
import 'package:vill_finder/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchCtrl = TextEditingController();
  final taskCategoryScroll = ScrollController();
  final businessScroll = ScrollController();

  @override
  void initState() {
    super.initState();
    handleGetInitialTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.placeholder,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeHeader(),
                  SearchField(
                    onTap: () {
                      context.pushNamed(AppRoutes.homeSearch.name);
                    },
                    onChanged: () {
                      setState(() {});
                    },
                    onClearText: () {
                      searchCtrl.clear();
                      setState(() {});
                    },
                    controller: searchCtrl,
                    hintText: 'Search',
                    prefixIcon: const Icon(
                      Icons.search_outlined,
                      color: ColorName.darkerGreyFont,
                    ),
                    readOnly: true,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: ListView(
                  children: [
                    BlocProvider(
                      create: (context) => DotsCubit(),
                      child: const HomeFoodBody(),
                    ),
                    const HomeRentalBody()
                  ],
                ),
              ),
            )
          ].withSpaceBetween(height: 15),
        ),
      ),
    );
  }

  void handleGetInitialTask() {
    context.read<HomeFoodListBloc>().add(const GetHomeFoodListEvent());
    context.read<HomeRentalListBloc>().add(const GetHomeRentalEvent());
  }
}
