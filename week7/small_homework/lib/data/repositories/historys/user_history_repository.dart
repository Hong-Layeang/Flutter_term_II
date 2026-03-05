abstract class UserHistoryRepository {
  Future<List<String>> fetchRecentSongIds();
}