import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
import 'package:painter/app/modules/home/controllers/home_controller.dart';
import 'package:painter/app/modules/settings/controllers/settings_controller.dart';

class SpringyWidget extends StatefulWidget {
  //================================ Properties ================================
  final Widget child;
  final Duration duration;
  final Alignment alignment;
  //================================ Constructor ===============================
  const SpringyWidget({
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.alignment = Alignment.bottomRight,
  });

  @override
  _SpringyWidgetState createState() => _SpringyWidgetState();
}

class _SpringyWidgetState extends State<SpringyWidget>
    with SingleTickerProviderStateMixin {
  //================================= Parameters ===============================
  late AnimationController _animationController;
  late Animation<Alignment> _alignmentAnimation;
  late Alignment _dragAlignment = widget.alignment;
  final homeController = Get.find<HomeController>();
  final settingsController = Get.find<SettingsController>();
  //================================== Methods =================================
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    // update the [_drageAlignment] when the [animationController] works
    _animationController.addListener(() {
      setState(
        () {
          _dragAlignment = _alignmentAnimation.value;
        },
      );
    });
  }

  //============================================================================
  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _alignmentAnimation = _animationController.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: widget.alignment,
      ),
    );
    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller, to create the springy animation.
    final _unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final _unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final _unitsPerSecond = Offset(_unitsPerSecondX, _unitsPerSecondY);
    final _unitVelocity = _unitsPerSecond.distance;
    // from [physics] package to add the springness to the animation
    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final _springSimulation = SpringSimulation(spring, 0, 1, _unitVelocity);

    _animationController.animateWith(_springSimulation);
  }

  //============================================================================
  void _stopAnimation() {
    _animationController.stop();
  }

  //============================================================================
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  //============================================================================

  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final _size = MediaQuery.of(context).size;

    //==========================================================================
    return GestureDetector(
      // [Align] with [AnimationController ]is used to animated the alignment
      //  of the widget while it's being held
      onPanUpdate: (details) {
        // add to the current alignment some [x,y] to move it
        // divide by 2 to convert units of “pixels dragged” to coordinates
        // that Align uses which is in range [0,1]
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (_size.width / 2.3),
            details.delta.dy / (_size.height / 2.4),
          );
        });

        // remove the point where the widget is at
        homeController.erase(
          details.localPosition,
          settingsController.eraserSize,
        );
      },

      // this will call the 'run animation' method to animate the widget
      // back to it's position when the user releases his fingers
      onPanEnd: (endDetails) =>
          _runAnimation(endDetails.velocity.pixelsPerSecond, _size),
      // will be used to stop the animation
      onPanDown: (_) => _stopAnimation(),
      child: Align(
        alignment: _dragAlignment,
        child: widget.child,
      ),
    );
  }
}
