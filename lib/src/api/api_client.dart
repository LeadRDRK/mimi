import 'dart:convert';
import 'dart:async';
import 'dart:math' show pow;

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../core/version.dart';

/// The API client.
class ApiClient {
  /// Creates a new API client.
  ApiClient(this.host, [ApiClientOptions? _options])
  : options = _options ?? ApiClientOptions()
  {
    client = options.customClient ??
      RetryClient(http.Client(),
        retries: options.retries,
        when: options.retryWhen,
        whenError: options.retryWhenError,
        delay: options.retryDelay,
        onRetry: options.onRetry
      );
  }

  late final http.BaseClient client;

  /// The host to send requests to.
  String host;

  /// The authentication token.
  String? token;

  /// Options for the ApiClient client.
  final ApiClientOptions options;

  /// The scheme of the requests.
  /// 
  /// If `useHttps` is enabled then the scheme is `https`, else `http`.
  String get scheme => options.useHttps ? 'https' : 'http';

  /// Send an API request.
  Future<T> send<T>(String method, String path, {dynamic body, bool withToken = true}) async {
    body ??= {};
    if (withToken && token != null) body['i'] = token;

    final uri = Uri(
      scheme: scheme,
      host: host,
      path: 'api/$path'
    );

    final req = http.Request(method, uri);
    final userAgent = options.userAgent;
    if (userAgent != null) req.headers['User-Agent'] = userAgent;
    req.headers['Content-Type'] = 'application/json; charset=utf-8';
    req.headers['Accept'] = 'application/json';
    if (method == 'POST') req.body = jsonEncode(body);

    final res = await client.send(req);
    // Check for HTTP 204 No Content
    // Throws an error if the user expects data.
    if (res.statusCode == 204) return null as T;

    final resData = await res.stream.transform(utf8.decoder).join();
    final decoded = jsonDecode(resData);

    if ((res.statusCode ~/ 100) != 2) {
      throw ApiRequestError(res.statusCode, resData);
    }
    else {
      return decoded as T;
    }
  }

  /// Send a `POST` API request.
  Future<T> post<T>(String path, {dynamic body, bool withToken = true}) =>
      send<T>('POST', path, body: body, withToken: withToken);

  /// Closes the internal http client and cleans up any resources associated with it.
  void close() {
    client.close();
  }
}

/// The ApiClient's options.
class ApiClientOptions {
  /// Creates the options.
  /// 
  /// The options [retryWhen], [retryWhenError], [retryDelay] and [onRetry]
  /// are passed to the http.RetryClient constructor which
  /// controls how retries are handled.
  /// 
  /// If [customClient] is set, it will be used instead of the
  /// RetryClient.
  ApiClientOptions({
    this.userAgent = 'Mimi/$version Dart/3.0',
    this.useHttps = true,
    this.customClient,

    this.retries = 3,
    this.retryWhen = _defaultWhen,
    this.retryWhenError = _defaultWhenError,
    this.retryDelay = _defaultDelay,
    this.onRetry
  });

  /// The user agent to be used in requests.
  String? userAgent;

  /// Whether to use https or not.
  /// 
  /// Default: `true`
  bool useHttps;

  /// The custom http client.
  final http.BaseClient? customClient;

  /// The number of retries before the client actually fails.
  final int retries;

  /// When a retry should happen.
  final FutureOr<bool> Function(http.BaseResponse) retryWhen;

  /// When a retry should happen in case the request threw an error.
  final FutureOr<bool> Function(Object, StackTrace) retryWhenError;

  /// How long the client should wait until the next retry.
  final Duration Function(int retryCount) retryDelay;

  // Called before each retry.
  final FutureOr<void> Function(http.BaseRequest, http.BaseResponse?, int retryCount)? onRetry;
}

bool _defaultWhen(http.BaseResponse response) => response.statusCode == 503;

bool _defaultWhenError(Object error, StackTrace stackTrace) => false;

Duration _defaultDelay(int retryCount) =>
    const Duration(milliseconds: 500) * pow(1.5, retryCount);

class ApiRequestError implements Exception {
  /// The HTTP status code.
  final int statusCode;

  /// The details of this error from the response.
  late final ApiErrorDetails? details;

  ApiRequestError(this.statusCode, dynamic resData) {
    // There's always a chance that the instance is dead and/or
    // something else is throwing the error.
    try {
      details = ApiErrorDetails(resData as Map<String, dynamic>);
    }
    catch (e) {
      details = null;
    }
  }

  @override
  String toString() => 'ApiRequestError: server returned status code $statusCode';
}

class ApiErrorDetails {
  ApiErrorDetails(Map<String, dynamic> map)
  : message = map['message'] as String,
    code = map['code'] as String,
    id = map['id'] as String,
    kind = map['kind'] as String,
    info = map['info'];

  /// The error message.
  final String message;

  /// The error code.
	final String code;

  /// The error ID.
	final String id;

  /// The error kind.
	final String kind;

  /// The error info.
	final dynamic info;
}