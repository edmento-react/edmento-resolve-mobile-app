import 'package:flutter_bloc/flutter_bloc.dart';

class StudentCubit extends Cubit<int> {
  StudentCubit() : super(0);
  void selectStudent(int index) => emit(index);
}
