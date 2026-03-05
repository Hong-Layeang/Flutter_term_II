import 'user_history_repository.dart';

class UserHistoryRepositoryMock implements UserHistoryRepository {
  @override
  Future<List<String>> fetchRecentSongIds() async {
    return ['101', '102'];
  }
}
