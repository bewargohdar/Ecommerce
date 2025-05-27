import 'package:bloc/bloc.dart';
import 'package:ecomerce/features/auth/domain/usecase/get_users.dart';
import 'package:ecomerce/features/category/domain/entity/category.dart';
import 'package:ecomerce/features/category/domain/usecase/get_categories.dart';
import 'package:meta/meta.dart';

import '../../../../service_locator.dart';
import '../../../auth/domain/entity/user_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsers getUsers = sl<GetUsers>();
  final GetCategories getCategories = sl<GetCategories>();

  HomeBloc() : super(HomeDataLoaded()) {
    on<FetchUserInfo>(_fetchUserInfo);
    on<FetchCategories>(_fetchCategories);
  }

  Future<void> _fetchUserInfo(
      FetchUserInfo event, Emitter<HomeState> emit) async {
    // Get current state
    final currentState = state;
    if (currentState is HomeDataLoaded) {
      emit(currentState.copyWith(isLoadingUser: true, clearUserError: true));
    } else {
      emit(HomeDataLoaded(isLoadingUser: true));
    }

    var returnedData = await getUsers.call();
    final newCurrentState = state;

    returnedData.fold((error) {
      if (newCurrentState is HomeDataLoaded) {
        emit(newCurrentState.copyWith(
          isLoadingUser: false,
          userError: error.toString(),
        ));
      }
    }, (data) {
      if (newCurrentState is HomeDataLoaded) {
        emit(newCurrentState.copyWith(
          user: data,
          isLoadingUser: false,
          clearUserError: true,
        ));
      }
    });
  }

  Future<void> _fetchCategories(
      FetchCategories event, Emitter<HomeState> emit) async {
    // Get current state
    final currentState = state;
    if (currentState is HomeDataLoaded) {
      emit(currentState.copyWith(
          isLoadingCategories: true, clearCategoriesError: true));
    } else {
      emit(HomeDataLoaded(isLoadingCategories: true));
    }

    var returnedData = await getCategories.call();
    final newCurrentState = state;

    returnedData.fold((error) {
      if (newCurrentState is HomeDataLoaded) {
        emit(newCurrentState.copyWith(
          isLoadingCategories: false,
          categoriesError: error.toString(),
        ));
      }
    }, (data) {
      if (newCurrentState is HomeDataLoaded) {
        emit(newCurrentState.copyWith(
          categories: data,
          isLoadingCategories: false,
          clearCategoriesError: true,
        ));
      }
    });
  }
}
