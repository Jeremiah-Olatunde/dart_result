sealed class Result<T, E> {}

class Ok<T, E> implements Result<T, E> {
  final T value;
  const Ok(this.value);

  @override
  String toString() => 'Ok($value)';
}

class Err<T, E> implements Result<T, E> {
  final E error;
  const Err(this.error);

  @override
  String toString() => 'Err($error)';  
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

U mapOrElse<T, U, E>(Result<T, E> result, U Function(E) g, U Function(T) f) {
  return switch (result) {
    Ok(value: T value) => f(value),
    Err(error: E error) => g(error),
  };
}

Result<T, F> mapErr<T, F, E>(Result<T, E> result, F Function(E) f) {
  return switch (result) {
    Ok(value: T value) => Ok(value),
    Err(error: E error) => Err(f(error)),
  };
}

Result<T, E> inspect<T, E>(Result<T, E> result, Function(T) f) {
  switch (result) {
    case Ok(value: T value):
      f(value);
      Ok(value);
    case Err(error: E error):
      Err(error);
  }

  return result;
}

Result<T, E> inspectErr<T, E>(Result<T, E> result, Function(E) f) {
  switch (result) {
    case Ok(value: T value):
      Ok(value);
    case Err(error: E error):
      f(error);
      Err(error);
  }

  return result;
}

Result<T, E> flatten<T, E>(Result<Result<T, E>, E> result) {
  return switch (result) {
    Ok(value: Result<T, E> value) => value,
    Err(error: E error) => Err(error),
  };
}

Result<U, E> andThen<T, U, E>(Result<T, E> result, Result<U, E> Function(T) f) {
  return flatten(map(result, f));
}

bool isOk<T, E>(Result<T, E> result) {
  return switch (result) {
    Ok(value: _) => true,
    Err(error: _) => false,
  };
}

bool isErr<T, E>(Result<T, E> result) {
  return switch (result) {
    Ok(value: _) => false,
    Err(error: _) => true,
  };
}

T expect<T, E>(Result<T, E> result, String message){
  return switch(result){
    Ok(value: T value) => value,
    Err(error: E error) => throw '$message: $error',
  };
}

T unwrap<T, E>(Result<T, E> result){
  return switch(result){
    Ok(value: T value) => value,
    Err(error: E error) => throw 'unwrapped Err: $error',
  };
}