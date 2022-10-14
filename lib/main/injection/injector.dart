import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart';

final getIt = GetIt.instance;

const mmain = Environment('mmain');
const admin = Environment('admin');
const owner = Environment('owner');

@InjectableInit()
Future<GetIt> configureDependencies(final Environment env) =>
    $initGetIt(getIt, environment: env.name);
