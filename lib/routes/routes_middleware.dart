import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:women_safety_dashboard/routes/routes.dart';

import '../data/repositories/authentication/authentication_repositories.dart';

class TRouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route){
    return AuthenticationRepository.instance.isAuthenticated ? null : const RouteSettings(name:TRoutes.login);
  }
}