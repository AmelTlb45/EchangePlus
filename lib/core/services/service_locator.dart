import 'package:echange_plus/Featrures/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:echange_plus/core/database/cache/cache_helper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  //getIt.registerSingleton<CacheHelper>(CacheHelper());
getIt.registerSingleton<CacheHelper>(CacheHelper.instance);
getIt.registerSingleton<AuthCubit>(AuthCubit());

}