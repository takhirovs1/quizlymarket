enum Status {
  initial,
  loading,
  searching,
  loadingMore,
  success,
  error;

  bool get isInitial => this == .initial;
  bool get isLoading => this == .loading;
  bool get isSearching => this == .searching;
  bool get isLoadingMore => this == .loadingMore;
  bool get isSuccess => this == .success;
  bool get isError => this == .error;

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
