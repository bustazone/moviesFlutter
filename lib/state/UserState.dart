import 'package:meta/meta.dart';
import 'package:pelis_busta/models/User.dart';

@immutable
class UserState {
  final User user;
  final bool loading;

  const UserState({this.user, this.loading});

  factory UserState.initial() => new UserState(user: null, loading: false);

  UserState copyWith({User user, bool loading}) {
    return new UserState(
        user: user ?? this.user, loading: loading ?? this.loading);
  }

  @override
  int get hashCode => user.hashCode ^ loading.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          runtimeType == other.runtimeType &&
          user == other.user &&
          loading == other.loading;

  @override
  String toString() {
    return 'UserState{user: $user, loading: $loading}';
  }
}
