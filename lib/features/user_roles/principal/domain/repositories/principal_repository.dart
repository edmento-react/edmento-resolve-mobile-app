import 'package:dartz/dartz.dart';

import '../../../../../core/error/exceptions.dart';
import '../entities/principal.dart';

abstract class PrincipalRepository {
  Future<Either<Failure, Principal>> getPrincipalProfile();
  Future<Either<Failure, Map<String, dynamic>>> getSchoolStatistics();
  Future<Either<Failure, List<Map<String, dynamic>>>> getStaffList();
  Future<Either<Failure, List<Map<String, dynamic>>>> getStudentList();
  Future<Either<Failure, List<Map<String, dynamic>>>> getSchoolReports();
}
