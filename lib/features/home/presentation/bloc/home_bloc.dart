import 'package:bloc/bloc.dart';
import 'package:ecomerce/features/auth/domain/usecase/get_users.dart';
import 'package:meta/meta.dart';

import '../../../../service_locator.dart';
import '../../../auth/domain/entity/user_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      var returnData = await sl<GetUsers>().call(null);
      returnData.fold((error) {
        emit(HomeError(error.toString()));
      }, (data) {
        emit(HomeLoaded(data));
      });
    });
  }
}
