import 'package:doctor_clinic/app/colors.dart';
import 'package:doctor_clinic/app/custom_app_bar.dart';
import 'package:doctor_clinic/app/routes.dart';
import 'package:doctor_clinic/model/state/app_state.dart';
import 'package:doctor_clinic/utils/helpers.dart';
import 'widgets/interview_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initing');
    Provider.of<AppState>(context,listen: false).medicalInterviewState.fetchMedicalInterviews();
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
                : _buildContentForState(context, state);
          },
        ),
      ),
    ),
  );

  Widget _buildContentForState(BuildContext context, AppState state) => Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: ElevatedButton(
              onPressed: () => context.vRouter.to(Routes.interview),
              child: Text('Add interview'),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
              children: state.medicalInterviewState.medicalInterviews
                  .map((medicalInterview) => InterviewResult(
                        patient: medicalInterview!.patient!,
                        interview: medicalInterview,
                        diagnosis: state.diagnosisState.diagnosis,
                      ))
                  .toList(),
            ),
          ),
        ],
    );
}
