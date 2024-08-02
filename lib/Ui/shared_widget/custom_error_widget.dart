import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/api_service.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, this.onRetry, required this.err});

  final Object err;
  final void Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    final msg =
        err is Failure ? (err as Failure).message : GeneralError().message;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              msg,
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null)
              TextButton(
                  onPressed: onRetry!,
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.black,
                  ))
          ],
        ),
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, this.onRetry, this.msg = 'No data found'});

  final String msg;
  final void Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(msg, style: TextStyle(fontSize: 20.sp, color: Colors.black)),
          if (onRetry != null)
            TextButton(
                onPressed: onRetry!,
                child: const Icon(
                  Icons.refresh,
                  color: Colors.black,
                ))
        ],
      ),
    );
  }
}
