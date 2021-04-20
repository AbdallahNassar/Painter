import 'dart:ui';

// I did this so that I can define my own 'toJson' and 'fromJson' on this
// class, to read/write from in into the storage.
class MyOffset extends Offset {
  //================================ Constructor ===============================
  MyOffset(double dx, double dy) : super(dx, dy);
  //============================================================================
  factory MyOffset.fromJson(Map<String, dynamic> jsonOffset) => MyOffset(
        jsonOffset['dx'],
        jsonOffset['dy'],
      );
  //================================= Methods ==================================

  Map<String, double> toJson() => {
        'dx': dx,
        'dy': dy,
      };
  //============================================================================

}
