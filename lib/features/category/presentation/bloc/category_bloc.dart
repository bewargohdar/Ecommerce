import 'package:bloc/bloc.dart';
import 'package:ecomerce/features/category/domain/entity/category.dart';
import 'package:ecomerce/features/category/domain/usecase/get_categories.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategories getCategories;
  CategoryBloc(this.getCategories) : super(CategoryInitial()) {
    on<FetchCategories>(_fetchCategories);
  }

  void _fetchCategories(
      FetchCategories event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    final result = await getCategories();

    result.fold(
      (error) => emit(CategoryError(error)),
      (categories) => emit(CategoryLoaded(categories)),
    );
  }
}
