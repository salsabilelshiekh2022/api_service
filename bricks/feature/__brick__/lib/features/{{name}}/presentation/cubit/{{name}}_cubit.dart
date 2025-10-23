import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

import '../../data/repos/{{name}}_repo.dart';
import '{{name}}_state.dart';

class {{name.pascalCase()}}Cubit extends Cubit<{{name.pascalCase()}}State> {
  final {{name.pascalCase()}}Repository _repository;

  {{name.pascalCase()}}Cubit(this._repository) : super(const {{name.pascalCase()}}State());


}
