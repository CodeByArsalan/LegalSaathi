import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/core/utils/server_date.dart';

void main() {
  group('ServerDate.parse', () {
    test('reads an offset-less timestamp as UTC, not device-local', () {
      // Captured from GET /Documents/4: no designator, and two hours ahead of
      // the completedAt on the same record.
      final DateTime? parsed = ServerDate.parse('2026-09-07T10:32:54.8033333');

      expect(parsed, isNotNull);
      expect(parsed!.isUtc, isTrue);
      expect(parsed.toIso8601String(), startsWith('2026-09-07T10:32:54'));
    });

    test('leaves an explicit designator alone', () {
      expect(
        ServerDate.parse('2026-09-07T08:56:01.3234963Z')!.toIso8601String(),
        startsWith('2026-09-07T08:56:01'),
      );
      expect(ServerDate.parse('2026-09-07T08:56:01+05:00')!.toUtc().hour, 3);
    });

    test('returns null for anything unusable', () {
      expect(ServerDate.parse(null), isNull);
      expect(ServerDate.parse(''), isNull);
      expect(ServerDate.parse('   '), isNull);
      expect(ServerDate.parse('not-a-date'), isNull);
      expect(ServerDate.parse(1757234567), isNull);
    });
  });
}
