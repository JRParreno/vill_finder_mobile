import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/common/widgets/shimmer_loading.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/features/rental/presentation/blocs/rental/rental_bloc.dart';
import 'package:vill_finder/features/rental/presentation/pages/body/rental_body.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class RentalPage extends StatefulWidget {
  const RentalPage({super.key});

  @override
  State<RentalPage> createState() => _RentalPageState();
}

class _RentalPageState extends State<RentalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: buildAppbar(),
      body: BlocConsumer<RentalBloc, RentalState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is RentalLoading) {
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
                          const Divider(
                              height: 30, color: ColorName.borderColor),
                          ShimmerLoading(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                          const Divider(
                              height: 30, color: ColorName.borderColor),
                          ShimmerLoading(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),
                          const Divider(
                              height: 30, color: ColorName.borderColor),
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

          if (state is RentalFailure) {
            return const Expanded(
              child: Center(
                child: Text(
                  'Something went wrong in our server, please try again later.',
                ),
              ),
            );
          }

          if (state is RentalSuccess) {
            return SingleChildScrollView(
              child: RentalBody(rental: state.rental),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  PreferredSizeWidget buildAppbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight) * 0.75,
      child: BlocBuilder<RentalBloc, RentalState>(
        builder: (context, state) {
          final isLoaded = state is RentalSuccess;

          return AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 20,
                ),
              ),
            ),
            actions: isLoaded
                ? [
                    Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        state.rental.place.isFavorited
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 20,
                      ),
                    ),
                  ]
                : null,
          );
        },
      ),
    );
  }

  Widget iconWithText({
    required String title,
    required IconData iconData,
  }) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 15,
          color: ColorName.darkerGreyFont,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: ColorName.blackFont,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ].withSpaceBetween(width: 3),
    );
  }
}
