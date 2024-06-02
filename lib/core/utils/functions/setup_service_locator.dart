import 'package:boooklyapp/Features/home/data/data_source/home_local_data_source.dart';
import 'package:boooklyapp/Features/home/data/data_source/home_remote_data_source.dart';
import 'package:boooklyapp/Features/home/data/repos/home_repo_impl.dart';
import 'package:boooklyapp/core/utils/api_services.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiServices>(ApiServices(Dio()));
  getIt.registerSingleton(
    HomeRepoImpl(
      homeLocalDataSource: HomeLocalDataSourceImpl(),
      homeRemoteDataSource: HomeRemoteDataSourceImpl(
        getIt.get<ApiServices>(),
      ),
    ),
  );
}
