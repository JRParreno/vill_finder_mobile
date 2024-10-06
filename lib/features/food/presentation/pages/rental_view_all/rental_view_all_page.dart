import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/features/rental/presentation/blocs/rental_list_bloc/rental_list_bloc.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class RentalViewAllPage extends StatefulWidget {
  const RentalViewAllPage({super.key});

  @override
  State<RentalViewAllPage> createState() => _RentalViewAllPageState();
}

class _RentalViewAllPageState extends State<RentalViewAllPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rental(s))',
          style: textTheme.titleLarge?.copyWith(
            fontSize: 24,
            color: ColorName.blackFont,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<RentalListBloc, RentalListState>(
        builder: (context, state) {
          return const Placeholder();
        },
      ),
    );
  }
}
