# Legal Sathi — app architecture

Feature-first layout with a layered interior. Every feature folder owns its
screens, its Cubit, its data access and its domain contract, so a feature can
be worked on, tested and deleted without spelunking.

```
lib/
├── main.dart → bootstrap.dart → app.dart
├── core/          # shared by every feature; knows nothing about them
└── <feature>/     # splash auth home templates documents signature payments ai_assistant profile
    ├── views/     # screens (route targets)
    ├── cubit/     # *_cubit.dart + *_state.dart   (Cubit only, never Bloc)
    ├── domain/    # entities/ repositories/ usecases/
    ├── data/      # models/ (DTOs) datasources/ repositories/ (impls)
    ├── widgets/   # feature-specific widgets
    └── di.dart    # get_it registrations for this feature
```

## Layer rules

| Rule | Why it matters |
|---|---|
| `views/ → cubit/ → domain/ → data/` is the only legal direction | A screen can never reach a database or an HTTP client |
| Views talk to Cubits only (`BlocBuilder` / `BlocListener` / `context.read`) | Swapping state management stays inside one layer |
| Cubits call **usecases**, never repositories directly | One operation per class; easy to test and to reuse across Cubits |
| `domain/` imports no `flutter/*` and no `dart:io` | Entities, enums and usecases stay unit-testable as plain Dart |
| DTOs (`*_dto.dart`) stop at the repository | A change in the backend payload never leaks into entities or widgets |
| Repositories return `Result<T>`, never throw | Failures are values (`Failure` subclasses) that states can carry |
| Data sources throw `AppException`; repositories map it via `Failure.from` | One translation point between transport and domain |
| A feature may import another feature's `domain/` and `widgets/` only | `auth/cubit/auth_cubit.dart` is the sole exception: it is the app-wide session, exposed at the root |
| Screens are provided their Cubit by the route, not by themselves | Navigation owns lifecycle; views stay constructor-injectable |

## State conventions

States are freezed classes. Use a **union** when the phases of a screen are
exclusive (`loading | ready | failure`); use a **single immutable object** when
fields compose independently (filters, form values, selection).

```dart
@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitial;
  const factory LoginState.submitting() = LoginSubmitting;
  const factory LoginState.success(AppUser user) = LoginSuccess;
  const factory LoginState.failure(Failure failure) = LoginFailureState;
}
```

Cubits follow one shape: validate → call one usecase → `fold` the `Result` →
emit. Guard every post-await `emit` with `isClosed`.

List screens expose a `viewState` getter returning `core`'s `ViewState` so
`StateView` can render loading / error / empty / data uniformly.

> freezed's generated base class is not `sealed`, so pattern-switching over a
> union state is not exhaustive to the analyzer — use the generated `when(...)`
> instead of `switch (state)`.

## Dependency injection

`core/di/injection_container.dart` is the composition root: core services
first, then each feature's `di.dart`, then the router (it needs `AuthCubit`).

| Lifetime | What |
|---|---|
| `singleton` | `PrefsService`, `SecureStorageService`, `Dio`, `AuthCubit`, `GoRouter` |
| `lazySingleton` | repositories, data sources, usecases, `MockSessionStore` |
| `factory` | screen Cubits |
| `factoryParam` | Cubits that need a route argument (signature, payment) |

## Navigation

`core/router/app_router.dart` holds the whole route table and the session
guard. `AuthCubit` is a singleton; the guard re-runs through
`GoRouterRefreshStream(auth.stream)`, so **no screen navigates on a session
change** — signing in, verifying email and signing out all redirect from one
place. Splash lives at `/splash` (not `/`) so the `StatefulShellRoute` can own
`/` for the bottom-nav tabs.

`/splash` is a **transient hold, not a destination**: the guard pins the user
there only while the session is `AuthUnknown`, and redirects away the moment it
resolves (`home`/`verify-email` when signed in, `login` when not). It is
therefore excluded from `_anonymousRoutes` on purpose — a route set that
contains `/splash` leaves a signed-out cold start parked on the brand screen
with no way forward.

| Route | Screen |
|---|---|
| `/splash` `/login` `/register` `/verify-email` | splash + auth |
| shell branches | `/home` `/templates` `/documents` `/profile` |
| `/templates/:slug` → `/document-builder/:slug` | detail → wizard |
| `/preview/:documentId` → `/signature/:documentId` | document flow |
| `/ai-assistant` `/profile/settings` `/profile/edit` | assistant, settings, edit profile |
| `/payment` `/payment/success` | mock checkout — registered, but no screen pushes them |

The detail and builder routes are keyed by **slug** because `/Templates/{slug}`
is the only detail lookup the API offers; the builder needs that same call to
learn the template's fields and its numeric id. Preview and signature are keyed
by the API's numeric `userDocumentId`.

Nothing navigates to `/payment` yet: the API has no payments controller, so
charging for a real document would be fiction. The feature is kept whole — mock
gateway, method selection, success screen — behind a door no screen opens.
`document.isPaid` is read from the API and displayed, never set by the app.

`/templates?category=3` is honoured by `TemplateListView`, which re-applies it
in `didUpdateWidget` because the shell keeps that state alive. The value is the
API's numeric category id.

## Backend: ASP.NET Core

A hosted ASP.NET Core Web API, source in a sibling folder of this Flutter
project:

```
LegalSathi/
├── LegalSaathi/               # src/LegalSaathi.Api — controllers and services;
│                              # database/ holds the SQL Server schema
└── legal_sathi/               # this app
```

| | |
|---|---|
| Base URL | `http://legalsaathi.runasp.net/api` — `AppConfig.baseUrl` |
| Contract | `/swagger/index.html` on the same host |
| Transport | **HTTP only**; the host does not terminate TLS |

Cleartext is therefore allowed on purpose for this one host, in
`android/app/src/main/res/xml/network_security_config.xml` and in the
`NSExceptionDomains` of `ios/Runner/Info.plist` and `macos/Runner/Info.plist`.
Moving to HTTPS means editing those three files as well as the base URL.

Every JSON endpoint wraps its payload in `ApiResponse<T>` —
`{success, statusCode, message, data, errors[], timestamp}` — and
`core/network/api_envelope.dart` is the only place that knows the shape. Two
quirks decide its API:

- Business failures arrive as **HTTP 400** with the text worth showing in
  `errors[0]` while `message` stays the generic `"Operation failed."` — except
  when the server uses `message` as a machine code (`"EmailNotVerified"`),
  which is carried as `AppException.code` instead.
- Model-binding failures come back as ASP.NET's `ProblemDetails`, where
  `errors` is a `{field: [messages]}` map rather than an array. That map is the
  only source of inline form errors; the envelope's flat array carries no field
  names.

Auth is JWT, and the session is born at verification rather than at
registration: `/Auth/register` returns **no** tokens, `/Auth/verify-email`
exchanges the emailed OTP for the token pair, and a login on an unverified
account is refused with the `EmailNotVerified` code. Access tokens live 15
minutes, refresh tokens 7 days and rotate on every use.
`TokenRefreshInterceptor` single-flights the exchange across concurrent 401s
and replays the original request; if the refresh fails it clears storage and
`AuthCubit` drops to the logged-out state. It deliberately posts **only** the
refresh token — sending the access token too makes the server resolve the user
without hydrating the stored token and reject the exchange.

`DioClient` builds the one shared Dio instance, carrying the auth, refresh and
logging interceptors. Mock data sources bypass it entirely.

| Flag (`--dart-define`) | Default | Gates |
|---|---|---|
| `BASE_URL` | `http://legalsaathi.runasp.net/api` | where Dio points; override it to run against a locally hosted copy |
| `USE_MOCK_API` | `false` | every feature **except payments** → bundled mock data sources |
| `ENV` | `dev` | label only, nothing branches on it |

Nothing has to be deployed from here and no secret ships in the client: the AI
assistant calls `POST /Ai/ask` like any other endpoint.

## Mock data (`USE_MOCK_API=true`, and payments always)

Mock data sources implement the **same abstract interfaces** as the `_dio` ones
and read Pakistani legal content from `assets/mock/*.json`:

- `templates.json` — 7 templates with bilingual guided questions, PKR prices,
  difficulty and lawyer credits; `categories.json` — the 4 categories they hang
  off
- `documents.json` `payments.json` `users.json` `ai_answers.json`
  `ai_quick_prompts.json`

They extend `core/mock/mock_data_source.dart` (asset cache, ~350 ms latency,
paging). Because bundled assets are read-only, anything the user creates lands
in `MockSessionStore` for the length of the run, so
builder → preview → signature → my documents behaves like a session.
`DocumentBuilderCubit` creates the draft on entry, `saveFieldValues` advances
`draft → in_progress` per step and `generateDocument` finishes it — My
Documents silently refreshes when the tab re-attaches, so a generated document
appears without a pull. `home` has no data source of its own:
`HomeRepositoryImpl` composes the template and document repositories.

Payments are mocked in **both** modes. The API has no payments controller, so
`payments/di.dart` registers `PaymentRemoteDataSourceMock` unconditionally
rather than switching on `USE_MOCK_API`.

Demo credentials, seeded in `users.json` and prefilled on the login screen only
while `USE_MOCK_API=true`:

| Input | Result |
|---|---|
| `demo@legalsathi.pk` / `demo1234` | signs in |
| `pending@legalsathi.pk` / `demo1234` | refused with `EmailNotVerified` until the OTP is entered |
| `error@legalsathi.pk` / anything | forced 503 — exercises the retry path |
| verification code | `123456` |

## Localisation and RTL

`easy_localization` with `assets/translations/{en-US,ur-PK}.json` (232 leaf keys
each, kept at exact parity — a key missing from the active locale renders as its
own dotted path on screen, which is how gaps are spotted). Keys are
**dot-separated** (`templates.estimated_time`) — easy_localization splits nested
lookups on `.`, not `:`. Named args use `{count}`, `{minutes}`.

- Urdu switches the type scale and line height in `AppTheme.light(isUrdu: …)`,
  which `app.dart` recomputes from `context.locale`
- Layout must stay mirrorable: `EdgeInsetsDirectional`,
  `AlignmentDirectional`, `MarginSymmetric` — never raw left/right
- Widgets pick a bilingual entity field with `context.languageCode` and
  `entity.name(languageCode)`

`intl`'s `TextDirection` clashes with Flutter's; `context_x.dart` handles the
RTL check so widgets don't have to import both.

## Adding a feature

1. Create the folders: `views/ cubit/ domain/{entities,repositories,usecases}
   data/{models,datasources,repositories} widgets/ di.dart`
2. Entity + repository interface + usecase in `domain/`
3. `*_dto.dart` (freezed + `JsonSerializable`) with a `toEntity()` extension
4. Abstract `*_remote_data_source.dart`, then `*_remote_data_source_dio.dart`
   (real REST, unwrapping through `ApiEnvelope`) and
   `*_remote_data_source_mock.dart`; pick between them in `di.dart` on
   `AppConfig.useMockApi`
5. `*_repository_impl.dart` returning `Result<T>` via `Failure.from`
6. `*_state.dart` + `*_cubit.dart`, registered in the feature's `di.dart`
7. Route in `app_router.dart`, screen in `views/`, feature widgets

## Verifying changes

```bash
dart run build_runner build        # after editing any @freezed / DTO file
flutter analyze                    # must stay at "No issues found!"
flutter test
```

`build_runner` must run before `analyze`; missing `.freezed.dart` / `.g.dart`
part files otherwise surface as unrelated errors.

## Not built, and why

Everything the API exposes to an end user is wired. What is missing is missing
for a reason:

| Gap | Reason |
|---|---|
| Payments | No payments controller exists on the API. The mock gateway, method picker and success screen are intact but no screen pushes `/payment`, and `isPaid` is only ever read. Wiring a pay button would take money the backend cannot record. |
| Rendered PDF in-app | The preview screen shows the answered fields as text; `/Documents/{id}/download/pdf|docx` bytes go straight to the system share sheet via `share_plus`, which already offers save-to-Files, printing and every installed reader. No `pdf` / `printing` dependency. |
| Drawn signature | Signing is signer identity plus an OTP over `/Documents/{id}/signatures`. No canvas, no `signature` / `image_picker` dependency. |
| Lawyer review | `underLawyerReview` and `lawyerApproved` are displayed as statuses, but `LawyersController` (browse lawyers, request a review, my/assigned reviews, feedback) has no feature behind it. |
| Push notifications | `AppSettings.notificationsEnabled` is stored and nothing acts on it — the API has no push channel to subscribe to. |
| Admin | `AdminController` (stats, lawyer verification, audit logs, AI queries) is role-gated and has no screen; this app is the end-user client. |
| Offline cache | Every read hits the network or the bundled mocks. No Hive, no persisted lists — only the token pair and the locale are stored. |
