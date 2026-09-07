import 'failure.dart';

/// Return type for repositories and usecases. Void operations use
/// `Result<bool>` so a success branch always carries a value.
sealed class Result<T> {
  const Result();

  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onFailure,
  });

  T? get value;
  Failure? get failure;

  bool get isSuccess => switch (this) {
    Success<T>() => true,
    FailureResult<T>() => false,
  };
}

final class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;

  @override
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onFailure,
  }) => onSuccess(data);

  @override
  T? get value => data;

  @override
  Failure? get failure => null;
}

final class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  @override
  final Failure failure;

  @override
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onFailure,
  }) => onFailure(failure);

  @override
  T? get value => null;
}
