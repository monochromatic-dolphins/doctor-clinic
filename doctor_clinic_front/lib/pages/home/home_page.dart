import 'package:doctor_clinic/app/colors.dart';
import 'package:doctor_clinic/app/custom_app_bar.dart';
import 'package:doctor_clinic/model/state/app_state.dart';
import 'package:doctor_clinic/model/user.dart';
import 'package:doctor_clinic/pages/home/doctor/doctor_page.dart';
import 'package:doctor_clinic/pages/home/patient/patient_page.dart';
import 'package:doctor_clinic/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    runPostFrame(() => {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar.build(context),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(40),
            child: Consumer<AppState>(
              builder: (context, state, _) {
                return state.isFetching
                  ? Center(
                      child: CircularProgressIndicator(color: AppColors.main),
                    )
                  : _buildContentForState(state);
              },
            ),
          ),
        ),
      );

  Widget _buildContentForState(AppState state) => state.userState.user?.role == Role.doctor ? DoctorPage() : PatientPage();
}
