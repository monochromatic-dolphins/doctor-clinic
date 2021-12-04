import 'package:doctor_clinic/app/routes.dart';
import 'package:doctor_clinic/app/theme.dart';
import 'package:doctor_clinic/model/state/app_state.dart';
import 'package:doctor_clinic/model/user.dart';
import 'package:doctor_clinic/pages/auth/auth_page.dart';
import 'package:doctor_clinic/pages/home/doctor/doctor_page.dart';
import 'package:doctor_clinic/pages/home/home_page.dart';
import 'package:doctor_clinic/pages/home/patient/patient_page.dart';
import 'package:doctor_clinic/pages/interview/interview_page.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _store = AppState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _store,
      child: Consumer<AppState>(
        builder: (context, state, _) => VRouter(
          title: 'Doctor Clinic',
          theme: AppTheme.mainTheme(context),
          initialUrl: Routes.main,
          routes: [
            VWidget(path: Routes.login, widget: AuthPage()),
            VGuard(
              beforeEnter: (vRedirector) async => _checkIfLoggedIn(vRedirector, state.userState.isLoggedIn, state),
              stackedRoutes: [
                VGuard(
                    beforeEnter: (vRedirector) async => state.userState.user?.role == Role.doctor
                        ? vRedirector.to(Routes.doctor)
                        : vRedirector.to(Routes.patient),
                    stackedRoutes: [
                      VWidget(path: Routes.main, widget: HomePage()),
                    ]),
                VWidget(path: Routes.doctor, widget: DoctorPage()),
                VWidget(path: Routes.patient, widget: PatientPage()),
                VGuard(
                    beforeEnter: (vRedirector) async =>
                    state.userState.user?.role != Role.doctor ? vRedirector.to(Routes.main) : null,
                    stackedRoutes: [
                      VWidget(path: Routes.interview, widget: InterviewPage()),
                    ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _checkIfLoggedIn(VRedirector vRedirector, bool isLoggedIn, AppState state) async {
  if (!isLoggedIn) vRedirector.to(Routes.login);
}
