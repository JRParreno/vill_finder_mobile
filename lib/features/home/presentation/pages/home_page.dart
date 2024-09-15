import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_business/home_business_bloc.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_business_category/home_business_category_bloc.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              SearchField(
                onChanged: () {
                  setState(() {});
                },
                onClearText: () {
                  searchCtrl.clear();
                  setState(() {});
                  handleOnSubmitSearch();
                },
                controller: searchCtrl,
                hintText: 'Search',
                prefixIcon: const Icon(
                  Icons.search_outlined,
                  color: ColorName.darkerGreyFont,
                ),
                onSubmit: () => handleOnSubmitSearch(searchCtrl.value.text),
              ),
              BusinessCategoryList(searchCtrl: searchCtrl),
              BusinessList(controller: businessScroll),
            ].withSpaceBetween(height: 15),
          ),
        ),
      ),
    );
  }

  void handleGetInitialTask() {
    context
        .read<HomeBusinessCategoryBloc>()
        .add(GetHomeBusinessCategoryEvent());
  }

  void handleOnSubmitSearch([String keyword = '']) {
    Future.delayed(const Duration(milliseconds: 150), () {
      FocusScope.of(context).unfocus();
    });

    final businessCategoryState =
        context.read<HomeBusinessCategoryBloc>().state;

    if (businessCategoryState is HomeBusinessCategorySuccess) {
      context.read<HomeBusinessBloc>().add(
            GetHomeBusinessEvent(
              categoryId: businessCategoryState
                  .data.results[businessCategoryState.selected].id,
              search: keyword,
            ),
          );
    }
  }
}
