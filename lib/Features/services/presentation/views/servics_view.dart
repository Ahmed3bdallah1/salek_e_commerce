import 'dart:convert';

import 'package:car_rentting/Features/auth/presentation/manager/current_user_provider.dart';
import 'package:car_rentting/Features/home/presentation/views/root_view.dart';
import 'package:car_rentting/Features/services/domain/use_cases/submit_order_use_case.dart';
import 'package:car_rentting/Ui/shared_widget/custom_text_field.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/functions/riverpod.dart';
import 'package:car_rentting/core/utils/colors.dart';
import 'package:car_rentting/main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Ui/shared_widget/custom_button.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../payment_view.dart';
import '../../../home/domain/entities/ad_entity.dart';
import '../../../home/presentation/views/widgets/silder_item_widget.dart';
import '../../data/models/service_model.dart';
import '../../domain/entities/service_entity.dart';
import '../manager/get_service_fields_provider.dart';
import '../widgets/google_maps_picker.dart';

// final paymentMethodProvider = StateProvider<PaymentMethod>((ref) {
//   return PaymentMethod.cash;
// });

class _ServiceView extends StatefulWidget {
  final ServiceEntity serviceEntity;
  final bool isFromOrder;

  const _ServiceView({required this.serviceEntity, this.isFromOrder = false});

  @override
  State<_ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<_ServiceView> {
  late final FormGroup formGroup;
  @override
  void initState() {
    formGroup = FormGroup({
      for (final field in widget.serviceEntity.serviceField!)
        "${field.id}": FormControl(
          validators: [
            if (field.typeValidation == 1) Validators.required,
          ],
          value: field.type == FieldsType.select
              ? field.fieldOptions
                  ?.firstWhereOrNull((element) =>
                      element.id.toString() == field.value.toString())
                  ?.id
              : field.value,
        ),
    });
    if (widget.isFromOrder) {
      formGroup.markAsDisabled();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Service".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ReactiveForm(
          formGroup: formGroup,
          child: ListView(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.serviceEntity.catNameAr,
                          overflow: TextOverflow.ellipsis,
                          style: AppFontStyle.black_24.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          widget.serviceEntity.catDescriptionAr,
                          overflow: TextOverflow.ellipsis,
                          style: AppFontStyle.black_16.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  if (!widget.isFromOrder)
                    Expanded(
                      child: PriceWidget(
                        widget.serviceEntity,
                        color: Colors.black,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 10.h),
              if (widget.serviceEntity.serviceMultiImages.isNotEmpty)
                Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 12),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        height: 200,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                      ),
                      items: widget.serviceEntity.serviceMultiImages
                          .map((e) => SliderItem(AdEntity(
                              navTo: '', adType: AdType.none, photo: e)))
                          .toList(),
                    )),
              SizedBox(height: 10.h),
              ...widget.serviceEntity.serviceField!
                  .map((e) => _handleServiceField(e, formGroup)),
              SizedBox(height: 10.h),
              if (!widget.isFromOrder)
                Consumer(builder: (context, ref, child) {
                  return ReactiveFormConsumer(builder: (context, form, child) {
                    return CustomFilledButton(
                      isValid: form.valid,
                      text: 'Submit'.tr,
                      textColor: Colors.white,
                      color: Colors.black,
                      isLoading: ref.watch(isLoadingProvider("submit_order")),
                      onPressed: () async {
                        if (formGroup.valid) {
                          ref
                              .read(isLoadingProvider("submit_order").notifier)
                              .state = true;
                          final res = await SubmitOrderUseCase(getIt()).call((
                            widget.serviceEntity.catId,
                            formGroup.value,
                          ));
                          ref
                              .read(isLoadingProvider("submit_order").notifier)
                              .state = false;
                          await res.fold((l) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(l.message),
                              backgroundColor: Colors.red,
                            ));
                          }, (r) async {
                            if (r != null) {
                              final payed = await _userPayedSuccessfully(r);
                              if (payed) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Order Submitted Successfully"),
                                  backgroundColor: Colors.green,
                                ));
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Error in Payment"),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Order Submitted Successfully"),
                                backgroundColor: Colors.green,
                              ));
                              Navigator.pop(context);
                            }
                          });
                        } else {
                          formGroup.markAllAsTouched();
                        }
                      },
                    );
                  });
                })
            ],
          ),
        ),
      ),
    );
  }

  Widget _handleServiceField(Field e, FormGroup formGroup) {
    if (e.id == 10) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            e.name ?? '',
            style: AppFontStyle.black_14,
          ),
          ...e.fieldOptions!.map(
            (z) => ReactiveRadioListTile<dynamic>(
              formControlName: "${e.id!}",
              value: z.id!,
              title: Row(
                children: [
                  Icon(
                    z.optionEn == "Cash"
                        ? Icons.money
                        : Icons.credit_card_outlined,
                    color: AppColors.primaryColorSALEK1,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    '${z.option}',
                    style: AppFontStyle.black_16,
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }

    return switch (e.type) {
      FieldsType.select ||
      FieldsType.text ||
      FieldsType.number =>
        CustomTextField(
          inputformatter: [
            if (e.type == FieldsType.number)
              FilteringTextInputFormatter.digitsOnly
          ],
          type: e.type == FieldsType.select
              ? TextFieldType.selectable
              : TextFieldType.text,
          items: e.type == FieldsType.select
              ? e.fieldOptions!
                  .map((e) => DropdownMenuItem(
                        value: e.id,
                        child: Text("${e.option}",
                            style: const TextStyle(
                                // color: AppColors.lightColor,
                                )),
                      ))
                  .toList()
              : null,
          formControlName: '${e.id}',
          inputType: e.type == FieldsType.number
              ? TextInputType.number
              : TextInputType.text,
          labelText: '${e.name}',
        ),
      FieldsType.map => Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: ReactiveFormConsumer(
            builder:
                (BuildContext context, FormGroup formGroup, Widget? child) {
              final val = formGroup.control('${e.id}').value;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${e.name}",
                    style: AppFontStyle.grey_14,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () async {
                      final latLong = formGroup.control('${e.id}').value == null
                          ? null
                          : LatLng(
                              jsonDecode(formGroup.control('${e.id}').value)[0],
                              jsonDecode(formGroup.control('${e.id}').value)[1],
                            );
                      if (latLong == null) {
                        return;
                      }
                      String googleUrl =
                          'https://www.google.com/maps/search/?api=1&query=${latLong.latitude},${latLong.longitude}';
                      await launchUrl(Uri.parse(googleUrl));
                    },
                    child: IgnorePointer(
                      ignoring: widget.isFromOrder,
                      child: GoogleMapsLocation(
                        isViewOnly: widget.isFromOrder,
                        removePadding: true,
                        location: formGroup.control('${e.id}').value == null
                            ? null
                            : LatLng(
                                jsonDecode(
                                    formGroup.control('${e.id}').value)[0],
                                jsonDecode(
                                    formGroup.control('${e.id}').value)[1],
                              ),
                        onPlacePicked: (data) {
                          formGroup.control('${e.id}').updateValue(jsonEncode(
                              [data.$1.latitude, data.$1.longitude, data.$2]));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (val != null && jsonDecode(val)[2] != null) ...[
                    Text(
                      "الموقع: ${jsonDecode(val)[2]}",
                      style: const TextStyle(color: AppColors.lightColor),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]
                ],
              );
            },
          ),
        ),
      FieldsType.date => InkWell(
          onTap: widget.isFromOrder
              ? null
              : () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  ).then((value) {
                    if (value != null) {
                      formGroup.control('${e.id}').updateValue(
                          value.toIso8601String().substring(0, 10));
                    }
                  });
                },
          child: IgnorePointer(
            ignoring: true,
            child: CustomTextField(
              ignore: true,
              formControlName: '${e.id}',
              inputType: TextInputType.text,
              labelText: '${e.name}',
            ),
          ),
        ),
      FieldsType.dateAndTime => InkWell(
          onTap: widget.isFromOrder
              ? null
              : () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  ).then((value) {
                    if (value != null) {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((time) {
                        if (time != null) {
                          formGroup.control('${e.id}').updateValue(
                              "${value.toIso8601String().substring(0, 10)} ${time.format(context)}");
                        }
                      });
                    }
                  });
                },
          child: IgnorePointer(
            ignoring: true,
            child: CustomTextField(
              ignore: true,
              formControlName: '${e.id}',
              inputType: TextInputType.text,
              labelText: '${e.name}',
            ),
          ),
        ),
      _ => const SizedBox(),
    };
  }
}

final isLoadingProvider =
    StateProvider.autoDispose.family<bool, dynamic>((ref, _) {
  return false;
});

class ServiceScreen extends ConsumerStatefulWidget {
  const ServiceScreen(this.id, {super.key, this.isFromOrder = false});

  final int id;
  final bool isFromOrder;

  @override
  ConsumerState<ServiceScreen> createState() => _ServiceScreenScreenState();
}

class _ServiceScreenScreenState extends ConsumerState<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    if (ref.watch(currentUserProvider) == null) {
      return const YouMustLoginPage();
    } else {
      final provider = widget.isFromOrder
          ? getPastServiceFieldsProvider(widget.id)
          : getServiceFieldsProvider(widget.id);
      return Scaffold(
        body: ref.watch(provider).customWhen(
              data: (data) {
                return _ServiceView(
                  serviceEntity: data,
                  isFromOrder: widget.isFromOrder,
                );
              },
              ref: ref,
              refreshable: provider.future,
            ),
      );
    }
  }
}

class PriceWidget extends StatelessWidget {
  const PriceWidget(
    this.entity, {
    super.key,
    this.color,
  });
  final ServiceEntity entity;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
            entity.serviceTotal != null
                ? entity.serviceTotal.toString() + "EGP".tr
                : "FREE",
            style: AppFontStyle.white_16
                .copyWith(color: color ?? const Color(0xffFFD700))),
        if (entity.servicePrice != null && entity.serviceTotal != null)
          Text(
            entity.servicePrice.toString() + "EGP".tr,
            style: AppFontStyle.white_12
                .copyWith(decoration: TextDecoration.lineThrough, color: color),
          ),
      ],
    );
  }
}

Future<bool> _userPayedSuccessfully(String url) async {
  final bool value = await showCupertinoModalBottomSheet<bool>(
        context: Get.context!,
        builder: (context) {
          return PaymentView(
            url,
          );
        },
        expand: false,
      ) ==
      true;
  Get.find<Indicator>().setIdle();
  return value;
}
