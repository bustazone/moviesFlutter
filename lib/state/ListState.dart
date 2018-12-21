import 'package:meta/meta.dart';
import 'package:pelis_busta/models/UserList.dart';

@immutable
class ListState {
  final int selectedList;
  final UserList list;
  final bool loading;

  const ListState(
      {this.selectedList, this.list, this.loading});

  factory ListState.initial() => new ListState(
      selectedList: null, list: null, loading: false);

  ListState copyWith(
      {int selectedList, UserList list, bool loading}) {
    return new ListState(
        selectedList: selectedList ?? this.selectedList,
        list: list ?? this.list,
        loading: loading ?? this.loading);
  }

  @override
  int get hashCode => selectedList.hashCode ^ list.hashCode ^ loading.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListState &&
          runtimeType == other.runtimeType &&
          selectedList == other.selectedList &&
          list == other.list &&
          loading == other.loading;

  @override
  String toString() {
    return 'ListState{selectedList: $selectedList, list: $list, loading: $loading}';
  }
}
