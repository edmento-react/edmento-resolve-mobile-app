import 'package:dartz/dartz.dart';
import 'package:edmentoresolve/core/error/exceptions.dart';
import 'package:edmentoresolve/features/user_roles/principal/domain/entities/principal.dart';

import '../../domain/repositories/principal_repository.dart';

class PrincipalRepositoryImpl implements PrincipalRepository {
  @override
  Future<Either<Failure, Principal>> getPrincipalProfile() {
    // TODO: implement getPrincipalProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getSchoolReports() {
    // TODO: implement getSchoolReports
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getSchoolStatistics() {
    // TODO: implement getSchoolStatistics
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getStaffList() {
    // TODO: implement getStaffList
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getStudentList() {
    // TODO: implement getStudentList
    throw UnimplementedError();
  }

  // Implement repository methods
}
