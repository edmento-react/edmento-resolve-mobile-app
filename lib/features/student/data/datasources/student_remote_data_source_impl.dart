import 'package:edmentoresolve/core/network/api_client.dart';
import 'package:edmentoresolve/features/student/data/datasources/student_remote_data_source.dart';

class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  final ApiClient apiClient;
  StudentRemoteDataSourceImpl(this.apiClient);
}
