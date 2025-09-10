import 'package:edmentoresolve/core/data/network/api_client.dart';
import 'package:edmentoresolve/features/user_roles/student/data/datasources/student_remote_data_source.dart';

class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  final ApiClient apiClient;
  StudentRemoteDataSourceImpl(this.apiClient);
}
