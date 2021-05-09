// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'theme_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ThemeEventTearOff {
  const _$ThemeEventTearOff();

  ThemeChanged themeChanged({required AppTheme theme}) {
    return ThemeChanged(
      theme: theme,
    );
  }
}

/// @nodoc
const $ThemeEvent = _$ThemeEventTearOff();

/// @nodoc
mixin _$ThemeEvent {
  AppTheme get theme => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AppTheme theme) themeChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppTheme theme)? themeChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ThemeChanged value) themeChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ThemeChanged value)? themeChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThemeEventCopyWith<ThemeEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeEventCopyWith<$Res> {
  factory $ThemeEventCopyWith(
          ThemeEvent value, $Res Function(ThemeEvent) then) =
      _$ThemeEventCopyWithImpl<$Res>;
  $Res call({AppTheme theme});
}

/// @nodoc
class _$ThemeEventCopyWithImpl<$Res> implements $ThemeEventCopyWith<$Res> {
  _$ThemeEventCopyWithImpl(this._value, this._then);

  final ThemeEvent _value;
  // ignore: unused_field
  final $Res Function(ThemeEvent) _then;

  @override
  $Res call({
    Object? theme = freezed,
  }) {
    return _then(_value.copyWith(
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as AppTheme,
    ));
  }
}

/// @nodoc
abstract class $ThemeChangedCopyWith<$Res>
    implements $ThemeEventCopyWith<$Res> {
  factory $ThemeChangedCopyWith(
          ThemeChanged value, $Res Function(ThemeChanged) then) =
      _$ThemeChangedCopyWithImpl<$Res>;
  @override
  $Res call({AppTheme theme});
}

/// @nodoc
class _$ThemeChangedCopyWithImpl<$Res> extends _$ThemeEventCopyWithImpl<$Res>
    implements $ThemeChangedCopyWith<$Res> {
  _$ThemeChangedCopyWithImpl(
      ThemeChanged _value, $Res Function(ThemeChanged) _then)
      : super(_value, (v) => _then(v as ThemeChanged));

  @override
  ThemeChanged get _value => super._value as ThemeChanged;

  @override
  $Res call({
    Object? theme = freezed,
  }) {
    return _then(ThemeChanged(
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as AppTheme,
    ));
  }
}

/// @nodoc

class _$ThemeChanged implements ThemeChanged {
  const _$ThemeChanged({required this.theme});

  @override
  final AppTheme theme;

  @override
  String toString() {
    return 'ThemeEvent.themeChanged(theme: $theme)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ThemeChanged &&
            (identical(other.theme, theme) ||
                const DeepCollectionEquality().equals(other.theme, theme)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(theme);

  @JsonKey(ignore: true)
  @override
  $ThemeChangedCopyWith<ThemeChanged> get copyWith =>
      _$ThemeChangedCopyWithImpl<ThemeChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AppTheme theme) themeChanged,
  }) {
    return themeChanged(theme);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AppTheme theme)? themeChanged,
    required TResult orElse(),
  }) {
    if (themeChanged != null) {
      return themeChanged(theme);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ThemeChanged value) themeChanged,
  }) {
    return themeChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ThemeChanged value)? themeChanged,
    required TResult orElse(),
  }) {
    if (themeChanged != null) {
      return themeChanged(this);
    }
    return orElse();
  }
}

abstract class ThemeChanged implements ThemeEvent {
  const factory ThemeChanged({required AppTheme theme}) = _$ThemeChanged;

  @override
  AppTheme get theme => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ThemeChangedCopyWith<ThemeChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$ThemeStateTearOff {
  const _$ThemeStateTearOff();

  ThemeStat themeStat({required ThemeData themeData}) {
    return ThemeStat(
      themeData: themeData,
    );
  }
}

/// @nodoc
const $ThemeState = _$ThemeStateTearOff();

/// @nodoc
mixin _$ThemeState {
  ThemeData get themeData => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ThemeData themeData) themeStat,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ThemeData themeData)? themeStat,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ThemeStat value) themeStat,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ThemeStat value)? themeStat,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThemeStateCopyWith<ThemeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeStateCopyWith<$Res> {
  factory $ThemeStateCopyWith(
          ThemeState value, $Res Function(ThemeState) then) =
      _$ThemeStateCopyWithImpl<$Res>;
  $Res call({ThemeData themeData});
}

/// @nodoc
class _$ThemeStateCopyWithImpl<$Res> implements $ThemeStateCopyWith<$Res> {
  _$ThemeStateCopyWithImpl(this._value, this._then);

  final ThemeState _value;
  // ignore: unused_field
  final $Res Function(ThemeState) _then;

  @override
  $Res call({
    Object? themeData = freezed,
  }) {
    return _then(_value.copyWith(
      themeData: themeData == freezed
          ? _value.themeData
          : themeData // ignore: cast_nullable_to_non_nullable
              as ThemeData,
    ));
  }
}

/// @nodoc
abstract class $ThemeStatCopyWith<$Res> implements $ThemeStateCopyWith<$Res> {
  factory $ThemeStatCopyWith(ThemeStat value, $Res Function(ThemeStat) then) =
      _$ThemeStatCopyWithImpl<$Res>;
  @override
  $Res call({ThemeData themeData});
}

/// @nodoc
class _$ThemeStatCopyWithImpl<$Res> extends _$ThemeStateCopyWithImpl<$Res>
    implements $ThemeStatCopyWith<$Res> {
  _$ThemeStatCopyWithImpl(ThemeStat _value, $Res Function(ThemeStat) _then)
      : super(_value, (v) => _then(v as ThemeStat));

  @override
  ThemeStat get _value => super._value as ThemeStat;

  @override
  $Res call({
    Object? themeData = freezed,
  }) {
    return _then(ThemeStat(
      themeData: themeData == freezed
          ? _value.themeData
          : themeData // ignore: cast_nullable_to_non_nullable
              as ThemeData,
    ));
  }
}

/// @nodoc

class _$ThemeStat implements ThemeStat {
  const _$ThemeStat({required this.themeData});

  @override
  final ThemeData themeData;

  @override
  String toString() {
    return 'ThemeState.themeStat(themeData: $themeData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ThemeStat &&
            (identical(other.themeData, themeData) ||
                const DeepCollectionEquality()
                    .equals(other.themeData, themeData)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(themeData);

  @JsonKey(ignore: true)
  @override
  $ThemeStatCopyWith<ThemeStat> get copyWith =>
      _$ThemeStatCopyWithImpl<ThemeStat>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ThemeData themeData) themeStat,
  }) {
    return themeStat(themeData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ThemeData themeData)? themeStat,
    required TResult orElse(),
  }) {
    if (themeStat != null) {
      return themeStat(themeData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ThemeStat value) themeStat,
  }) {
    return themeStat(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ThemeStat value)? themeStat,
    required TResult orElse(),
  }) {
    if (themeStat != null) {
      return themeStat(this);
    }
    return orElse();
  }
}

abstract class ThemeStat implements ThemeState {
  const factory ThemeStat({required ThemeData themeData}) = _$ThemeStat;

  @override
  ThemeData get themeData => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $ThemeStatCopyWith<ThemeStat> get copyWith =>
      throw _privateConstructorUsedError;
}
