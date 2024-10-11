sealed class Result<T, E> {}

class Ok<T, E> implements Result<T, E> {
  final T value;
  const Ok(this.value);
}

class Err<T, E> implements Result<T, E> {
  final E error;
  const Err(this.error);
}
