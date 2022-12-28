import 'package:get_it/get_it.dart';
import 'package:otobucks/global/Models/main_viewmodel.dart';


Future<void> $initGetIt(GetIt g, {String? environment}) async{
  g.registerLazySingleton<MainViewModel>(() => MainViewModel());
}