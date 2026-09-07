import 'package:get_it/get_it.dart';

import '../../core/mock/mock_session_store.dart';
import 'cubit/payment_cubit.dart';
import 'data/datasources/payment_remote_data_source.dart';
import 'data/datasources/payment_remote_data_source_mock.dart';
import 'data/repositories/payment_repository_impl.dart';
import 'domain/repositories/payment_repository.dart';
import 'domain/usecases/check_payment_status.dart';
import 'domain/usecases/initiate_payment.dart';

void configurePayments(GetIt getIt) {
  getIt
    // Always mocked: the API has no payments controller, so there is no live
    // source to switch to. `USE_MOCK_API=false` runs everything else against
    // the real backend and leaves this feature on its demo gateway.
    ..registerLazySingleton<PaymentRemoteDataSource>(
      () => PaymentRemoteDataSourceMock(getIt<MockSessionStore>()),
    )
    ..registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(getIt()),
    )
    ..registerLazySingleton<InitiatePaymentUseCase>(
      () => InitiatePaymentUseCase(getIt()),
    )
    ..registerLazySingleton<CheckPaymentStatusUseCase>(
      () => CheckPaymentStatusUseCase(getIt()),
    )
    ..registerFactoryParam<PaymentCubit, String, double?>(
      (String documentId, double? amount) => PaymentCubit(
        initiatePayment: getIt(),
        documentId: documentId,
        amount: amount ?? 0,
      ),
    );
}
