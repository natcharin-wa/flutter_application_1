import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:bmr_app/models/body_profile.dart';

class BmrPage extends StatefulWidget {
  const BmrPage({super.key});

  @override
  State<BmrPage> createState() => _BmrPageState();
}

class _BmrPageState extends State<BmrPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  BodyProfile bodyProfile = BodyProfile(
    gender: '',
    age: 0,
    weight: 0.0,
    height: 0.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BMR Calculator'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderRadioGroup<String>(
                  name: 'gender',
                  decoration: const InputDecoration(
                    labelText: 'Gender:',
                    icon: Icon(Icons.wc_outlined, color: Colors.deepPurple),
                  ),
                  orientation: OptionsOrientation.vertical,
                  options: ['Male', 'Female']
                      .map(
                        (yourGender) => FormBuilderFieldOption(
                          value: yourGender,
                          child: Text(yourGender),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    bodyProfile.gender = value ?? '';
                  },
                  autovalidateMode: AutovalidateMode.always,
                  validator: FormBuilderValidators.required(
                    errorText: 'Please select a gender',
                  ),
                ),
                SizedBox(height: 16.0),
                FormBuilderTextField(
                  name: 'weight',
                  decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                    icon: Icon(Icons.scale),
                    iconColor: Colors.deepPurple,
                  ),
                  onChanged: (value) {
                    bodyProfile.weight =
                        double.tryParse(value.toString()) ?? 0.0;
                  },
                  autovalidateMode: AutovalidateMode.always,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Weight is required.',
                    ),
                    FormBuilderValidators.numeric(
                      errorText: 'Please enter a valid weight.',
                    ),
                  ]),
                ),
                SizedBox(height: 16.0),
                FormBuilderTextField(
                  name: 'height',
                  decoration: InputDecoration(
                    labelText: 'Height (cm)',
                    icon: Icon(Icons.format_size_outlined),
                    iconColor: Colors.deepPurple,
                  ),
                  onChanged: (value) {
                    bodyProfile.height =
                        double.tryParse(value.toString()) ?? 0.0;
                  },
                  autovalidateMode: AutovalidateMode.always,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Height is required.',
                    ),
                    FormBuilderValidators.numeric(
                      errorText: 'Please enter a valid height.',
                    ),
                  ]),
                ),
                SizedBox(height: 16),
                FormBuilderSlider(
                  name: 'age',
                  decoration: InputDecoration(
                    labelText: 'Age:(years)',
                    icon: Icon(Icons.elderly, color: Colors.deepPurple),
                  ),
                  min: 0,
                  max: 100,
                  divisions: 100,
                  initialValue: 25,
                  onChanged: (value) {
                    bodyProfile.age = value!.toInt();
                  },
                  autovalidateMode: AutovalidateMode.always,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Age is required.',
                    ),
                    FormBuilderValidators.min(
                      1,
                      errorText: 'Age must be at least 1',
                    ),
                  ]),
                ),
                SizedBox(height: 24),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Handle form submission
                          },
                          child: Text('Calculate'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Handle form reset                           
                          },
                          // style: ElevatedButton.styleFrom(
                          //   backgroundColor: Colors.grey,
                          //   foregroundColor: Colors.white,
                          // ),
                          child: Text('Reset'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
