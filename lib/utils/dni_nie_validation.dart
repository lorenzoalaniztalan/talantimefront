/// Regex expression for spanish DNI validation.
///
/// Instead of ['A-Z'], perhaps is more accurate ['TRWAGMYFPDXBNJZSQVHLCKE'].
const String _dniRegex = r'^([0-9]{8})([A-Z])$';

/// Regex expression for spanish NIE validation.
///
/// Instead of ['A-Z'], perhaps is more accurate ['TRWAGMYFPDXBNJZSQVHLCKE'].
const String _nieRegex = r'^([XYZ][0-9]{7})([A-Z])$';

/// Function that validates a String against spanish DNI and NIE, checking if
/// matches any.
bool validateDniNie(String dniNie) {
  final dniRegex = RegExp(_dniRegex);
  final nieRegex = RegExp(_nieRegex);

  return dniRegex.hasMatch(dniNie) || nieRegex.hasMatch(dniNie);
}
