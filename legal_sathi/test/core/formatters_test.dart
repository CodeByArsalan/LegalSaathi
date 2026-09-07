import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/core/utils/formatters.dart';

/// The document preview lists the stored answers under the server's own field
/// keys (`LandlordName`, `AgreementDate`), which are not something to show a
/// person. This is the humanising step, and it has to leave a key it cannot
/// split alone rather than mangling it.
void main() {
  group('fieldLabel', () {
    test('splits PascalCase keys into words', () {
      expect(Formatters.fieldLabel('LandlordName'), 'Landlord Name');
      expect(
        Formatters.fieldLabel('AffidavitStatement'),
        'Affidavit Statement',
      );
      expect(
        Formatters.fieldLabel('MonthlyRentInRupees'),
        'Monthly Rent In Rupees',
      );
    });

    test('breaks after a digit as well as after a letter', () {
      expect(Formatters.fieldLabel('Address1Line'), 'Address1 Line');
    });

    test('leaves a single word, an acronym and an empty key alone', () {
      expect(Formatters.fieldLabel('Cnic'), 'Cnic');
      expect(Formatters.fieldLabel('CNIC'), 'CNIC');
      expect(Formatters.fieldLabel('CNICNumber'), 'CNICNumber');
      expect(Formatters.fieldLabel(''), '');
    });
  });
}
