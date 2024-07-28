import 'package:campus_square_api/campus_square_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final campusSquareProvider = Provider((ref) {
  return CampusSquare();
});

final isLoggedInProvider = StateProvider((ref) {
  return false;
});