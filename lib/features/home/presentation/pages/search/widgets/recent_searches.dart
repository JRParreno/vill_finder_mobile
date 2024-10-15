import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/features/map/domain/usecase/get_business_map_list.dart';
import 'package:vill_finder/features/map/presentation/blocs/map_business/map_business_bloc.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class RecentSearches extends StatelessWidget {
  const RecentSearches({
    super.key,
    required this.keywords,
    required this.onClearRecent,
    required this.onTapKeyword,
  });

  final List<String> keywords;
  final VoidCallback onClearRecent;
  final Function(String value) onTapKeyword;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (keywords.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            'No Recent Searches',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Searches',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: onClearRecent,
              child: Text(
                'Clear All',
                style: textTheme.titleMedium?.copyWith(
                  color: ColorName.darkerGreyFont,
                ),
              ),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: keywords.length,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () {
                onTapKeyword(keywords[index]);
                context.read<MapBusinessBloc>().add(GetMapBusinessEvent(
                      GetBusinessMapListParams(
                        name: keywords[index],
                      ),
                    ));
              },
              child: Text(
                keywords[index],
                style: textTheme.titleMedium,
              ),
            ),
          ),
        )
      ],
    );
  }
}
