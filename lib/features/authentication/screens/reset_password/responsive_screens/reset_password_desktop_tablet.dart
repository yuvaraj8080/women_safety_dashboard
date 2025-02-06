import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/layouts/templates/login_template.drt.dart';
import '../widgets/reset_password_widget.dart';

class ResetPasswordScreenDesktopTablet extends StatelessWidget {
  const ResetPasswordScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return  const TLoginTemplate(child:ResetPasswordWidget());
  }
}

