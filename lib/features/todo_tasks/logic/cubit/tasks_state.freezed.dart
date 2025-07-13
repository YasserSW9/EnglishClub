// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TasksState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TasksState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksState<$T>()';
}


}

/// @nodoc
class $TasksStateCopyWith<T,$Res>  {
$TasksStateCopyWith(TasksState<T> _, $Res Function(TasksState<T>) __);
}


/// Adds pattern-matching-related methods to [TasksState].
extension TasksStatePatterns<T> on TasksState<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial<T> value)?  initial,TResult Function( Loading<T> value)?  loading,TResult Function( LoadingMore<T> value)?  loadingMore,TResult Function( Success<T> value)?  success,TResult Function( Error<T> value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case LoadingMore() when loadingMore != null:
return loadingMore(_that);case Success() when success != null:
return success(_that);case Error() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial<T> value)  initial,required TResult Function( Loading<T> value)  loading,required TResult Function( LoadingMore<T> value)  loadingMore,required TResult Function( Success<T> value)  success,required TResult Function( Error<T> value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case Loading():
return loading(_that);case LoadingMore():
return loadingMore(_that);case Success():
return success(_that);case Error():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial<T> value)?  initial,TResult? Function( Loading<T> value)?  loading,TResult? Function( LoadingMore<T> value)?  loadingMore,TResult? Function( Success<T> value)?  success,TResult? Function( Error<T> value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case LoadingMore() when loadingMore != null:
return loadingMore(_that);case Success() when success != null:
return success(_that);case Error() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  loadingMore,TResult Function( List<DoneData> doneTasks,  List<Waiting> waitingTasks)?  success,TResult Function( String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case LoadingMore() when loadingMore != null:
return loadingMore();case Success() when success != null:
return success(_that.doneTasks,_that.waitingTasks);case Error() when error != null:
return error(_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  loadingMore,required TResult Function( List<DoneData> doneTasks,  List<Waiting> waitingTasks)  success,required TResult Function( String error)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case Loading():
return loading();case LoadingMore():
return loadingMore();case Success():
return success(_that.doneTasks,_that.waitingTasks);case Error():
return error(_that.error);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  loadingMore,TResult? Function( List<DoneData> doneTasks,  List<Waiting> waitingTasks)?  success,TResult? Function( String error)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case LoadingMore() when loadingMore != null:
return loadingMore();case Success() when success != null:
return success(_that.doneTasks,_that.waitingTasks);case Error() when error != null:
return error(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial<T> implements TasksState<T> {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksState<$T>.initial()';
}


}




/// @nodoc


class Loading<T> implements TasksState<T> {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksState<$T>.loading()';
}


}




/// @nodoc


class LoadingMore<T> implements TasksState<T> {
  const LoadingMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingMore<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TasksState<$T>.loadingMore()';
}


}




/// @nodoc


class Success<T> implements TasksState<T> {
  const Success({required final  List<DoneData> doneTasks, required final  List<Waiting> waitingTasks}): _doneTasks = doneTasks,_waitingTasks = waitingTasks;
  

 final  List<DoneData> _doneTasks;
 List<DoneData> get doneTasks {
  if (_doneTasks is EqualUnmodifiableListView) return _doneTasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_doneTasks);
}

 final  List<Waiting> _waitingTasks;
 List<Waiting> get waitingTasks {
  if (_waitingTasks is EqualUnmodifiableListView) return _waitingTasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_waitingTasks);
}


/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<T, Success<T>> get copyWith => _$SuccessCopyWithImpl<T, Success<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success<T>&&const DeepCollectionEquality().equals(other._doneTasks, _doneTasks)&&const DeepCollectionEquality().equals(other._waitingTasks, _waitingTasks));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_doneTasks),const DeepCollectionEquality().hash(_waitingTasks));

@override
String toString() {
  return 'TasksState<$T>.success(doneTasks: $doneTasks, waitingTasks: $waitingTasks)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<T,$Res> implements $TasksStateCopyWith<T, $Res> {
  factory $SuccessCopyWith(Success<T> value, $Res Function(Success<T>) _then) = _$SuccessCopyWithImpl;
@useResult
$Res call({
 List<DoneData> doneTasks, List<Waiting> waitingTasks
});




}
/// @nodoc
class _$SuccessCopyWithImpl<T,$Res>
    implements $SuccessCopyWith<T, $Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success<T> _self;
  final $Res Function(Success<T>) _then;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? doneTasks = null,Object? waitingTasks = null,}) {
  return _then(Success<T>(
doneTasks: null == doneTasks ? _self._doneTasks : doneTasks // ignore: cast_nullable_to_non_nullable
as List<DoneData>,waitingTasks: null == waitingTasks ? _self._waitingTasks : waitingTasks // ignore: cast_nullable_to_non_nullable
as List<Waiting>,
  ));
}


}

/// @nodoc


class Error<T> implements TasksState<T> {
  const Error({required this.error});
  

 final  String error;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<T, Error<T>> get copyWith => _$ErrorCopyWithImpl<T, Error<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error<T>&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'TasksState<$T>.error(error: $error)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<T,$Res> implements $TasksStateCopyWith<T, $Res> {
  factory $ErrorCopyWith(Error<T> value, $Res Function(Error<T>) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$ErrorCopyWithImpl<T,$Res>
    implements $ErrorCopyWith<T, $Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error<T> _self;
  final $Res Function(Error<T>) _then;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(Error<T>(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
