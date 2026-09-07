import 'dart:typed_data';

import '../../../core/errors/failure.dart';
import '../../../core/errors/result.dart';
import '../../domain/entities/document_format.dart';
import '../../domain/entities/document_generation.dart';
import '../../domain/entities/document_language.dart';
import '../../domain/entities/legal_document.dart';
import '../../domain/repositories/document_repository.dart';
import '../datasources/document_remote_data_source.dart';
import '../models/document_detail_dto.dart';
import '../models/document_summary_dto.dart';
import '../models/generated_document_dto.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  DocumentRepositoryImpl(this._remote);

  final DocumentRemoteDataSource _remote;

  @override
  Future<Result<List<LegalDocument>>> getUserDocuments() async {
    try {
      return Success<List<LegalDocument>>(
        (await _remote.getUserDocuments())
            .map((DocumentSummaryDto dto) => dto.toEntity())
            .toList(growable: false),
      );
    } on Object catch (error) {
      return FailureResult<List<LegalDocument>>(Failure.from(error));
    }
  }

  @override
  Future<Result<LegalDocument>> getDocument(int documentId) async {
    try {
      return Success<LegalDocument>(
        (await _remote.getDocument(documentId)).toEntity(),
      );
    } on Object catch (error) {
      return FailureResult<LegalDocument>(Failure.from(error));
    }
  }

  @override
  Future<Result<LegalDocument>> createDocument({
    required int templateId,
    String? title,
    Map<String, String>? answers,
  }) async {
    try {
      return Success<LegalDocument>(
        (await _remote.createDocument(
          templateId: templateId,
          title: title,
          answers: answers,
        )).toEntity(),
      );
    } on Object catch (error) {
      return FailureResult<LegalDocument>(Failure.from(error));
    }
  }

  @override
  Future<Result<LegalDocument>> saveAnswers({
    required int documentId,
    required Map<String, String> answers,
  }) async {
    try {
      final LegalDocument saved = (await _remote.saveAnswers(
        documentId: documentId,
        answers: answers,
      )).toEntity();

      // The data source re-reads the document rather than trusting the update
      // call's status, so what came back is the only evidence the write landed.
      final List<String> notStored = answers.entries
          .where(
            (MapEntry<String, String> entry) =>
                saved.answers[entry.key] != entry.value,
          )
          .map((MapEntry<String, String> entry) => entry.key)
          .toList(growable: false);

      if (notStored.isNotEmpty) {
        return FailureResult<LegalDocument>(
          ServerFailure(
            message: 'These answers were not stored: ${notStored.join(', ')}.',
          ),
        );
      }
      return Success<LegalDocument>(saved);
    } on Object catch (error) {
      return FailureResult<LegalDocument>(Failure.from(error));
    }
  }

  @override
  Future<Result<DocumentGeneration>> generateDocument({
    required int documentId,
    required DocumentLanguage language,
  }) async {
    try {
      return Success<DocumentGeneration>(
        (await _remote.generateDocument(
          documentId: documentId,
          language: language.code,
        )).toEntity(),
      );
    } on Object catch (error) {
      return FailureResult<DocumentGeneration>(Failure.from(error));
    }
  }

  @override
  Future<Result<Uint8List>> download({
    required int documentId,
    required DocumentFormat format,
  }) async {
    try {
      return Success<Uint8List>(await _remote.download(documentId, format));
    } on Object catch (error) {
      return FailureResult<Uint8List>(Failure.from(error));
    }
  }
}
