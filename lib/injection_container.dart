import 'package:cleanarchitecture/features/products/data/datasource/products_local_datasource.dart';
import 'package:cleanarchitecture/features/products/data/repositories/products_repository.dart';
import 'package:cleanarchitecture/features/products/domain/repositories/products_repository.dart';
import 'package:cleanarchitecture/features/products/domain/usecases/get_products.dart';
import 'package:cleanarchitecture/features/products/domain/usecases/save_product.dart';
import 'package:cleanarchitecture/features/products/presentation/bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Products
  //Bloc
  sl.registerFactory(
    () => ProductsBloc(
      getProducts: sl(),
      saveProducts: sl(),
      inputConverter: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => SaveProducts(sl()));

  // Repository
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ProductsLocalDataSource>(
    () => ProductsLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //!External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
