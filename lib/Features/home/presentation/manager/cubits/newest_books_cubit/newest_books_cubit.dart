import 'package:bloc/bloc.dart';
import 'package:boooklyapp/Features/home/domain_layer/entities/book_entity.dart';
import 'package:boooklyapp/Features/home/domain_layer/use_cases/fetch_newest_use_case.dart';
import 'package:meta/meta.dart';

part 'newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  NewestBooksCubit(this.fetchNewestUseCase) : super(NewestBooksInitial());
  final FetchNewestBooksUseCase fetchNewestUseCase;

  Future<void> fetchNewestBooks() async {
    emit(NewestBooksLoading());
    final result = await fetchNewestUseCase.call();
    result.fold((failure) {
      emit(
        NewestBooksFailure(failure.message),
      );
    }, (books) {
      emit(NewestBooksSuccess(books));
    });
  }
}
