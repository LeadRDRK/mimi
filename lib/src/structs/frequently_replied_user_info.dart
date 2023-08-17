import '../entities/user.dart';
import '../core/client.dart';

class FrequentlyRepliedUserInfo {
  FrequentlyRepliedUserInfo(Client client, Map<String, dynamic> map)
  : user = User(client, map['user'] as Map<String, dynamic>),
    weight = map['weight'] as double;

  /// The frequently replied user.
  final User user;

  /// The weight of the frequently replied user.
  final double weight;
}