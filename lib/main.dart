import 'package:boooklyapp/Features/home/data/repos/home_repo_impl.dart';
import 'package:boooklyapp/Features/home/domain_layer/entities/book_entity.dart';
import 'package:boooklyapp/Features/home/domain_layer/use_cases/fetch_featured_books_use_case.dart';
import 'package:boooklyapp/Features/home/domain_layer/use_cases/fetch_newest_use_case.dart';
import 'package:boooklyapp/Features/home/presentation/manager/cubits/featured_books_cubit/featured_books_cubit.dart';
import 'package:boooklyapp/Features/home/presentation/manager/cubits/newest_books_cubit/newest_books_cubit.dart';
import 'package:boooklyapp/constants.dart';
import 'package:boooklyapp/core/utils/app_router.dart';
import 'package:boooklyapp/core/utils/functions/setup_service_locator.dart';
import 'package:boooklyapp/core/utils/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BookEntityAdapter());
  setupServiceLocator();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());

  await Hive.openBox<BookEntity>(kFeaturedBox);
  await Hive.openBox<BookEntity>(kNewestBox);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeaturedBooksCubit(
            FetchFeaturedBooksUseCase(
              getIt.get<HomeRepoImpl>(),
            ),
          )..fetchFeaturedBooks(),
        ),
        BlocProvider(
          create: (context) => NewestBooksCubit(
            FetchNewestBooksUseCase(
              getIt.get<HomeRepoImpl>(),
            ),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
          textTheme:
              GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        ),
      ),
    );
  }
}
