import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/extensions/context_x.dart';

/// The ink drawn so far, in the pad's own coordinates.
///
/// A controller rather than the pad's own state so the view can ask whether
/// anything was drawn and clear it without reaching into a [State].
final class SignaturePadController extends ChangeNotifier {
  final List<List<Offset>> _strokes = <List<Offset>>[];

  /// One point is a tap, not a signature.
  bool get hasInk => _strokes.any((List<Offset> stroke) => stroke.length > 1);

  Iterable<List<Offset>> get strokes => _strokes;

  void startStroke(Offset point) {
    _strokes.add(<Offset>[point]);
    notifyListeners();
  }

  void extendStroke(Offset point) {
    if (_strokes.isEmpty) return;
    _strokes.last.add(point);
    notifyListeners();
  }

  void clear() {
    if (_strokes.isEmpty) return;
    _strokes.clear();
    notifyListeners();
  }
}

/// Finger-drawn signature capture.
///
/// [boundaryKey] is handed to the [RepaintBoundary] the caller exports with
/// `toImage`, so the PNG can be taken without a package for it. The boundary
/// wraps the painted surface only — the hint text and the border stay outside it
/// and out of the exported image.
class SignaturePad extends StatelessWidget {
  const SignaturePad({
    required this.controller,
    required this.boundaryKey,
    this.height = 200,
    super.key,
  });

  final SignaturePadController controller;
  final Key boundaryKey;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: AppRadius.card,
        child: GestureDetector(
          onPanStart: (DragStartDetails details) =>
              controller.startStroke(details.localPosition),
          onPanUpdate: (DragUpdateDetails details) =>
              controller.extendStroke(details.localPosition),
          child: ListenableBuilder(
            listenable: controller,
            builder: (BuildContext context, Widget? child) => Stack(
              fit: StackFit.expand,
              children: <Widget>[
                RepaintBoundary(
                  key: boundaryKey,
                  child: CustomPaint(painter: _InkPainter(controller.strokes)),
                ),
                if (!controller.hasInk)
                  IgnorePointer(
                    child: Center(
                      child: Text(
                        tr('signature.pad_hint'),
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),
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

class _InkPainter extends CustomPainter {
  const _InkPainter(this.strokes);

  final Iterable<List<Offset>> strokes;

  @override
  void paint(Canvas canvas, Size size) {
    // Opaque white: the exported PNG is filed as evidence, and a transparent
    // background reads as blank on the dark viewers it may end up in.
    canvas.drawRect(Offset.zero & size, Paint()..color = AppColors.surface);

    final Paint ink = Paint()
      ..color = AppColors.text
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final List<Offset> stroke in strokes) {
      if (stroke.isEmpty) continue;
      final Path path = Path()..moveTo(stroke.first.dx, stroke.first.dy);
      for (final Offset point in stroke.skip(1)) {
        path.lineTo(point.dx, point.dy);
      }
      canvas.drawPath(path, ink);
    }
  }

  /// The controller only notifies when the ink actually changed, and it hands
  /// out the same live list every build, so there is nothing to compare.
  @override
  bool shouldRepaint(_InkPainter oldDelegate) => true;
}

/// The pad's caption row: what it is for, and the button that empties it.
class SignaturePadLabel extends StatelessWidget {
  const SignaturePadLabel({
    required this.onClear,
    this.enabled = true,
    super.key,
  });

  final VoidCallback onClear;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.draw_rounded, size: 18, color: AppColors.primary),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            tr('signature.draw'),
            style: context.textTheme.labelLarge,
          ),
        ),
        TextButton.icon(
          onPressed: enabled ? onClear : null,
          icon: const Icon(Icons.rotate_left_rounded, size: 18),
          label: Text(tr('signature.clear')),
        ),
      ],
    );
  }
}
