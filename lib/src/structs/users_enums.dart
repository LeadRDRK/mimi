enum UsersListSort {
  followerDesc('+follower'),
  followerAsc('-follower'),
  createdAtDesc('+createdAt'),
  createdAtAsc('-createdAt'),
  updatedAtDesc('+updatedAt'),
  updatedAtAsc('-updatedAt');

  const UsersListSort(this.value);
  final String value;

  String toJson() => value;
}

enum UsersListState {
  all,
  alive;

  String toJson() => name;
}

enum UsersListOrigin {
  combined,
  local,
  remote;

  String toJson() => name;
}