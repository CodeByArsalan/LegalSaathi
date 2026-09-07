import 'package:flutter/material.dart';

/// Resolves icon names that arrive from the API (a category's `icon`, a
/// quick-prompt `icon`) to Material icons, so the backend can name icons without
/// shipping code.
///
/// The live API uses two vocabularies — `Users` / `Home` / `Briefcase` / `Car`
/// for categories, and lucide names such as `FileText` / `Shield` for the
/// assistant's starter prompts — while the bundled mock JSON uses Material
/// names. All three are kept so whichever arrives still renders, and an unknown
/// name falls back rather than dropping the icon.
abstract final class AppIcons {
  const AppIcons._();

  static const Map<String, IconData> _byName = <String, IconData>{
    // Backend vocabulary.
    'users': Icons.people_outline_rounded,
    'home': Icons.home_work_rounded,
    'briefcase': Icons.business_center_rounded,
    'car': Icons.directions_car_filled_rounded,
    'filetext': Icons.description_rounded,
    'checkcircle': Icons.verified_outlined,
    'shield': Icons.shield_outlined,
    // Material-name aliases used by the mock catalogue.
    'home_work': Icons.home_work_rounded,
    'person_outline': Icons.person_outline_rounded,
    'balance': Icons.balance_rounded,
    'business_center': Icons.business_center_rounded,
    'badge': Icons.badge_rounded,
    'directions_car_filled_outlined': Icons.directions_car_filled_rounded,
    'description': Icons.description_rounded,
    'gavel': Icons.gavel_rounded,
  };

  static IconData byName(String name) =>
      _byName[name.trim().toLowerCase()] ?? Icons.description_outlined;
}
