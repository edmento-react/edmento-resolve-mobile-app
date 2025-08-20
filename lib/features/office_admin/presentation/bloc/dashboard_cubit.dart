import 'package:flutter_bloc/flutter_bloc.dart';

class OfficeAdminDashboardCubit extends Cubit<int> {
  OfficeAdminDashboardCubit() : super(0);

  void setTab(int index) => emit(index);
}
