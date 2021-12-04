import 'package:doctor_clinic/app/colors.dart';
import 'package:doctor_clinic/app/routes.dart';
import 'package:doctor_clinic/model/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class CustomAppBar {
  static AppBar build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: InkWell(
        child: Text(
          'Doctor Clinic',
          style: Theme.of(context).textTheme.headline1?.copyWith(color: Colors.white, fontSize: 28),
        ),
        onTap: () => context.vRouter.to(Routes.main),
      ),
      // leading: Icon(Icons.movie),
      backgroundColor: AppColors.main,
      actions: [
        const SizedBox(width: 20),
        TextButton(
          onPressed: () {
            Provider.of<AppState>(context, listen: false).userState.logOut();
            context.vRouter.to(Routes.login);
          },
          style: TextButton.styleFrom(primary: AppColors.lightGreen),
          child: Text('Sign out'),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
