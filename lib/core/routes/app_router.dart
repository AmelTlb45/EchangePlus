
import 'package:echange_plus/Featrures/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:echange_plus/Featrures/splash/presentation/views/splash_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(path:"/",
  builder: (context, state) => SplashView(),
  ),
  GoRoute(path:"/OnBoarding",
  builder: (context, state) => OnBoardingView(),
  ),
    
  
]);