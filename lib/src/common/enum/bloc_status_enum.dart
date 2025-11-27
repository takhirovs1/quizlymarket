enum Status {
  initial,
  loading,
  searching,
  loadingMore,
  success,
  error;

  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSearching => this == Status.searching;
  bool get isLoadingMore => this == Status.loadingMore;
  bool get isSuccess => this == Status.success;
  bool get isError => this == Status.error;

  T map<T>({
    required T Function() onInitial,
    required T Function() onLoading,
    required T Function() onSearching,
    required T Function() onLoadingMore,
    required T Function() onSuccess,
    required T Function() onError,
  }) => switch (this) {
    initial => onInitial(),
    loading => onLoading(),
    searching => onSearching(),
    loadingMore => onLoadingMore(),
    success => onSuccess(),
    error => onError(),
  };

  T maybeMap<T>({
    required T Function() orElse,
    T Function()? onInitial,
    T Function()? onLoading,
    T Function()? onSearching,
    T Function()? onLoadingMore,
    T Function()? onSuccess,
    T Function()? onError,
  }) => map<T>(
    onInitial: onInitial ?? orElse,
    onLoading: onLoading ?? orElse,
    onSearching: onSearching ?? orElse,
    onLoadingMore: onLoadingMore ?? orElse,
    onSuccess: onSuccess ?? orElse,
    onError: onError ?? orElse,
  );

  T? maybeMapOrNull<T>({
    T Function()? onInitial,
    T Function()? onLoading,
    T Function()? onSearching,
    T Function()? onLoadingMore,
    T Function()? onSuccess,
    T Function()? onError,
  }) => maybeMap<T?>(
    orElse: () => null,
    onInitial: onInitial,
    onLoading: onLoading,
    onSearching: onSearching,
    onLoadingMore: onLoadingMore,
    onSuccess: onSuccess,
    onError: onError,
  );
}
