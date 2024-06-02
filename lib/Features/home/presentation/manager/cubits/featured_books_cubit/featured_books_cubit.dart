import 'package:bloc/bloc.dart';
import 'package:boooklyapp/Features/home/domain_layer/entities/book_entity.dart';
import 'package:boooklyapp/Features/home/domain_layer/use_cases/fetch_featured_books_use_case.dart';
import 'package:meta/meta.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.fetchFeaturedBooksUseCase)
      : super(FeaturedBooksInitial());
  final FetchFeaturedBooksUseCase fetchFeaturedBooksUseCase;

  Future<void> fetchFeaturedBooks({int pageNumber = 0}) async {
    if (pageNumber == 0) {
      emit(FeaturedBooksLoading());
    } else {
      emit(FeaturedBooksPaginationLoading());
    }
    var result = await fetchFeaturedBooksUseCase.call(
      pageNumber,
    );
    result.fold((failure) {
      if (pageNumber == 0) {
        emit(
          FeaturedBooksFailure(failure.message),
        );
      } else {
        emit(
          FeaturedBooksPaginationFailure(failure.message),
        );
      }
    }, (books) {
      emit(
        FeaturedBooksSuccess(books),
      );
    });

    // Either<Failure, List<BookEntity>> result =
    //     await fetchNewestUseCase.call();
    // result.fold(
    //   (failure) => emit(FeaturedBooksFailure()),
    //   (books) => emit(FeaturedBooksSuccess(books)),
    // );
  }
}
