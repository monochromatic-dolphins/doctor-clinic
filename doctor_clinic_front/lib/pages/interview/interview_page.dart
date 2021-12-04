import 'package:doctor_clinic/app/colors.dart';
import 'package:doctor_clinic/app/custom_app_bar.dart';
import 'package:doctor_clinic/app/routes.dart';
import 'package:doctor_clinic/model/medical_interview.dart';
import 'package:doctor_clinic/model/state/app_state.dart';
import 'package:doctor_clinic/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class InterviewPage extends StatefulWidget {
  const InterviewPage({Key? key}) : super(key: key);

  @override
  _InterviewPageState createState() => _InterviewPageState();
}

class _InterviewPageState extends State<InterviewPage> {
  int? _selectedPatient;

  @override
  void initState() {
    super.initState();
    runPostFrame(() async {
      await Provider.of<AppState>(context, listen: false).userState.fetchPatients();
      _selectedPatient = Provider.of<AppState>(context, listen: false).userState.patients.first.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _ageController = TextEditingController();
    final _pregnanciesController = TextEditingController();
    final _glucoseController = TextEditingController();
    final _bloodPressureController = TextEditingController();
    final _skinThicknessController = TextEditingController();
    final _insulinController = TextEditingController();
    final _bmiController = TextEditingController();
    final _diabetesPedigreeController = TextEditingController();

    return Scaffold(
      appBar: CustomAppBar.build(context),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          margin: EdgeInsets.symmetric(vertical: 30.0),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: AppColors.lightGreen,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
            key: _formKey,
            child: Consumer<AppState>(
              builder: (context, state, _) => Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton(
                    value: _selectedPatient,
                    onChanged: (int? value) => setState(() {
                      _selectedPatient = value;
                    }),
                    items: state.userState.patients
                        .map((patient) => DropdownMenuItem(
                              value: patient.id,
                              child: Text(
                                '${patient.surname}, ${patient.name}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ))
                        .toList(),
                  ),
                  Divider(
                    color: AppColors.main,
                    indent: 5,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Interview data',
                    style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  _buildRow(context, 'Age:', _ageController),
                  _buildRow(context, 'Pregnancies:', _pregnanciesController),
                  _buildRow(context, 'Glucose:', _glucoseController),
                  _buildRow(context, 'Blood pressure:', _bloodPressureController),
                  _buildRow(context, 'Skin thickness:', _skinThicknessController),
                  _buildRow(context, 'Insulin:', _insulinController),
                  _buildRow(context, 'BMI:', _bmiController,
                      inputType: FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))),
                  _buildRow(context, 'Diabetes pedigree:', _diabetesPedigreeController,
                      inputType: FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () async {
                        await Provider.of<AppState>(context, listen: false)
                            .medicalInterviewState
                            .analyzeMedicalInterview(MedicalInterview(
                              age: int.parse(_ageController.text),
                              pregnancy: int.parse(_pregnanciesController.text),
                              glucose: int.parse(_glucoseController.text),
                              bloodPressure: int.parse(_bloodPressureController.text),
                              skinThickness: int.parse(_skinThicknessController.text),
                              insulin: int.parse(_insulinController.text),
                              bmi: double.parse(_bmiController.text),
                              diabetesPedigree: double.parse(_diabetesPedigreeController.text),
                              doctor: state.userState.user,
                              patient: state.userState.patients.firstWhere((element) => element.id == _selectedPatient),
                            ));
                        context.vRouter.to(Routes.main);
                      },
                      child: Text('Save')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String title, TextEditingController controller,
          {TextInputFormatter? inputType}) =>
      FractionallySizedBox(
        widthFactor: 0.9,
        child: Row(
          children: [
            Expanded(child: Text(title, style: Theme.of(context).textTheme.bodyText1)),
            Expanded(
              child: TextFormField(
                inputFormatters: [
                  inputType != null ? inputType : FilteringTextInputFormatter.digitsOnly,
                ],
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.main),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: AppColors.main),
                  ),
                ),
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Value cannot be empty';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      );
}
