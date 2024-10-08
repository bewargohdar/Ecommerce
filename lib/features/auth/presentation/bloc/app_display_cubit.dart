import 'package:ecomerce/features/auth/domain/usecase/get_ages.dart';
import 'package:ecomerce/features/auth/presentation/bloc/ages_display_state.dart';
import 'package:ecomerce/service_locator.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AgesDisplayCubit extends Cubit<AgesDisplayState> {
  AgesDisplayCubit() : super(AgesLoading());

  void displayAges() async {
    var returnedData = await sl<GetAgesUseCase>().call(null);

    returnedData.fold((message) {
      emit(AgesLoadFailure(message: message));
    }, (data) {
      emit(AgesLoaded(ages: data));
    });
  }
}
