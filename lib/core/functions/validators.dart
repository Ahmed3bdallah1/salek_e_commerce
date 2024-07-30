import 'package:reactive_forms/reactive_forms.dart';

class MustNotMatchValidator extends Validator<dynamic> {
  final String controlName;
  final String matchingControlName;
  final bool markAsDirty;

  /// Constructs an instance of [MustMatchValidator]
  const MustNotMatchValidator(
      this.controlName, this.matchingControlName, this.markAsDirty)
      : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = {"validation_the_same": true};

    if (control is! FormGroup) {
      return error;
    }

    final formControl = control.control(controlName);
    final matchingFormControl = control.control(matchingControlName);

    if (formControl.value != null &&
        formControl.value.toString().isNotEmpty &&
        formControl.value == matchingFormControl.value) {
      matchingFormControl.setErrors(error, markAsDirty: markAsDirty);
      matchingFormControl.markAsTouched();
    } else {
      matchingFormControl.removeError("validation_the_same");
    }

    return null;
  }
}
