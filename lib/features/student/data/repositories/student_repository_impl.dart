import 'package:edmentoresolve/core/network/network_info.dart';
import 'package:edmentoresolve/features/student/data/datasources/student_remote_data_source.dart';

import '../../domain/repositories/student_repository.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  StudentRepositoryImpl(this.remoteDataSource, this.networkInfo);
}
