// ignore_for_file: prefer_const_constructors

import 'package:car_rentting/Features/categories/presentation/view/all_categories.dart';
import 'package:car_rentting/Features/chat/presentation/chat_screen.dart';
import 'package:car_rentting/Features/chat/presentation/managers/get_chat_provider.dart';
import 'package:car_rentting/Features/orders/presentation/View/widgets/order_item_widget.dart';
import 'package:car_rentting/Features/orders/presentation/manager/get_orders_provider.dart';
import 'package:car_rentting/Features/services/presentation/views/servics_view.dart';
import 'package:car_rentting/Ui/shared_widget/custom_error_widget.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/functions/riverpod.dart';
import 'package:car_rentting/core/utils/app_fonts.dart';
import 'package:car_rentting/core/utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class OrdersView extends ConsumerStatefulWidget {
  const OrdersView({super.key});

  @override
  ConsumerState<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends ConsumerState<OrdersView>
    with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this)
      ..addListener(() {
        ref.read(selectedTypeCategoryProvider.notifier).state =
            controller.index;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Orders'.tr),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            controller: controller,
            dividerColor: AppColors.primaryColorSALEK1,
            isScrollable: false,
            tabs: [
              Tab(
                child: SizedBox(
                  child: Center(
                    child: Text(
                      'Products'.tr,
                      style: AppFontStyle.black_18,
                    ),
                  ),
                ),
              ),
              Tab(
                child: SizedBox(
                  child: Center(
                    child: Text(
                      'Services'.tr,
                      style: AppFontStyle.black_18,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: List.generate(
            2,
            (index) => RefreshIndicator(
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
                              orders[i].status == 0
                                  ? Get.to(() => ServiceScreen(
                                        orders[i].id,
                                        isFromOrder: true,
                                      ))
                                  : Get.to(() => ChatPage(
                                        id: orders[i].id,
                                        isDisabled: orders[i].status == 3
                                            ? true
                                            : false,
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
          ),
        ));
  }
}
