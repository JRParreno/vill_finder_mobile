import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/common/widgets/custom_elevated_btn.dart';
import 'package:vill_finder/core/common/widgets/custom_text_form_field.dart';
import 'package:vill_finder/core/enum/review_type.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/rental/presentation/blocs/rental/rental_bloc.dart';
import 'package:vill_finder/features/review/domain/usecases/index.dart';
import 'package:vill_finder/features/review/presentation/bloc/cubit/review_star_cubit.dart';
import 'package:vill_finder/gen/colors.gen.dart';

Future<void> addFeedbackBottomSheetDialog({
  required BuildContext context,
  required int id,
  required PlaceEntity place,
  required ReviewType reviewType,
  required TextEditingController controller,
  VoidCallback? onClose,
}) {
  final textTheme = Theme.of(context).textTheme;

  return showModalBottomSheet<String>(
    context: context,
    isDismissible: true,
    useSafeArea: true,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return BlocBuilder<ReviewStarCubit, double>(
        builder: (context, state) {
          return FractionallySizedBox(
            heightFactor: 0.8,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    'Feedback for ${place.name}',
                    style: textTheme.bodyMedium
                        ?.copyWith(color: ColorName.blackFont),
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    keyboardType: TextInputType.multiline,
                    hintText: 'Write your feedback',
                    controller: controller,
                    minLines: 5,
                    maxLines: 6,
                    maxLength: 500,
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: RatingStars(
                      value: state,
                      onValueChanged: (v) {
                        context.read<ReviewStarCubit>().onChangeStars(v);
                      },
                      starBuilder: (index, color) => Icon(
                        Icons.star,
                        color: color,
                        size: 38,
                      ),
                      starCount: 5,
                      starSize: 38,
                      maxValue: 5,
                      starSpacing: 10,
                      maxValueVisibility: false,
                      valueLabelVisibility: false,
                      starOffColor: ColorName.darkerGreyFont,
                      starColor: Colors.yellow,
                    ),
                  ),
                  const SizedBox(height: 25),
                  CustomElevatedBtn(
                    onTap: state > 0 ? () => context.pop('submit') : null,
                    title: 'Submit Feedback',
                  ),
                ].withSpaceBetween(height: 15),
              ),
            ),
          );
        },
      );
    },
  ).then(
    (value) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (value == 'submit') {
          final rate = context.read<ReviewStarCubit>().state;
          final params = AddReviewParams(
              objectId: id,
              reviewType: reviewType,
              stars: rate.toInt(),
              comments: controller.value.text);
          if (reviewType == ReviewType.rental) {
            context.read<RentalBloc>().add(SubmitAddReviewEvent(params));
          }
          return;
        }
      });
    },
  );
}