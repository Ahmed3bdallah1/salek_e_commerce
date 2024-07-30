// ignore_for_file: prefer_const_constructors

import 'package:car_rentting/Features/orders/presentation/View/widgets/order_item_widget.dart';
import 'package:car_rentting/Features/orders/presentation/manager/get_orders_provider.dart';
import 'package:car_rentting/Features/services/presentation/views/servics_view.dart';
import 'package:car_rentting/Ui/shared_widget/custom_error_widget.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/functions/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class OrdersView extends ConsumerWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'.tr),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(getOrdersProvider.future),
        child: Consumer(builder: (context, ref, child) {
          final orders = ref.watch(getOrdersProvider);
          return orders.customWhen(
            loading: () {
              return ListView.builder(
                itemCount: 5,
                itemBuilder: (ctx, i) => InkWell(
                  child: OrderItemShimmer(),
                ),
              );
            },
            data: (orders) {
              if (orders.isEmpty) {
                return EmptyWidget(
                  onRetry: () {
                    return ref.refresh(getOrdersProvider.future);
                  },
                );
              } else {
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (ctx, i) => InkWell(
                      onTap: () async {
                        Get.to(() => ServiceScreen(
                              orders[i].id,
                              isFromOrder: true,
                            ));
                      },
                      child: OrderItem(orders[i])),
                );
              }
            },
            refreshable: getOrdersProvider.future,
            ref: ref,
          );
        }),
      ),
    );
  }
}
