import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/login_template.drt.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';


class LoginScreenDesktopTablet extends StatelessWidget {
  const LoginScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const  TLoginTemplate(
      child: Column(
          children:[

            /// HEADER AREA THE HARE
            TLoginHeader(),

            /// FORM FOR THE LOGIN SECTION
            TLoginForm(),
          ]
      )
    );
  }
}



