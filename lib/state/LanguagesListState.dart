import 'package:meta/meta.dart';
import 'package:pelis_busta/models/LanguageList.dart';

@immutable
class LanguagesListState {
  final LanguageList languagesList;
  final LanguageList subtitlesList;
  final bool loading;

  const LanguagesListState(
      {
        this.languagesList,
        this.subtitlesList,
        this.loading
      });

  factory LanguagesListState.initial() => new LanguagesListState(languagesList: LanguageList(), subtitlesList: LanguageList(), loading: false);

  LanguagesListState copyWith({
    LanguageList languagesList,
    LanguageList subtitlesList,
    bool loading
  }) {
    return new LanguagesListState(
        languagesList: languagesList ?? this.languagesList,
        subtitlesList: subtitlesList ?? this.subtitlesList,
        loading: loading ?? this.loading
    );
  }

  @override
  int get hashCode =>
      languagesList.hashCode ^
      subtitlesList.hashCode ^
      loading.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LanguagesListState &&
              runtimeType == other.runtimeType &&
              languagesList == other.languagesList &&
              subtitlesList == other.subtitlesList &&
              loading == other.loading;

  @override
  String toString() {
    return 'LanguagesListState{languagesList: $languagesList, subtitlesList: $subtitlesList, loading: $loading}';
  }
}