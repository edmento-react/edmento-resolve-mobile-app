import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/api_constants.dart';
import '../models/communication_inbox_model.dart';

part 'communication_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl + ApiConstants.apiVersion)
abstract class CommunicationApiService {
  factory CommunicationApiService(Dio dio, {String baseUrl}) =
      _CommunicationApiService;

  // ==================== COMMUNICATION ENDPOINTS ====================
  // Get all communication inbox (leave requests, mails, requests etc)
  @GET(ApiConstants.communicationInbox)
  Future<CommunicationInboxModel> getInbox();
}
