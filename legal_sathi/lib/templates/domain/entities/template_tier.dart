/// Pricing band the backend puts a template in.
///
/// Serialised in PascalCase (`Free`, `Standard`, `Premium`, `Corporate`), so
/// parsing is case-insensitive. This is what makes a template free — not a
/// separate flag, and not `basePrice` alone.
enum TemplateTier {
  free,
  standard,
  premium,
  corporate;

  static TemplateTier parse(String? value) {
    final String normalized = value?.trim().toLowerCase() ?? '';
    return TemplateTier.values.firstWhere(
      (TemplateTier tier) => tier.name == normalized,
      orElse: () => TemplateTier.standard,
    );
  }

  String get l10nKey => 'templates.tier_$name';
}
