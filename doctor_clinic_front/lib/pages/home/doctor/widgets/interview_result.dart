import 'package:doctor_clinic/app/colors.dart';
import 'package:doctor_clinic/model/diagnosis.dart';
import 'package:doctor_clinic/model/medical_interview.dart';
import 'package:doctor_clinic/model/user.dart';
import 'package:flutter/material.dart';

class InterviewResult extends StatelessWidget {
  const InterviewResult({
    required User this.patient,
    required MedicalInterview? this.interview,
    required Diagnosis? this.diagnosis,
    Key? key,
  }) : super(key: key);

  final User patient;
  final MedicalInterview? interview;
  final Diagnosis? diagnosis;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: GridTileBar(
        title: Text(
          '${patient.name} ${patient.surname}',
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(
          'Age: ${interview?.age ?? '--'}',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color: AppColors.lightGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 38),
            Divider(
              color: AppColors.main,
              indent: 5,
            ),
            const SizedBox(height: 5),
            Text(
              'Interview data',
              style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 18),
            ),
            ..._buildData(context),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String title, String value) => FractionallySizedBox(
        widthFactor: 0.5,
        child: Row(
          children: [
            Expanded(child: Text(title, style: Theme.of(context).textTheme.bodyText1)),
            Expanded(
                child: Text(
              value,
              textAlign: TextAlign.end,
            )),
          ],
        ),
      );

  List<Widget> _buildData(BuildContext context) => (interview == null || interview?.pregnancy == null) ? [
    Text('Interview not performed yet', style: Theme.of(context).textTheme.bodyText1,),] : [
        const SizedBox(height: 10),
        _buildRow(context, 'Pregnancies:', interview!.pregnancy.toString()),
        _buildRow(context, 'Glucose:', interview!.glucose.toString()),
        _buildRow(context, 'Blood pressure:', interview!.bloodPressure.toString()),
        _buildRow(context, 'Skin thickness:', interview!.skinThickness.toString()),
        _buildRow(context, 'Insulin:', interview!.insulin.toString()),
        _buildRow(context, 'BMI:', interview!.bmi.toString()),
        _buildRow(context, 'Diabetes pedigree:', interview!.diabetesPedigree.toString()),
        const SizedBox(height: 10),
        Text(
          'Predicted result',
          style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 10),
        diagnosis != null ? Text('Result: ${diagnosis?.result}') : Text('Waiting for prediction...'),
      ];
}
