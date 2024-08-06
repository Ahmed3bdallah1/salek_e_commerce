// ignore_for_file: prefer_const_constructors

import 'package:car_rentting/Features/orders/domain/entities/order_entity.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/app_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shimmer/shimmer.dart';

import '../../../../../Ui/shared_widget/cutom_stepper.dart';

class OrderItem extends StatelessWidget {
  final OrderEntity order;

  const OrderItem(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 0.5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              trailing: Text(intl.DateFormat.yMd().add_jm().format(order.date),
                  style: AppFontStyle.black_12),
              title: Text("#${order.id}",
                  style: AppFontStyle.black_18
                      .copyWith(fontWeight: FontWeight.bold)),
              subtitle: Text(
                order.service?.catNameAr??'',
              ),
            ),
            CustomStepperWidget(
              status: order.status ?? 0,
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItemShimmer extends StatelessWidget {
  const OrderItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 0.5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                trailing: Container(
                  width: 60,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                title: Container(
                  width: 80,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                subtitle: Container(
                  width: 120,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
