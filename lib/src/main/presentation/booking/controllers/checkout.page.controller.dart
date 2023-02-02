import 'dart:convert';
import 'dart:io';

import 'package:bandeja/main/injection/injector.dart';
import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:bandeja/src/core/domain/padels/entities/promo.code.dart';
import 'package:bandeja/src/core/dto/wrapper.dto.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:bandeja/src/main/core/presentations/pages/payment.page.dart';
import 'package:bandeja/src/main/data/dto/padel.order.dto.dart';
import 'package:bandeja/src/main/domain/padels/repositories/i.padel.repository.dart';
import 'package:bandeja/src/main/presentation/booking/pages/my.booking.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_upayments/flutter_upayments.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/domain/authentication/repositories/i.user.repository.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/dto/response.dto.dart';
import '../../../../core/network/api.dart';
import '../../../domain/booking/repositories/i.booking.repository.dart';
import '../../padels/pages/booking.page.dart';

class CheckoutPageController extends GetxController {
  CheckoutPageController(this.padel, this.schedule, {this.givenOrder});

  RxBool loading = false.obs;
  RxBool promoCodeLoading = false.obs;
  RxnString promo = RxnString();
  final PadelModel padel;
  final PadelScheduleModel schedule;
  Rxn<PromoCodeModel> promoCode = Rxn<PromoCodeModel>();
  PadelOrderModel? givenOrder;
  Rxn<PadelOrderModel> padelOrder = Rxn<PadelOrderModel>(null);
  Rx<WrapperDto<PromoCodeModel>> promoCodeWrapper =
      Rx<WrapperDto<PromoCodeModel>>(EmptyState());
  Rx<WrapperDto<PadelOrderModel>> padelOrderWrapper =
      Rx<WrapperDto<PadelOrderModel>>(EmptyState());
  Rx<PadelOrderDto> padelOrderDto =
      Rx<PadelOrderDto>(PadelOrderDto.empty(padelId: -1, padelScheduleId: -1));
  final padelRepository = getIt<IPadelRepository>();
  final bookingRepository = getIt<IBookingRepository>();
  late paymentDetails paymentDetail;

  final userRepository = getIt<IUserRepository>();
  Rxn<UserModel> user = Rxn<UserModel>();

  @override
  void onInit() {
    loading.value = false;
    promoCodeLoading.value = false;
    loadUser();
    initPaymentDetails();
    super.onInit();
  }

  void loadUser() async {
    final result = await userRepository.loadUser();
    result?.fold((l) {}, (r) {
      user.value = r;
      updatePaymentDetails();
    });
  }

  void checkForPromoValidity(String? promo) async {
    if (promo == null) return;
    promoCodeLoading.value = true;
    promoCodeWrapper.value = LoadingState();
    final result =
        await padelRepository.checkPromo(promo: promo, padelId: padel.id);
    if (result == null) {
      promoCodeLoading.value = false;
      promoCodeWrapper.value = ErrorState(failure: UnExpectedFailure());
      AppSnackBar.failure(failure: UnExpectedFailure());
      return;
    }
    result.fold((l) {
      promoCodeLoading.value = false;
      promoCodeWrapper.value = ErrorState(failure: l);
      AppSnackBar.failure(failure: l);
    }, (r) {
      promoCode.value = r;
      promoCodeWrapper.value = LoadedState(value: r);
      padelOrderDto.value.promoCode = r.code;
      padelOrderDto.value.promoCodeId = r.id;
    });
  }

  void book(BuildContext context) async {
    if (padelOrder.value != null || givenOrder != null) {
      if (givenOrder != null) padelOrder.value = givenOrder;
      pay(context: context);
      return;
    }
    loading.value = true;
    promoCodeWrapper.value = LoadingState();
    if (promoCode.value != null) {
      padelOrderDto.value.promoCode = promoCode.value?.code;
      padelOrderDto.value.promoCodeId = promoCode.value?.id;
    }
    padelOrderDto.value.padelId = padel.id;
    padelOrderDto.value.padelScheduleId = schedule.id;
    final result = await bookingRepository.book(order: padelOrderDto.value);
    if (result == null) {
      loading.value = false;
      padelOrderWrapper.value = ErrorState(failure: UnExpectedFailure());
      AppSnackBar.failure(failure: UnExpectedFailure());
      return;
    }
    result.fold((l) {
      loading.value = false;
      promoCodeWrapper.value = ErrorState(failure: l);
      AppSnackBar.failure(failure: l);
    }, (r) async {
      padelOrder.value = r;
      padelOrderWrapper.value = LoadedState(value: r);
      pay(context: context);
    });
  }

  void pay({required BuildContext context}) async {
    updatePaymentDetails();
    //Get.to(() => PaymentPage(order: padelOrder.value!, padel: padel));
    RequestPayment(context, paymentDetail, onPaymentSuccess, onPaymentFailure);
  }

  void onPaymentFailure(isSuccess, transactionDetails, message) async {
    //print(transactionDetails.toString());
    await Get.off(BookingPage(
      padel: padel,
      order: padelOrder.value!,
    ));
    await Get.off(const MyBookingPage());
  }

  void onPaymentSuccess(isSuccess, data, message) async {
    //print(data['PaymentID']);
    loading.value = true;
    final result = await bookingRepository.notifyPayment(data: data);
    if (result == null) {
      loading.value = false;
      AppSnackBar.failure(failure: UnExpectedFailure());
      return;
    }
    result.fold((l) {
      loading.value = false;
      AppSnackBar.failure(failure: l);
    }, (r) async {
      if (padelOrder.value == null) return;
      await Get.off(PaymentPage(
        padel: padel,
        order: r,
      ));
      await Get.off(const MyBookingPage());
    });
  }

  void updatePaymentDetails() {
    if (user.value != null) {
      paymentDetail.customerFName = user.value?.fullName;
      paymentDetail.customerEmail = user.value?.emailAddress;
      paymentDetail.customerMobile = user.value?.phoneNumber;
    }
    paymentDetail.reference = padelOrder.value?.id.toString();
    paymentDetail.orderId = padelOrder.value?.barCode ?? '';
    paymentDetail.totalPrice = padelOrder.value?.amount.toString() ?? '0';
  }

  void initPaymentDetails() {
    paymentDetail = paymentDetails(
      merchantId: dotenv.env[
              '${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_MARCHANT_ID'] ??
          '',
      username: dotenv.env[
              '${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_USER_NAME'] ??
          '',
      password: dotenv
              .env['${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_PASSWORD'] ??
          '',
      apiKey: dotenv
              .env['${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_API_KEY'] ??
          '',
      currencyCode: dotenv.env[
              '${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_CURRENCY_CODE'] ??
          '',
      successUrl: dotenv.env[
              '${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_SUCCESS_URL'] ??
          '',
      errorUrl: dotenv.env[
              '${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_ERROR_URL'] ??
          '',
      testMode: dotenv.env[
              '${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_TEST_MODE'] ??
          '',
      paymentGateway: "knet",
      // whitelabled: "true",
      productTitle:
          '${padel.name} reservation for ${DateFormat('EEE, MMM d h:mm a').format(schedule.startTime)}',
      productName: padel.name,
      productPrice: schedule.price.toString(),
      productQty: "1",
      notifyURL: dotenv.env[
              '${(!Api.isProduction()) ? 'TEST_' : ''}PAYMENT_NOTIFY_URL'] ??
          '',
      customerFName: user.value?.fullName,
      customerEmail: user.value?.emailAddress,
      customerMobile: user.value?.phoneNumber,
      orderId: padelOrder.value?.barCode ?? '',
      reference: padelOrder.value?.id.toString(),
      totalPrice: padelOrder.value?.amount.toString() ?? '0',
    );
  }
}
