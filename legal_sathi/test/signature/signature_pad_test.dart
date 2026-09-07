import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/signature/widgets/signature_pad.dart';

/// The pad's own rule, which decides whether the "send code" button does
/// anything: a tap leaves a point, and a point is not a signature.
void main() {
  late SignaturePadController pad;

  setUp(() => pad = SignaturePadController());
  tearDown(() => pad.dispose());

  test('starts empty', () {
    expect(pad.hasInk, isFalse);
    expect(pad.strokes, isEmpty);
  });

  test('a tap is not ink', () {
    pad.startStroke(const Offset(10, 10));

    expect(pad.hasInk, isFalse);
    expect(pad.strokes.single, <Offset>[const Offset(10, 10)]);
  });

  test('a drawn stroke is ink', () {
    pad
      ..startStroke(const Offset(10, 10))
      ..extendStroke(const Offset(20, 30))
      ..extendStroke(const Offset(40, 12));

    expect(pad.hasInk, isTrue);
    expect(pad.strokes.single, hasLength(3));
  });

  test('lifting the finger starts a separate stroke', () {
    pad
      ..startStroke(const Offset(0, 0))
      ..extendStroke(const Offset(5, 5))
      ..startStroke(const Offset(40, 40))
      ..extendStroke(const Offset(45, 45));

    expect(pad.strokes, hasLength(2));
    expect(pad.hasInk, isTrue);
  });

  test('a point with no stroke to join is dropped', () {
    pad.extendStroke(const Offset(5, 5));

    expect(pad.strokes, isEmpty);
    expect(pad.hasInk, isFalse);
  });

  test('clearing empties the pad and says so', () {
    pad
      ..startStroke(const Offset(0, 0))
      ..extendStroke(const Offset(5, 5));

    pad.clear();

    expect(pad.hasInk, isFalse);
    expect(pad.strokes, isEmpty);
  });

  test('listeners hear about ink and about clearing it, not about no-ops', () {
    int notifications = 0;
    pad.addListener(() => notifications++);

    pad.clear();
    expect(notifications, 0);

    pad
      ..startStroke(const Offset(0, 0))
      ..extendStroke(const Offset(5, 5));
    expect(notifications, 2);

    pad.clear();
    expect(notifications, 3);
  });
}
