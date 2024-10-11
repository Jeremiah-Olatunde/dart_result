sealed class Result<T, E> {}

class Ok<T, E> implements Result<T, E> {
  final T value;
  const Ok(this.value);
}

class Err<T, E> implements Result<T, E> {
  final E error;
  const Err(this.error);
}

Result<U, E> map<T, U, E>(Result<T, E> result, U Function(T) f) {
  return switch (result) {
    Ok(value: T value) => Ok(f(value)),
    Err(error: E error) => Err(error)
  };
}

U mapOr<T, U, E>(Result<T, E> result, U fallback, U Function(T) f) {
  return switch (result) {
    Ok(value: T value) => f(value),
    Err(error: E _) => fallback,
  };
}
