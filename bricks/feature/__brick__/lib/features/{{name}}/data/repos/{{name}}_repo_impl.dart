import 'package:dartz/dartz.dart';
import 'package:elmohtaref/core/database/network/api_consumer.dart';

import '{{name}}_repo.dart';

class {{name.pascalCase()}}RepositoryImpl implements {{name.pascalCase()}}Repository {
  final ApiConsumer _apiConsumer;

 {{name.pascalCase()}}RepositoryImpl(this._apiConsumer);

 
}
