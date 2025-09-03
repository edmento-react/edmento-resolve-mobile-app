import '../entities/comm_message.dart';
import '../enums/comm_tab.dart';

abstract class ICommunicationRepository {
  Future<List<CommMessage>> fetch({
    required int page,
    required int pageSize,
    required CommTab tab,
  });
}
