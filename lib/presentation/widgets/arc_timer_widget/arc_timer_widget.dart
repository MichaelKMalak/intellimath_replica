import 'package:intellimath_replica/presentation/core_flutter_packages.dart';

import 'timer_painter.dart';

class ArcTimerWidget extends StatefulWidget {
  final Widget? child;
  final VoidCallback? onTimerFinished;
  final bool shouldStartTimer;
  final int countDownDurationInSeconds;
  final Function(int)? onCurrentTimeChange;

  const ArcTimerWidget({
    Key? key,
    this.child,
    this.onTimerFinished,
    this.shouldStartTimer = false,
    this.onCurrentTimeChange,
    required this.countDownDurationInSeconds,
  }) : super(key: key);

  @override
  ArcTimerWidgetState createState() => ArcTimerWidgetState();
}

class ArcTimerWidgetState extends State<ArcTimerWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;

  int remainingDuration = 0;

  void trackAnimationDuration() {
    final duration = controller.duration! * controller.value;
    final durationInSeconds = duration.inSeconds;
    if (durationInSeconds != remainingDuration &&
        widget.onCurrentTimeChange != null) {
      widget.onCurrentTimeChange!(duration.inSeconds);
      setState(() {
        remainingDuration = durationInSeconds;
      });
    }
  }

  @override
  void didUpdateWidget(ArcTimerWidget oldWidget) {
    if (oldWidget.shouldStartTimer != widget.shouldStartTimer) {
      resetTimer();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.countDownDurationInSeconds),
    )..addStatusListener((status) {
        if (controller.status == AnimationStatus.dismissed) {
          widget.onTimerFinished!();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    trackAnimationDuration();
    final themeData = Theme.of(context);
    return Align(
      alignment: FractionalOffset.center,
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: buildTimerAnimation(themeData),
            ),
            Align(
              alignment: FractionalOffset.center,
              child: widget.child ?? const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedBuilder buildTimerAnimation(ThemeData themeData) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          painter: TimerPainter(
            animation: controller,
            backgroundColor: Colors.white,
            color: themeData.indicatorColor,
          ),
        );
      },
    );
  }

  void resetTimer() {
    controller.reverse(from: 1);
  }
}
