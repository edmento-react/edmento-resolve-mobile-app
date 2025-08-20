// lib/features/student/presentation/bloc/poster_overlay_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

class PosterOverlayCubit extends Cubit<bool> {
  PosterOverlayCubit() : super(true); // initially hidden

  void show() => emit(true);
  void hide() => emit(false);
  void toggle() => emit(!state);
}
