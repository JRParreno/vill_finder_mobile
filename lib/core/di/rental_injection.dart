// coverage:ignore-file
import 'package:get_it/get_it.dart';
import 'package:vill_finder/features/rental/presentation/blocs/rental_list_bloc/rental_list_bloc.dart';

void rentalInit(GetIt serviceLocator) {
  serviceLocator.registerFactory(
    () => RentalListBloc(
      serviceLocator(),
    ),
  );
}
