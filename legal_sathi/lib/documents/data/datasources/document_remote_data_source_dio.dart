import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/network/api_envelope.dart';
import '../../domain/entities/document_format.dart';
import '../models/document_detail_dto.dart';
import '../models/document_summary_dto.dart';
import '../models/generated_document_dto.dart';
import 'document_remote_data_source.dart';

final class DocumentRemoteDataSourceDio implements DocumentRemoteDataSource {
  DocumentRemoteDataSourceDio(this._dio);

  final Dio _dio;

  @override
  Future<List<DocumentSummaryDto>> getUserDocuments() async {
    final Response<dynamic> response = await _dio.get<dynamic>(
      ApiEndpoints.documents,
    );
    return ApiEnvelope.unwrapList<DocumentSummaryDto>(
      response,
      DocumentSummaryDto.fromJson,
    );
  }

  @override
  Future<DocumentDetailDto> getDocument(int documentId) async {
    final Response<dynamic> response = await _dio.get<dynamic>(
      ApiEndpoints.documentById(documentId),
    );
    return ApiEnvelope.unwrapObject<DocumentDetailDto>(
      response,
      DocumentDetailDto.fromJson,
    );
  }

  @override
  Future<DocumentDetailDto> createDocument({
    required int templateId,
    String? title,
    Map<String, String>? answers,
  }) async {
    final String label = title?.trim() ?? '';
    final Response<dynamic> response = await _dio.post<dynamic>(
      ApiEndpoints.documents,
      data: <String, Object>{
        'templateId': templateId,
        if (label.isNotEmpty) 'title': label,
        if (answers != null && answers.isNotEmpty) 'formAnswers': answers,
      },
    );
    return ApiEnvelope.unwrapObject<DocumentDetailDto>(
      response,
      DocumentDetailDto.fromJson,
    );
  }

  @override
  Future<DocumentDetailDto> saveAnswers({
    required int documentId,
    required Map<String, String> answers,
  }) async {
    // `PUT /Documents/{id}/answers` answers 400 "Failed to update document
    // answers." and stores the answers anyway: the stored procedure writes the
    // row and then reports 0 rows affected. Its status is therefore no evidence
    // either way, so it is not read — the document is fetched again and the
    // repository compares what came back with what was sent. A genuine network
    // failure surfaces there too, because the re-read fails the same way.
    try {
      await _dio.put<dynamic>(
        ApiEndpoints.documentAnswers(documentId),
        data: <String, Object>{'formAnswers': answers},
      );
    } on DioException {
      // Ignored on purpose; see above.
    }
    return getDocument(documentId);
  }

  @override
  Future<GeneratedDocumentDto> generateDocument({
    required int documentId,
    required String language,
  }) async {
    final Response<dynamic> response = await _dio.post<dynamic>(
      ApiEndpoints.documentGenerate(documentId),
      data: <String, String>{'language': language},
    );
    return ApiEnvelope.unwrapObject<GeneratedDocumentDto>(
      response,
      GeneratedDocumentDto.fromJson,
    );
  }

  @override
  Future<Uint8List> download(int documentId, DocumentFormat format) async {
    final String path = switch (format) {
      DocumentFormat.pdf => ApiEndpoints.documentPdf(documentId),
      DocumentFormat.docx => ApiEndpoints.documentDocx(documentId),
    };

    // The file endpoints answer with a binary body, so the JSON `Accept` the
    // client sends by default is replaced rather than left to invite a 406.
    final Response<dynamic> response = await _dio.get<dynamic>(
      path,
      options: Options(
        responseType: ResponseType.bytes,
        headers: <String, String>{'Accept': '*/*'},
      ),
    );

    final Object? body = response.data;
    if (body is! Uint8List) {
      throw AppException(
        'The download did not return a file.',
        kind: AppExceptionKind.server,
        statusCode: response.statusCode,
      );
    }
    return body;
  }
}
