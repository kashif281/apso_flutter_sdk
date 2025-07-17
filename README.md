
# Apso Flutter SDK

A Dart/Flutter SDK clone of `@apso/sdk` for seamless backend CRUD operations.

## Features

- Fluent entity query builder
- Advanced filters with operators (e.g., \$gt, \$in, \$eq)
- Pagination, field selection, and sorting
- CRUD operations (getOne, create, update, delete)
- Retry logic with interceptors
- Dio-based HTTP client

## Installation

```yaml
dependencies:
  apso_flutter_sdk:
    git:
      url: https://github.com/yourusername/apso_flutter_sdk.git
```

## Usage

```dart
final client = ApsoClient(baseUrl: 'https://api.example.com', apiKey: 'YOUR_API_KEY');

final users = await client.entity('users')
    .where({'status': {'\$eq': 'active'}})
    .limit(10)
    .get();
```

## License

MIT
