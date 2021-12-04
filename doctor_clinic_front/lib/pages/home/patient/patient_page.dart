import 'package:doctor_clinic/app/colors.dart';
import 'package:doctor_clinic/app/custom_app_bar.dart';
import 'package:doctor_clinic/model/state/app_state.dart';
import 'package:doctor_clinic/pages/home/doctor/widgets/interview_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({Key? key}) : super(key: key);

  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
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
                    : _buildContentForState(context, state);
              },
            ),
          ),
        ),
      );

  Widget _buildContentForState(BuildContext context, AppState state) => GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 30,
          crossAxisSpacing: 30,
          children: [
            InterviewResult(
              patient: state.userState.user!,
              interview: state.userState.user!.medicalInterview,
              diagnosis: state.diagnosisState.diagnosis,
            )
          ],
      );
}
