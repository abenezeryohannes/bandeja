import 'package:bandeja/src/core/presentation/widgets/app.snack.bar.dart';
import 'package:bandeja/src/main/data/dto/padel.order.dto.dart';
import 'package:get/get.dart';

import '../../../../../main/injection/injector.dart';
import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/dto/wrapper.dto.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/booking/i.owner.booking.repository.dart';

class OwnerQrModalController extends GetxController {
  OwnerQrModalController({required this.qrCode});
  String qrCode;
  final repository = getIt<IOwnerBookingRepository>();

  var order = Rx<WrapperDto<PadelOrderModel>>(EmptyState());

  @override
  void onInit() {
    getOrder();
    super.onInit();
  }

  getOrder({int? page}) async {
    order.value = WrapperDto.loadingState();
    final result = await repository.getBookingFromQrCode(qrCode: qrCode);
    if (result == null) {
      order.value = WrapperDto.errorState(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        order.value = WrapperDto.errorState(failure: l);
      }, (r) {
        order.value = WrapperDto<PadelOrderModel>.loadedState(value: r);
      });
    }
  }

  editOrder(PadelOrderModel orderModel) async {
    order.value = WrapperDto.loadingState();
    PadelOrderDto orderDto = PadelOrderDto.fromModel(orderModel);
    orderDto.status = 'confirmed';
    final result = await repository.editBooking(orderDto: orderDto);
    if (result == null) {
      AppSnackBar.failure(failure: UnExpectedFailure());
    } else {
      result.fold((l) {
        order.value = WrapperDto.errorState(failure: l);
        AppSnackBar.failure(failure: l);
      }, (r) {
        order.value = WrapperDto.loadedState(value: r);
        AppSnackBar.success(message: "The order has been confirmed!");
        Get.back<String?>(result: 'saved');
      });
    }
  }
}
