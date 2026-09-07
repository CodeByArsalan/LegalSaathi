import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:legal_sathi/core/errors/app_exception.dart';
import 'package:legal_sathi/core/errors/failure.dart';
import 'package:legal_sathi/core/errors/result.dart';
import 'package:legal_sathi/documents/domain/entities/document_format.dart';
import 'package:legal_sathi/documents/domain/entities/document_generation.dart';
import 'package:legal_sathi/documents/domain/entities/document_language.dart';
import 'package:legal_sathi/documents/domain/entities/document_status.dart';
import 'package:legal_sathi/documents/domain/entities/legal_document.dart';
import 'package:legal_sathi/documents/domain/repositories/document_repository.dart';
import 'package:legal_sathi/documents/domain/usecases/get_user_documents.dart';
import 'package:legal_sathi/profile/cubit/profile_cubit.dart';
import 'package:legal_sathi/profile/cubit/profile_state.dart';
import 'package:legal_sathi/profile/domain/entities/profile_stats.dart';

/// The counts behind the profile header. The API has no stats endpoint, so they
/// are counted from `GET /Documents` — which is also what keeps these numbers
/// agreeing with the Documents tab.
void main() {
  LegalDocument document(int id, DocumentStatus status) => LegalDocument(
    id: id,
    guid: 'guid-$id',
    templateId: 1,
    templateTitleEn: 'General Affidavit',
    templateTitleUr: 'عمومی بیان حلفی',
    title: 'Document $id',
    status: status,
    isPaid: false,
    createdAt: DateTime.utc(2026, 9, 7),
  );

  group('ProfileStats.of', () {
    test('an account with nothing in it counts zeroes', () {
      expect(ProfileStats.of(const <LegalDocument>[]), const ProfileStats());
    });

    test('a draft is a document but neither signed nor completed', () {
      final ProfileStats stats = ProfileStats.of(<LegalDocument>[
        document(1, DocumentStatus.draft),
      ]);

      expect(stats.documents, 1);
      expect(stats.signed, isZero);
      expect(stats.completed, isZero);
    });

    test(
      'completed counts everything past draft, signed only what is signed',
      () {
        final ProfileStats stats = ProfileStats.of(<LegalDocument>[
          document(1, DocumentStatus.draft),
          document(2, DocumentStatus.completed),
          document(3, DocumentStatus.pendingSignature),
          document(4, DocumentStatus.signed),
          document(5, DocumentStatus.underLawyerReview),
          document(6, DocumentStatus.lawyerApproved),
          document(7, DocumentStatus.archived),
        ]);

        expect(stats.documents, 7);
        // Signed and lawyer-approved are the statuses with a signature on file.
        expect(stats.signed, 2);
        // A rendered file exists for all six that are past draft.
        expect(stats.completed, 6);
      },
    );
  });

  group('ProfileCubit', () {
    late _FakeDocuments documents;
    late ProfileCubit cubit;

    setUp(() {
      documents = _FakeDocuments();
      cubit = ProfileCubit(GetUserDocumentsUseCase(documents));
    });

    tearDown(() async => cubit.close());

    test('it starts loading, so the header shows no counts yet', () {
      expect(cubit.state, isA<ProfileLoading>());
      expect(cubit.state.stats, isNull);
    });

    test('a read answer becomes counts', () async {
      documents.result = Success<List<LegalDocument>>(<LegalDocument>[
        document(1, DocumentStatus.signed),
        document(2, DocumentStatus.draft),
      ]);

      await cubit.load();

      expect(cubit.state.stats?.documents, 2);
      expect(cubit.state.stats?.signed, 1);
      expect(cubit.state.stats?.completed, 1);
    });

    test('a failed read is a failure, not a page full of zeroes', () async {
      documents.result = FailureResult<List<LegalDocument>>(
        Failure.from(const AppException('boom', kind: AppExceptionKind.server)),
      );

      await cubit.load();

      expect(cubit.state, isA<ProfileFailure>());
      expect(cubit.state.failure, isA<ServerFailure>());
      expect(cubit.state.stats, isNull);
    });

    test('reloading after an edit goes back through loading', () async {
      documents.result = Success<List<LegalDocument>>(<LegalDocument>[
        document(1, DocumentStatus.signed),
      ]);
      await cubit.load();

      final List<ProfileState> states = <ProfileState>[];
      cubit.stream.listen(states.add);
      await cubit.load();
      await pumpEventQueue();

      expect(states.first, isA<ProfileLoading>());
      expect(cubit.state.stats?.documents, 1);
    });
  });
}

/// Only the list is ever read; the rest of the repository is the documents
/// feature's business.
final class _FakeDocuments implements DocumentRepository {
  Result<List<LegalDocument>> result = Success<List<LegalDocument>>(
    const <LegalDocument>[],
  );

  @override
  Future<Result<List<LegalDocument>>> getUserDocuments() async => result;

  @override
  Future<Result<LegalDocument>> getDocument(int documentId) =>
      throw UnimplementedError();

  @override
  Future<Result<LegalDocument>> createDocument({
    required int templateId,
    String? title,
    Map<String, String>? answers,
  }) => throw UnimplementedError();

  @override
  Future<Result<LegalDocument>> saveAnswers({
    required int documentId,
    required Map<String, String> answers,
  }) => throw UnimplementedError();

  @override
  Future<Result<DocumentGeneration>> generateDocument({
    required int documentId,
    required DocumentLanguage language,
  }) => throw UnimplementedError();

  @override
  Future<Result<Uint8List>> download({
    required int documentId,
    required DocumentFormat format,
  }) => throw UnimplementedError();
}
