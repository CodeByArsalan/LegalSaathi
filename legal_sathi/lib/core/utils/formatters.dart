import 'package:easy_localization/easy_localization.dart';

import '../constants/app_constants.dart';

abstract final class Formatters {
  /// Documents and receipts always quote amounts in rupees.
  static String rupees(double amount) {
    final NumberFormat format = NumberFormat.currency(
      locale: 'en_PK',
      symbol: AppConstants.currencySymbol,
      decimalDigits: amount % 1 == 0 ? 0 : 2,
    );
    return format.format(amount);
  }

  static String freeOrPrice(double price) =>
      price <= 0 ? tr('common.free') : rupees(price);

  static String date(DateTime value, {String pattern = 'dd MMM yyyy'}) =>
      DateFormat(pattern, Intl.getCurrentLocale()).format(value);

  static String dateTime(DateTime value) => DateFormat(
    'dd MMM yyyy • hh:mm a',
    Intl.getCurrentLocale(),
  ).format(value);

  /// A moment within the current day, for countdowns and expiries.
  static String time(DateTime value) =>
      DateFormat('hh:mm a', Intl.getCurrentLocale()).format(value);

  static String cnic(String value) {
    final String digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != AppConstants.cnicDigits) return value;
    return '${digits.substring(0, 5)}-${digits.substring(5, 12)}-${digits.substring(12)}';
  }

  /// A server field key made readable: `LandlordCnic` → `Landlord Cnic`.
  ///
  /// A document's answers are keyed by field, and the payload carries no labels,
  /// so this avoids a second call to the template just to name a list. Casing is
  /// left alone so an all-caps key stays all-caps.
  static String fieldLabel(String key) =>
      key.replaceAllMapped(RegExp(r'(?<=[a-z0-9])(?=[A-Z])'), (Match _) => ' ');
}
