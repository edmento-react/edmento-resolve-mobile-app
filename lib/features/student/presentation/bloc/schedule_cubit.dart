import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleCubit extends Cubit<int> {
  ScheduleCubit() : super(0);

  void selectDay(int index) => emit(index);
}
