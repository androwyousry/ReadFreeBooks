import 'package:boooklyapp/Features/home/domain_layer/entities/book_entity.dart';
import 'package:boooklyapp/Features/home/domain_layer/repos/home_repo.dart';
import 'package:boooklyapp/core/errors/failure.dart';
import 'package:boooklyapp/core/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

class FetchNewestBooksUseCase extends UseCase<List<BookEntity>, NoParam> {
  final HomeRepo homeRepo;

  FetchNewestBooksUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<BookEntity>>> call([NoParam? params]) async {
    return await homeRepo.fetchNewestBooks();
  }
}
