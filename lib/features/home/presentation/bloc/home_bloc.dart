import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ecomerce/features/auth/data/models/user.dart';
import 'package:ecomerce/features/auth/domain/usecase/get_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../service_locator.dart';
import '../../../auth/domain/entity/user_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsers getUsers = sl<GetUsers>();

  HomeBloc() : super(HomeInitial()) {
    on<FetchUserInfo>(_fetchUserInfo);
  }

  Future<void> _fetchUserInfo(
      FetchUserInfo event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    var returnedData = await getUsers.call();
    returnedData.fold((error) {
      emit(HomeError(error.toString()));
    }, (data) {
      emit(HomeLoaded(data));
    });
  }
}
