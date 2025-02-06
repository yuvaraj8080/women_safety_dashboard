import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:women_safety_dashboard/routes/routes.dart';
import '../features/authentication/screens/forget_password/forget_password.dart';
import '../features/authentication/screens/login/login.dart';
import '../features/authentication/screens/reset_password/reset_password.dart';
import '../features/personalization/screens/profile/profile.dart';
import '../features/personalization/screens/settings/settings.dart';
import 'routes_middleware.dart';


class TAppRoute{
  static final List<GetPage> pages = [
    /// LOGIN PAGES HARE
    GetPage(name:TRoutes.login, page:()=> const LoginScreen()),
    GetPage(name:TRoutes.forgetPassword, page:()=>const ForgetPasswordScreen()),
    GetPage(name:TRoutes.resetPassword, page:()=> const ResetPasswordScreen()),

    /// SETTINGS & PROFILES HARE
    GetPage(name: TRoutes.settings, page:()=>const SettingsScreen(),middlewares:[TRouteMiddleware()]),
    GetPage(name: TRoutes.profile, page:()=>const ProfileScreen(),middlewares:[TRouteMiddleware()]),
  ];

}