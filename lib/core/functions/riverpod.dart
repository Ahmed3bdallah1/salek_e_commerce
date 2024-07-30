import 'package:car_rentting/core/functions/responsive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Ui/shared_widget/custom_error_widget.dart';
import '../../Ui/shared_widget/image_or_svg.dart';

extension AsyncValueX<T> on AsyncValue<T> {
  Widget customWhen({
    required WidgetRef ref,
    required Refreshable<Future<T>> refreshable,
    bool skipLoadingOnReload = false,
    bool skipLoadingOnRefresh = false,
    bool skipError = false,
    required Widget Function(T data) data,
    Widget Function(Object error, StackTrace stackTrace)? error,
    Widget Function()? loading,
  }) {
    return when(
      loading: () => loading?.call() ?? const LoadingWidget(),
      skipLoadingOnReload: skipLoadingOnReload,
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      skipError: skipError,
      data: data,
      error: (err, trace) =>
          error?.call(error, trace) ??
          CustomErrorWidget(
            err: err,
            onRetry: () {
              return ref.refresh(refreshable);
            },
          ),
    );
  }
}
