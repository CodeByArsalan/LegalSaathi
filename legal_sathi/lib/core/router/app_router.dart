import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../ai_assistant/cubit/ai_chat_cubit.dart';
import '../../ai_assistant/views/ai_chat_view.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../auth/cubit/auth_state.dart';
import '../../auth/cubit/login_cubit.dart';
import '../../auth/cubit/register_cubit.dart';
import '../../auth/cubit/verify_email_cubit.dart';
import '../../auth/domain/entities/app_user.dart';
import '../../auth/views/login_view.dart';
import '../../auth/views/register_view.dart';
import '../../auth/views/verify_email_view.dart';
import '../../documents/cubit/document_builder_cubit.dart';
import '../../documents/cubit/document_preview_cubit.dart';
import '../../documents/cubit/my_documents_cubit.dart';
import '../../documents/views/document_builder_view.dart';
import '../../documents/views/document_preview_view.dart';
import '../../documents/views/my_documents_view.dart';
import '../../home/cubit/home_cubit.dart';
import '../../home/views/home_view.dart';
import '../../home/views/main_shell_view.dart';
import '../../payments/cubit/payment_cubit.dart';
import '../../payments/views/payment_success_view.dart';
import '../../payments/views/payment_view.dart';
import '../../profile/cubit/edit_profile_cubit.dart';
import '../../profile/cubit/profile_cubit.dart';
import '../../profile/cubit/settings_cubit.dart';
import '../../profile/views/edit_profile_view.dart';
import '../../profile/views/profile_view.dart';
import '../../profile/views/settings_view.dart';
import '../../signature/cubit/signature_cubit.dart';
import '../../signature/views/signature_view.dart';
import '../../splash/cubit/splash_cubit.dart';
import '../../splash/views/splash_view.dart';
import '../../templates/cubit/template_detail_cubit.dart';
import '../../templates/cubit/template_list_cubit.dart';
import '../../templates/views/template_detail_view.dart';
import '../../templates/views/template_list_view.dart';
import '../di/injection_container.dart';
import 'route_names.dart';
import 'route_paths.dart';
import 'router_refresh.dart';

/// Every navigation decision in one place: route table plus the session guard.
abstract final class AppRouter {
  static final GetIt _sl = InjectionContainer.sl;

  /// Reachable without a session. Splash is deliberately absent: it is a
  /// transient hold, never a resting destination. Verification belongs here
  /// because it is what *creates* the session — `/Auth/register` returns no
  /// tokens, and the server refuses to log an unverified account in.
  static const Set<String> _anonymousRoutes = <String>{
    RoutePaths.login,
    RoutePaths.register,
    RoutePaths.verifyEmail,
  };

  static GoRouter create(AuthCubit auth) {
    return GoRouter(
      initialLocation: RoutePaths.splash,
      debugLogDiagnostics: kDebugMode,
      refreshListenable: GoRouterRefreshStream(auth.stream),
      redirect: (BuildContext context, GoRouterState state) =>
          sessionRedirect(auth.state, state.matchedLocation),
      routes: <RouteBase>[
        GoRoute(path: '/', redirect: (_, _) => RoutePaths.splash),
        GoRoute(
          path: RoutePaths.splash,
          name: RouteNames.splash,
          builder: (_, _) => BlocProvider<SplashCubit>(
            create: (_) => _sl<SplashCubit>(),
            child: const SplashView(),
          ),
        ),
        GoRoute(
          path: RoutePaths.login,
          name: RouteNames.login,
          builder: (_, _) => BlocProvider<LoginCubit>(
            create: (_) => _sl<LoginCubit>(),
            child: const LoginView(),
          ),
        ),
        GoRoute(
          path: RoutePaths.register,
          name: RouteNames.register,
          builder: (_, _) => BlocProvider<RegisterCubit>(
            create: (_) => _sl<RegisterCubit>(),
            child: const RegisterView(),
          ),
        ),
        GoRoute(
          path: RoutePaths.verifyEmail,
          name: RouteNames.verifyEmail,
          builder: (_, state) => BlocProvider<VerifyEmailCubit>(
            // Seeded from the query string: there is no session on this screen
            // yet, so the address to verify cannot come from a current user.
            create: (_) => _sl<VerifyEmailCubit>(
              param1: state.uri.queryParameters['email'] ?? '',
            ),
            child: const VerifyEmailView(),
          ),
        ),
        StatefulShellRoute.indexedStack(
          builder:
              (
                BuildContext context,
                GoRouterState state,
                StatefulNavigationShell navigationShell,
              ) => MainShellView(navigationShell: navigationShell),
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RoutePaths.home,
                  name: RouteNames.home,
                  builder: (_, _) => BlocProvider<HomeCubit>(
                    create: (_) => _sl<HomeCubit>(),
                    child: const HomeView(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RoutePaths.templates,
                  name: RouteNames.templates,
                  builder: (_, state) => BlocProvider<TemplateListCubit>(
                    create: (_) => _sl<TemplateListCubit>(),
                    child: TemplateListView(
                      initialCategoryId: int.tryParse(
                        state.uri.queryParameters['category'] ?? '',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RoutePaths.documents,
                  name: RouteNames.documents,
                  builder: (_, _) => BlocProvider<MyDocumentsCubit>(
                    create: (_) => _sl<MyDocumentsCubit>(),
                    child: const MyDocumentsView(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RoutePaths.profile,
                  name: RouteNames.profile,
                  builder: (_, _) => BlocProvider<ProfileCubit>(
                    create: (_) => _sl<ProfileCubit>(),
                    child: const ProfileView(),
                  ),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: RoutePaths.templateDetailPattern,
          name: RouteNames.templateDetail,
          builder: (_, state) => BlocProvider<TemplateDetailCubit>(
            create: (_) => _sl<TemplateDetailCubit>(),
            child: TemplateDetailView(slug: state.pathParameters['slug'] ?? ''),
          ),
        ),
        GoRoute(
          path: RoutePaths.documentBuilderPattern,
          name: RouteNames.documentBuilder,
          builder: (_, state) {
            final String slug = state.pathParameters['slug'] ?? '';
            return BlocProvider<DocumentBuilderCubit>(
              create: (_) => _sl<DocumentBuilderCubit>(param1: slug)..start(),
              child: DocumentBuilderView(slug: slug),
            );
          },
        ),
        GoRoute(
          path: RoutePaths.previewPattern,
          name: RouteNames.preview,
          builder: (_, state) {
            final int documentId =
                int.tryParse(state.pathParameters['documentId'] ?? '') ?? 0;
            return BlocProvider<DocumentPreviewCubit>(
              create: (_) =>
                  _sl<DocumentPreviewCubit>(param1: documentId)..load(),
              child: DocumentPreviewView(documentId: documentId),
            );
          },
        ),
        GoRoute(
          path: RoutePaths.signaturePattern,
          name: RouteNames.signature,
          builder: (_, state) {
            final int documentId =
                int.tryParse(state.pathParameters['documentId'] ?? '') ?? 0;
            return BlocProvider<SignatureCubit>(
              create: (_) => _sl<SignatureCubit>(param1: documentId),
              child: SignatureView(documentId: documentId),
            );
          },
        ),
        GoRoute(
          path: RoutePaths.payment,
          name: RouteNames.payment,
          builder: (_, state) {
            final String documentId =
                state.uri.queryParameters['documentId'] ?? '';
            final double amount =
                double.tryParse(state.uri.queryParameters['amount'] ?? '') ?? 0;
            return BlocProvider<PaymentCubit>(
              create: (_) =>
                  _sl<PaymentCubit>(param1: documentId, param2: amount),
              child: PaymentView(documentId: documentId, amount: amount),
            );
          },
        ),
        GoRoute(
          path: RoutePaths.paymentSuccess,
          name: RouteNames.paymentSuccess,
          builder: (_, state) => PaymentSuccessView(
            transactionId: state.uri.queryParameters['reference'] ?? '',
            amount:
                double.tryParse(state.uri.queryParameters['amount'] ?? '') ?? 0,
          ),
        ),
        GoRoute(
          path: RoutePaths.aiAssistant,
          name: RouteNames.aiAssistant,
          builder: (_, _) => BlocProvider<AiChatCubit>(
            create: (_) => _sl<AiChatCubit>()..loadQuickPrompts(),
            child: const AiChatView(),
          ),
        ),
        GoRoute(
          path: RoutePaths.settings,
          name: RouteNames.settings,
          builder: (_, _) => BlocProvider<SettingsCubit>(
            create: (_) => _sl<SettingsCubit>(),
            child: const SettingsView(),
          ),
        ),
        GoRoute(
          path: RoutePaths.editProfile,
          name: RouteNames.editProfile,
          builder: (_, _) => BlocProvider<EditProfileCubit>(
            create: (_) => _sl<EditProfileCubit>(),
            child: const EditProfileView(),
          ),
        ),
      ],
    );
  }

  /// Session guard, expressed as a pure decision so it is testable without a
  /// widget tree. `null` means "stay where you are".
  @visibleForTesting
  static String? sessionRedirect(AuthState session, String location) {
    return session.when<String?>(
      unknown: () {
        // Cold start: hold the brand screen until the stored session is read.
        return location == RoutePaths.splash ? null : RoutePaths.splash;
      },
      authenticated: (AppUser _) {
        // No unverified branch: the API issues tokens only for a verified
        // account, so an authenticated state is verified by construction.
        if (_anonymousRoutes.contains(location) ||
            location == RoutePaths.splash) {
          return RoutePaths.home;
        }
        return null;
      },
      unauthenticated: () {
        if (location == RoutePaths.splash) return RoutePaths.login;
        return _anonymousRoutes.contains(location) ? null : RoutePaths.login;
      },
    );
  }
}
