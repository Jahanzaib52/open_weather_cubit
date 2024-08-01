import 'package:equatable/equatable.dart';

enum ThemeStatus {
  light,
  dartk,
}

class ThemeState extends Equatable {
  final ThemeStatus themeStatus;
  const ThemeState({required this.themeStatus});
  factory ThemeState.initial() {
    return const ThemeState(themeStatus: ThemeStatus.light);
  }
  @override
  List<Object> get props => [themeStatus];
  ThemeState copyWith({ThemeStatus? themeStatus}) {
    return ThemeState(themeStatus: themeStatus ?? this.themeStatus);
  }
}
