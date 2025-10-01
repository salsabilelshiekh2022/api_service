part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class SendOtpLoadingState extends AuthState {}

final class SendOtpSuccessState extends AuthState {
  final String message;
  const SendOtpSuccessState({required this.message});
}

final class SendOtpErrorState extends AuthState {
  final Failure failure;
  const SendOtpErrorState({required this.failure});
}

final class VerifyOtpLoadingState extends AuthState {}

final class VerifyOtpSuccessState extends AuthState {
  final UserModel userModel;
  const VerifyOtpSuccessState({required this.userModel});
}

final class VerifyOtpErrorState extends AuthState {
  final Failure failure;
  const VerifyOtpErrorState({required this.failure});
}

final class LogoutLoadingState extends AuthState {}

final class LogoutSuccessState extends AuthState {
  final String message;
  const LogoutSuccessState({required this.message});
}

final class LogoutErrorState extends AuthState {
  final Failure failure;
  const LogoutErrorState({required this.failure});
}

final class EditProfileLoadingState extends AuthState {}

final class EditProfileSuccessState extends AuthState {
  final UserModel userModel;
  const EditProfileSuccessState({required this.userModel});
}

final class EditProfileErrorState extends AuthState {
  final Failure failure;
  const EditProfileErrorState({required this.failure});
}

final class CheckPhoneLoadingState extends AuthState {}

final class CheckPhoneSuccessState extends AuthState {
  final String message;
  const CheckPhoneSuccessState({required this.message});
}

final class CheckPhoneErrorState extends AuthState {
  final Failure failure;
  const CheckPhoneErrorState({required this.failure});
}
