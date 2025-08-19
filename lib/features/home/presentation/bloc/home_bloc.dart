import 'package:bloc/bloc.dart';
import 'package:ecomerce/core/resource/data_state.dart';
import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/auth/domain/entity/user_entity.dart';
import 'package:ecomerce/features/auth/domain/usecase/get_users.dart';
import 'package:ecomerce/features/category/domain/entity/category.dart';
import 'package:ecomerce/features/category/domain/usecase/get_categories.dart';
import 'package:ecomerce/features/home/domain/entity/home.dart';
import 'package:ecomerce/features/home/domain/usecase/get_home_data.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsers getUsers;
  final GetCategories getCategories;
  final GetHomeData getHomeData;

  HomeBloc({
    required this.getUsers,
    required this.getCategories,
    required this.getHomeData,
  }) : super(const HomeState()) {
    on<FetchUserInfo>(_fetchUserInfo);
    on<FetchCategories>(_fetchCategories);
    on<FetchHomeData>(_fetchHomeData);
  }

  Future<void> _fetchUserInfo(
      FetchUserInfo event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    var returnedData = await getUsers.call(NoParams());
    if (returnedData is DataSuccess) {
      emit(state.copyWith(isLoading: false, user: returnedData.data));
    } else if (returnedData is DataError) {
      emit(state.copyWith(
          isLoading: false, error: returnedData.error?.toString()));
    }
  }

  Future<void> _fetchHomeData(
      FetchHomeData event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    var result = await getHomeData.call(NoParams());
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.toString())),
      (homeEntity) =>
          emit(state.copyWith(isLoading: false, homeEntity: homeEntity)),
    );
  }

  Future<void> _fetchCategories(
      FetchCategories event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    var returnedData = await getCategories.call(NoParams());
    returnedData.fold(
      (error) =>
          emit(state.copyWith(isLoading: false, error: error.toString())),
      (data) => emit(state.copyWith(isLoading: false, categories: data)),
    );
  }
}
