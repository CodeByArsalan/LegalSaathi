# Legal Sathi

Bilingual (Urdu / English) legal document builder for Pakistan — hackathon
project by Nexvora Technologies.

Pick a legal template (rent agreement, affidavit, power of attorney, …),
answer a guided step-by-step wizard, generate the document, sign it with an
OTP-verified e-signature, and ask the built-in AI legal assistant questions in
Urdu or English.

## Stack

- Flutter (clean architecture, Cubit-only state, get_it DI, go_router,
  easy_localization) — see [ARCHITECTURE.md](ARCHITECTURE.md)
- ASP.NET Core REST API at `http://legalsaathi.runasp.net/api` for auth,
  templates, documents, signatures and the AI assistant
- No keys or credentials are compiled into the app: everything that needs a
  secret lives on the server

The API is HTTP-only — the host does not terminate TLS — so the Android network
security config and the iOS/macOS ATS exception domains allow cleartext for
`legalsaathi.runasp.net` specifically. Point `BASE_URL` at an HTTPS host and
those exceptions can go.

## Running the app

```bash
flutter pub get
flutter run
```

That talks to the hosted API. Registration emails a one-time code; login is
refused until that code is entered, which is the server's rule rather than the
app's.

Switches (all optional, all `--dart-define`):

| Flag | Default | Purpose |
|---|---|---|
| `BASE_URL` | `http://legalsaathi.runasp.net/api` | any `/api` root, e.g. a locally hosted copy at `http://localhost:5000/api` |
| `USE_MOCK_API` | `false` | `true` → run entirely on the bundled mock data, no server needed |
| `ENV` | `dev` | shown on the settings screen next to the version |

Mock mode (`--dart-define=USE_MOCK_API=true`) runs every feature on the bundled
data, with no server needed; its demo credentials are `demo@legalsathi.pk` /
`demo1234`, OTP `123456`. Payments are mocked in **both** modes: the API has no
payments controller, so there is no gateway to talk to, and no screen offers a
pay button.

## Tests

```bash
flutter analyze
flutter test
```

Pure unit tests cover the session guard, cubits (login, verify email, document
builder, AI chat, profile, edit profile), repositories, the wire models against
payloads captured from the live API (`test/fixtures/`), and the markdown and
context-packing helpers behind the assistant.

Models are generated with freezed and json_serializable; after changing an
entity or DTO run:

```bash
dart run build_runner build
```
