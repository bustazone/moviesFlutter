import 'package:meta/meta.dart';
import 'package:pelis_busta/models/LanguageList.dart';

@immutable
class LanguagesListState {
  final LanguageList languagesList;
  final LanguageList subtitlesList;
  final bool loadingLanguages;
  final bool loadingSubtitles;

  const LanguagesListState(
      {this.languagesList,
      this.subtitlesList,
      this.loadingLanguages,
      this.loadingSubtitles});

  factory LanguagesListState.initial() => new LanguagesListState(
      languagesList: LanguageList(),
      subtitlesList: LanguageList(),
      loadingLanguages: false,
      loadingSubtitles: false);

  LanguagesListState copyWith(
      {LanguageList languagesList,
      LanguageList subtitlesList,
      bool loadingLanguages,
      bool loadingSubtitles}) {
    return new LanguagesListState(
        languagesList: languagesList ?? this.languagesList,
        subtitlesList: subtitlesList ?? this.subtitlesList,
        loadingLanguages: loadingLanguages ?? this.loadingLanguages,
        loadingSubtitles: loadingSubtitles ?? this.loadingSubtitles);
  }

  @override
  int get hashCode =>
      languagesList.hashCode ^
      subtitlesList.hashCode ^
      loadingLanguages.hashCode ^
      loadingSubtitles.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguagesListState &&
          runtimeType == other.runtimeType &&
          languagesList == other.languagesList &&
          subtitlesList == other.subtitlesList &&
          loadingLanguages == other.loadingLanguages &&
          loadingSubtitles == other.loadingSubtitles;

  @override
  String toString() {
    return 'LanguagesListState{languagesList: ${languagesList.length}, subtitlesList: ${subtitlesList.length}, loadingLanguages: $loadingLanguages, loadingSubtitles: $loadingSubtitles}';
  }
}
