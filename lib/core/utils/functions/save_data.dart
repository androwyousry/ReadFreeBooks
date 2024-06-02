import 'package:boooklyapp/Features/home/domain_layer/entities/book_entity.dart';
import 'package:boooklyapp/constants.dart';
import 'package:hive_flutter/adapters.dart';

void saveBooksData(List<BookEntity> books, String boxName) {
  var box = Hive.box<BookEntity>(kFeaturedBox);
  box.addAll(books);
}
