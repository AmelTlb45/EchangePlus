import 'package:echange_plus/core/database/cache/cache_helper.dart';
import 'package:echange_plus/core/services/service_locator.dart';

void OnBoardingVisited()
{
  CacheHelper.saveData(key:"isOnBoardingVisited",value:true);
}