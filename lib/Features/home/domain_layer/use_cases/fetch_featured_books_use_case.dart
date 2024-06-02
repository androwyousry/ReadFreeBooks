import 'package:boooklyapp/Features/home/domain_layer/entities/book_entity.dart';
import 'package:boooklyapp/core/errors/failure.dart';
import 'package:boooklyapp/core/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

import '../repos/home_repo.dart';

class FetchFeaturedBooksUseCase extends UseCase<List<BookEntity>, int> {
  final HomeRepo homeRepo;

  FetchFeaturedBooksUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<BookEntity>>> call([param = 0]) async {
    return await homeRepo.fetchFeaturedBooks(
      pageNumber: param,
    );
  }
}
