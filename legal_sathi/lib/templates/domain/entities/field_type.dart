/// Input kinds the dynamic document builder knows how to render.
///
/// The twelve values are the backend's `FieldType` enum, which serialises in
/// PascalCase (`Text`, `TextArea`, `Cnic`, `CurrencyPkr`), so parsing compares
/// case-insensitively. `Select` is the one name that does not carry over: the
/// app already calls a single-choice options field a dropdown.
enum FieldType {
  text,
  textarea,
  number,
  date,
  dropdown,
  email,
  phone,
  cnic,
  radio,
  checkbox,
  currencyPkr,
  address;

  static FieldType parse(String? value) {
    final String normalized = value?.trim().toLowerCase() ?? '';
    if (normalized == 'select') return FieldType.dropdown;
    return FieldType.values.firstWhere(
      (FieldType type) => type.name.toLowerCase() == normalized,
      orElse: () => FieldType.text,
    );
  }

  /// Choices come from `optionsJson` rather than from free typing.
  bool get isOptionsBased =>
      this == FieldType.dropdown ||
      this == FieldType.radio ||
      this == FieldType.checkbox;

  /// A checkbox group is the only field that holds more than one value; the
  /// answer map is `String`-valued, so the picks are stored comma-joined.
  bool get isMultiSelect => this == FieldType.checkbox;

  bool get acceptsMultiline =>
      this == FieldType.textarea || this == FieldType.address;
}
