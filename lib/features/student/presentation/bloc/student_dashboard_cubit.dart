import 'package:flutter_bloc/flutter_bloc.dart';

class StudentDashboardCubit extends Cubit<int> {
  StudentDashboardCubit() : super(0);
  void setTab(int index) => emit(index);
}
