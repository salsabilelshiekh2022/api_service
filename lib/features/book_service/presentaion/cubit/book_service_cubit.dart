import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:elmohtaref/core/extensions/translation_extensions.dart';
import 'package:elmohtaref/features/book_service/data/models/report_type_enum.dart';
import 'package:elmohtaref/features/book_service/data/models/time_slots_model.dart';
import 'package:elmohtaref/features/book_service/data/repos/book_service_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/network/failure.dart';
import '../../../../core/utils/user_cache_service.dart';
import '../../data/models/book_service_request_model.dart';
import '../../data/models/car_type_model.dart';

part 'book_service_state.dart';

class BookServiceCubit extends Cubit<BookServiceState> {
  BookServiceCubit(this._bookServiceRepo) : super(const BookServiceState());
  final BookServiceRepo _bookServiceRepo;

  // Form controllers
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  // Service booking data
  int carModelId = 0;
  int carBrandId = 0;
  int carModelYear = 0;
  String dateTimeoFBooking = "";
  late int serviceId;
  late ReportTypeEnum reportType;

  // Images storage
  List<File> selectedImages = [];

  /// Update selected images from PhotoSection
  void updateSelectedImages(List<File> images) {
    selectedImages = List.from(images);
    // No need to emit state since we're not tracking hasImages in state
  }

  /// Get image paths as strings for the API request
  List<String> get imagePaths =>
      selectedImages.map((file) => file.path).toList();

  /// Clear all selected images
  void clearImages() {
    selectedImages.clear();
  }

  /// Remove specific image by index
  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }

  /// Add new image to selected images
  void addImage(File image) {
    selectedImages.add(image);
  }

  /// Get current images count
  int get imagesCount => selectedImages.length;

  /// Check if has images
  bool get hasImages => selectedImages.isNotEmpty;

  Future<void> bookService({required BuildContext context}) async {
    emit(state.copyWith(status: BookServiceStatus.loading));
    bool isValidate = validateForm(context: context);
    if (!isValidate) return;
    final failureOrSuccess = await _bookServiceRepo.bookService(
      bookServiceModel: BookServiceRequestModel(
        carModelId: carModelId,
        carModelYear: carModelYear,
        dateTimeoFBooking: dateTimeoFBooking,
        serviceId: serviceId,
        reportType: reportType,
        fullName: nameController.text,
        phone: phoneController.text,
        notes: notesController.text,
        images: imagePaths.isNotEmpty
            ? imagePaths
            : null, // Send image paths or null
      ),
    );

    failureOrSuccess.fold(
      (failure) => emit(
          state.copyWith(failure: failure, status: BookServiceStatus.failure)),
      (message) => emit(
        state.copyWith(message: message, status: BookServiceStatus.success),
      ),
    );
  }

  Future<void> getCarTypes() async {
    emit(state.copyWith(status: BookServiceStatus.getCarTypesLoading));
    final failureOrSuccess = await _bookServiceRepo.getCarTypes();
    failureOrSuccess.fold(
      (failure) => emit(state.copyWith(
          failure: failure, status: BookServiceStatus.getCarTypesFailure)),
      (carTypesResponse) => emit(
        state.copyWith(
            carTypesResponse: carTypesResponse,
            status: BookServiceStatus.getCarTypesSuccess),
      ),
    );
  }

  Future<void> getCarModels({required int id}) async {
    emit(state.copyWith(status: BookServiceStatus.getCarModelsLoading));
    final result = await _bookServiceRepo.getCarModels(id: id);
    result.fold(
      (failure) => emit(state.copyWith(
          failure: failure, status: BookServiceStatus.getCarModelsFailure)),
      (carTypesResponse) => emit(
        state.copyWith(
            carModelsResponse: carTypesResponse,
            status: BookServiceStatus.getCarModelsSuccess),
      ),
    );
  }

  Future<void> getTimeAvalibilty({required int serviceId, String? day}) async {
    emit(state.copyWith(status: BookServiceStatus.getTimeAvalabilityLoading));

    final result = await _bookServiceRepo.getTimeAvilability(
        serviceId: serviceId,
        day: day ?? DateFormat('yyyy-MM-dd').format(DateTime.now()));
    result.fold(
      (failure) => emit(state.copyWith(
          status: BookServiceStatus.getTimeAvalabilityFailure,
          failure: failure)),
      (success) => emit(
        state.copyWith(
            status: BookServiceStatus.getTimeAvalabiltySuccess,
            timeSlotsResponse: success),
      ),
    );
  }

  /// Clear all form data and reset cubit state
  void resetForm() {
    phoneController.clear();
    nameController.clear();
    notesController.clear();
    carModelId = 0;
    carBrandId = 0;
    carModelYear = 0;
    selectedImages.clear();
    emit(const BookServiceState());
  }

  bool validateForm({required BuildContext context}) {
    if (UserCacheService().currentUser == null &&
        phoneController.text.isEmpty) {
      emit(state.copyWith(
          failure: Failure(message: context.pleaseEnterName),
          status: BookServiceStatus.failure));
      return false;
    } else if (UserCacheService().currentUser == null &&
        nameController.text.isEmpty) {
      emit(state.copyWith(
          failure: Failure(message: context.pleaseEnterPhone),
          status: BookServiceStatus.failure));
      return false;
    }
    if (carBrandId == 0) {
      emit(state.copyWith(
          failure: Failure(message: context.pleaseEnterCarBrand),
          status: BookServiceStatus.failure));
      return false;
    }
    if (carModelId == 0) {
      emit(state.copyWith(
          failure: Failure(message: context.pleaseEnterCarModel),
          status: BookServiceStatus.failure));
      return false;
    }
    if (carModelYear == 0) {
      emit(state.copyWith(
          failure: Failure(message: context.pleaseEnterCarYear),
          status: BookServiceStatus.failure));
      return false;
    }
    if (dateTimeoFBooking.isEmpty) {
      emit(state.copyWith(
          failure: Failure(message: context.pleaseEnterServiceDate),
          status: BookServiceStatus.failure));
      return false;
    }
    return true;
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    nameController.dispose();
    notesController.dispose();
    return super.close();
  }
}
