import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/principal.dart';
import '../../domain/repositories/principal_repository.dart';
import '../../domain/usecases/get_principal_profile.dart';

// Events
abstract class PrincipalEvent extends Equatable {
  const PrincipalEvent();

  @override
  List<Object> get props => [];
}

class LoadPrincipalProfile extends PrincipalEvent {}

class LoadSchoolStatistics extends PrincipalEvent {}

class LoadStaffList extends PrincipalEvent {}

class LoadStudentList extends PrincipalEvent {}

class LoadSchoolReports extends PrincipalEvent {}

// States
abstract class PrincipalState extends Equatable {
  const PrincipalState();

  @override
  List<Object> get props => [];
}

class PrincipalInitial extends PrincipalState {}

class PrincipalLoading extends PrincipalState {}

class PrincipalProfileLoaded extends PrincipalState {
  final Principal principal;

  const PrincipalProfileLoaded(this.principal);

  @override
  List<Object> get props => [principal];
}

class SchoolStatisticsLoaded extends PrincipalState {
  final Map<String, dynamic> statistics;

  const SchoolStatisticsLoaded(this.statistics);

  @override
  List<Object> get props => [statistics];
}

class StaffListLoaded extends PrincipalState {
  final List<Map<String, dynamic>> staffList;

  const StaffListLoaded(this.staffList);

  @override
  List<Object> get props => [staffList];
}

class StudentListLoaded extends PrincipalState {
  final List<Map<String, dynamic>> studentList;

  const StudentListLoaded(this.studentList);

  @override
  List<Object> get props => [studentList];
}

class SchoolReportsLoaded extends PrincipalState {
  final List<Map<String, dynamic>> reports;

  const SchoolReportsLoaded(this.reports);

  @override
  List<Object> get props => [reports];
}

class PrincipalFailure extends PrincipalState {
  final String message;

  const PrincipalFailure(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class PrincipalBloc extends Bloc<PrincipalEvent, PrincipalState> {
  final GetPrincipalProfile getPrincipalProfile;
  final PrincipalRepository principalRepository;

  PrincipalBloc({
    required this.getPrincipalProfile,
    required this.principalRepository,
  }) : super(PrincipalInitial()) {
    on<LoadPrincipalProfile>(_onLoadPrincipalProfile);
    on<LoadSchoolStatistics>(_onLoadSchoolStatistics);
    on<LoadStaffList>(_onLoadStaffList);
    on<LoadStudentList>(_onLoadStudentList);
    on<LoadSchoolReports>(_onLoadSchoolReports);
  }

  Future<void> _onLoadPrincipalProfile(
    LoadPrincipalProfile event,
    Emitter<PrincipalState> emit,
  ) async {
    emit(PrincipalLoading());

    final result = await principalRepository.getPrincipalProfile();

    result.fold(
      (failure) => emit(PrincipalFailure(failure.message)),
      (principal) => emit(PrincipalProfileLoaded(principal)),
    );
  }

  Future<void> _onLoadSchoolStatistics(
    LoadSchoolStatistics event,
    Emitter<PrincipalState> emit,
  ) async {
    emit(PrincipalLoading());

    final result = await principalRepository.getSchoolStatistics();

    result.fold(
      (failure) => emit(PrincipalFailure(failure.message)),
      (statistics) => emit(SchoolStatisticsLoaded(statistics)),
    );
  }

  Future<void> _onLoadStaffList(
    LoadStaffList event,
    Emitter<PrincipalState> emit,
  ) async {
    emit(PrincipalLoading());

    final result = await principalRepository.getStaffList();

    result.fold(
      (failure) => emit(PrincipalFailure(failure.message)),
      (staffList) => emit(StaffListLoaded(staffList)),
    );
  }

  Future<void> _onLoadStudentList(
    LoadStudentList event,
    Emitter<PrincipalState> emit,
  ) async {
    emit(PrincipalLoading());

    final result = await principalRepository.getStudentList();

    result.fold(
      (failure) => emit(PrincipalFailure(failure.message)),
      (studentList) => emit(StudentListLoaded(studentList)),
    );
  }

  Future<void> _onLoadSchoolReports(
    LoadSchoolReports event,
    Emitter<PrincipalState> emit,
  ) async {
    emit(PrincipalLoading());

    final result = await principalRepository.getSchoolReports();

    result.fold(
      (failure) => emit(PrincipalFailure(failure.message)),
      (reports) => emit(SchoolReportsLoaded(reports)),
    );
  }
}
