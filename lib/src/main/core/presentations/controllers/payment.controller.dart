import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/core/presentation/widgets/show.error.dart';
import 'package:bandeja/src/main/data/dto/padel.order.dto.dart';
import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/booking/repositories/i.booking.repository.dart';
// import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

class PaymentController extends GetxController {
  PaymentController({required this.order, required this.padel});

  final PadelOrderModel order;
  final PadelModel padel;

  Rxn<PadelOrderModel> orderSuccess = Rxn<PadelOrderModel>();

  final bookingRepository = getIt<IBookingRepository>();
  RxBool loading = false.obs;

  void onPaymentSuccess() async {
    loading.value = true;
    final result = await bookingRepository.editBooking(
        order: PadelOrderDto.fromModel(order));
    if (result == null) {
      loading.value = false;
      ShowError(failure: UnExpectedFailure());
    }
    result?.fold((l) {
      ShowError(failure: l);
      loading.value = false;
    }, (r) {
      orderSuccess.value = r;
      loading.value = false;
    });
  }
}


// OLD WAY
/**
// class PaymentController extends GetxController {
//   void getPayment(
//       {required double invoiceAmount,
//       Function? onSuccess,
//       Function? onFailure}) async {
//     var request =
//         MFInitiatePaymentRequest(invoiceAmount, MFCurrencyISO.KUWAIT_KWD);

//     MFSDK.initiatePayment(request, MFAPILanguage.EN,
//         (MFResult<MFInitiatePaymentResponse> result) {
//       if (result.isSuccess()) {
//         print(result.response?.toJson().toString() ??
//             'Payment initiation is successfull but response null !');
//         if (onSuccess != null) onSuccess(result.response);
//       } else {
//         print(result.error?.message ??
//             'Payment initiation has failed but response null !');
//         if (onFailure != null) onFailure(result.error);
//       }
//     });
//   }

//   void initiateSession(
//       {required MFPaymentCardView mfPaymentCardView,
//       Function? onSuccess,
//       Function? onFailure}) {
//     //var request = MFInitiateSessionRequest("12332212");
//     //MFSDK.initiateSession(request, (MFResult<MFInitiateSessionResponse> result) => {

//     MFSDK.initiateSession(null, (MFResult<MFInitiateSessionResponse> result) {
//       if (result.isSuccess()) {
//         mfPaymentCardView.load(result.response!,
//             onCardBinChanged: (String bin) => {print("Bin: $bin")});
//         if (onSuccess != null) onSuccess(result.response);
//       } else {
//         print("Response: ${result.error!.toJson().toString().toString()}");
//         if (onFailure != null) onFailure(result.error);
//       }
//     });
//   }

//   void payNow(
//       {required MFPaymentCardView mfPaymentCardView,
//       Function? onSuccess,
//       Function? onFailure}) {
//     var request = MFExecutePaymentRequest.constructor(0.100);

//     mfPaymentCardView.pay(request, MFAPILanguage.EN,
//         (String invoiceId, MFResult<MFPaymentStatusResponse> result) {
//       if (result.isSuccess()) {
//         print("Response: ${result.response!.toJson().toString()}");
//         if (onSuccess != null) onSuccess(result.response);
//       } else {
//         print("Error: ${result.error!.toJson().toString()}");
//         if (onFailure != null) onFailure(result.error);
//       }
//     });
//   }
// }
 */