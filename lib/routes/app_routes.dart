import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:women_safety_dashboard/features/Live_tracking/Google_Map/live_tracking_screen.dart';
import 'package:women_safety_dashboard/features/Live_tracking/Google_Map/screens/GoogleMap_View.dart';
import 'package:women_safety_dashboard/routes/routes.dart';
import '../features/authentication/screens/forget_password/forget_password.dart';
import '../features/authentication/screens/login/login.dart';
import '../features/authentication/screens/reset_password/reset_password.dart';
import '../features/dashboard/dashboard.dart';
import '../features/personalization/screens/profile/profile.dart';
import 'routes_middleware.dart';


class TAppRoute{
  static final List<GetPage> pages = [
    /// LOGIN PAGES HARE
    GetPage(name:TRoutes.login, page:()=> const LoginScreen()),
    GetPage(name:TRoutes.forgetPassword, page:()=>const ForgetPasswordScreen()),
    GetPage(name:TRoutes.resetPassword, page:()=> const ResetPasswordScreen()),

    /// DASHBOARD AND MEDIA PAGES HARE
    GetPage(name:TRoutes.dashboard, page:()=> const DashboardScreen(),middlewares:[TRouteMiddleware()]),

    /// SETTINGS & PROFILES HARE
    GetPage(name: TRoutes.profile, page:()=>const ProfileScreen(),middlewares:[TRouteMiddleware()]),
    // Live Tracking Page
     GetPage(name: TRoutes.liveTracking, page:()=>LiveTrackingScreen(),middlewares:[TRouteMiddleware()]),
  ];

}