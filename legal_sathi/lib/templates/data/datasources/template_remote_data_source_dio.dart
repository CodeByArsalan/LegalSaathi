import 'package:dio/dio.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_envelope.dart';
import '../models/legal_template_dto.dart';
import '../models/template_category_dto.dart';
import 'template_remote_data_source.dart';

/// The template endpoints are anonymous, so nothing here needs the auth-skipping
/// option the pre-session auth calls use.
final class TemplateRemoteDataSourceDio implements TemplateRemoteDataSource {
  TemplateRemoteDataSourceDio(this._dio);

  final Dio _dio;

  @override
  Future<List<LegalTemplateDto>> getTemplates({
    int? categoryId,
    String? search,
  }) async {
    final String keyword = search?.trim() ?? '';
    final Response<dynamic> response = await _dio.get<dynamic>(
      ApiEndpoints.templates,
      queryParameters: <String, Object>{
        // A blank `search` is omitted rather than sent: the server reads an
        // empty keyword as "no filter", but sending it invites a future change
        // of mind on that route.
        if (keyword.isNotEmpty) 'search': keyword,
        'categoryId': ?categoryId,
      },
    );
    return ApiEnvelope.unwrapList<LegalTemplateDto>(
      response,
      LegalTemplateDto.fromJson,
    );
  }

  @override
  Future<List<TemplateCategoryDto>> getCategories() async {
    final Response<dynamic> response = await _dio.get<dynamic>(
      ApiEndpoints.templateCategories,
    );
    return ApiEnvelope.unwrapList<TemplateCategoryDto>(
      response,
      TemplateCategoryDto.fromJson,
    );
  }

  @override
  Future<LegalTemplateDto> getTemplateBySlug(String slug) async {
    // An unknown slug is a 400 carrying "Template with slug '…' not found." in
    // `errors`, despite the route advertising a 404 — so the message is what
    // reaches the user, not a not-found state inferred from the status.
    final Response<dynamic> response = await _dio.get<dynamic>(
      ApiEndpoints.templateBySlug(slug),
    );
    return ApiEnvelope.unwrapObject<LegalTemplateDto>(
      response,
      LegalTemplateDto.fromJson,
    );
  }
}
