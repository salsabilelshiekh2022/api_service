
import 'package:equatable/equatable.dart';

enum {{name.pascalCase()}}StateStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
  refreshing,
}

class {{name.pascalCase()}}State extends Equatable {
  final {{name.pascalCase()}}StateStatus status;
 

  const {{name.pascalCase()}}State({
    this.status = {{name.pascalCase()}}StateStatus.initial,
   
  });

  {{name.pascalCase()}}State copyWith({
    {{name.pascalCase()}}StateStatus? status,
   
  }) {
    return {{name.pascalCase()}}State(
      status: status ?? this.status,
     
    );
  }

  // Convenience getters
  bool get isInitial => status == {{name.pascalCase()}}StateStatus.initial;
  bool get isLoading => status == {{name.pascalCase()}}StateStatus.loading;
  bool get isLoadingMore => status == {{name.pascalCase()}}StateStatus.loadingMore;
  bool get isSuccess => status == {{name.pascalCase()}}StateStatus.success;
  bool get isFailure => status == {{name.pascalCase()}}StateStatus.failure;
  bool get isRefreshing => status == {{name.pascalCase()}}StateStatus.refreshing;

 
 @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
 
}
