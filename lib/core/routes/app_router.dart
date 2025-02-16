
import 'package:echange_plus/Featrures/auth/presentation/views/sign_In_view.dart';
import 'package:echange_plus/Featrures/auth/presentation/views/sign_up_view.dart';
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
   GoRoute(path:"/signUp",
  builder: (context, state) => SignUpView(),
  ),
   GoRoute(path:"/signIn",
  builder: (context, state) => SignIpView(),
  ),
]);