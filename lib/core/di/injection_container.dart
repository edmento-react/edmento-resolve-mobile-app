import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:edmentoresolve/core/data/storage/storage_util.dart';
import 'package:edmentoresolve/features/notifications/data/repositories/mock_notifications_repository.dart';
import 'package:edmentoresolve/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:edmentoresolve/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:edmentoresolve/features/shared/data/datasources/communication_remote_data_source.dart';
import 'package:edmentoresolve/features/shared/data/datasources/tasks_remote_data_source.dart';
import 'package:edmentoresolve/features/shared/data/repositories/communication_repository_impl.dart';
import 'package:edmentoresolve/features/shared/data/repositories/tasks_repository_impl.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/communication_repository.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/tasks_repository.dart';
import 'package:get_it/get_it.dart';

import '../../features/authentication/data/datasources/auth_local_data_source.dart';
import '../../features/authentication/data/datasources/auth_local_data_source_impl.dart';
import '../../features/authentication/data/datasources/auth_remote_data_source.dart';
import '../../features/authentication/data/datasources/auth_remote_data_source_impl.dart';
import '../../features/authentication/data/repositories/auth_repository_impl.dart';
import '../../features/authentication/domain/repositories/auth_repository.dart';
import '../../features/authentication/domain/usecases/login_usecase.dart';
import '../../features/authentication/domain/usecases/logout_usecase.dart';
import '../../features/authentication/domain/usecases/new_password_usecase.dart';
import '../../features/authentication/domain/usecases/send_forgot_password_otp_usecase.dart';
import '../../features/authentication/domain/usecases/verify_otp_usecase.dart';
import '../../features/authentication/presentation/bloc/auth_bloc.dart';
import '../../features/authentication/presentation/bloc/login_cubit.dart';
import '../../features/authentication/presentation/bloc/role_cubit.dart';
import '../data/database/database_service.dart';
import '../data/network/api_client.dart';
import '../data/network/network_info.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // ---------------- Core ----------------
  // Connectivity + NetworkInfo
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  // Storage (one facade). Initialize eagerly so sync getters are safe.
  final storage = await StorageService.init();
  sl.registerSingleton<StorageService>(storage);

  // ApiClient (depends on StorageService & NetworkInfo)
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(sl<StorageService>(), sl<NetworkInfo>()),
  );

  // Preload auth header from storage
  await sl<ApiClient>().initializeAuthHeaders();

  // Single Dio for all repositories/services
  sl.registerLazySingleton<Dio>(() => sl<ApiClient>().dio);

  // Database
  final db = await DatabaseService.getInstance();
  sl.registerLazySingleton<DatabaseService>(() => db);

  // ---------------- Auth Feature ----------------
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl(), sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton<SendForgotPasswordOtpUseCase>(
    () => SendForgotPasswordOtpUseCase(sl()),
  );
  sl.registerLazySingleton<VerifyOtpUsecase>(() => VerifyOtpUsecase(sl()));
  sl.registerLazySingleton<NewPasswordUsecase>(() => NewPasswordUsecase(sl()));

  // BLoCs / Cubits
  sl.registerFactory(
    () =>
        AuthBloc(loginUseCase: sl(), logoutUseCase: sl(), authRepository: sl()),
  );
  sl.registerFactory<LoginCubit>(() => LoginCubit());
  sl.registerFactory<RoleResolverCubit>(
    () => RoleResolverCubit(sl<StorageService>()),
  );

  sl.registerFactory<NotificationsCubit>(
    () => NotificationsCubit(sl<INotificationsRepository>()),
  );

  sl.registerLazySingleton<INotificationsRepository>(
    () => MockNotificationsRepository(),
  );
  // sl.registerLazySingleton<INotificationsRepository>(() => NotificationsApiRepository(dioClient));

  // ---------------- Shared Features ----------------
  // Communication Data sources
  sl.registerLazySingleton<ICommunicationRemoteDataSource>(
    () => CommunicationRemoteDataSource(),
  );

  // Communication Repository
  sl.registerLazySingleton<ICommunicationRepository>(
    () => CommunicationRepositoryImpl(
      remoteDataSource: sl<ICommunicationRemoteDataSource>(),
    ),
  );

  // Tasks Data sources
  sl.registerLazySingleton<ITasksRemoteDataSource>(
    () => TasksRemoteDataSource(),
  );

  // Tasks Repository
  sl.registerLazySingleton<ITasksRepository>(
    () => TasksRepositoryImpl(remoteDataSource: sl<ITasksRemoteDataSource>()),
  );

  // ---------------- Future features ----------------
  // Add other feature DI here…
}
