import 'web_socket_client.dart';
import 'channel_connection.dart';
import 'stream_message.dart';

/// Manages channel connections and automatically reconnects them
/// whenever a new WebSocket connection is made.
class ChannelConnectionManager {
  ChannelConnectionManager(this.wsClient) {
    wsClient.onStateChange.listen((state) {
      if (state != WsClientState.connected) return;

      // Auto reconnect channels
      for (final c in connections.values) {
        _sendConnectPayload(c.channel, c.id, c.params);
      }
    });
  }

  /// The WebSocket client.
  final WebSocketClient wsClient;

  /// The connections mapped to their IDs.
  final Map<String, ChannelConnection> connections = {};

  int _idCounter = 0;

  void _sendConnectPayload(String channel, String id, Map<String, dynamic>? params) {
    wsClient.add(
      StreamMessagePayload('connect', {
        'channel': channel,
        'id': id,
        if (params != null) 'params': params
      })
    );
  }

  /// Connects to a channel.
  /// 
  /// If not specified, the ID will be created automatically
  /// using the internal counter.
  ChannelConnection connect(String channel, {String? id, Map<String, dynamic>? params}) {
    id ??= (_idCounter++).toString();
    _sendConnectPayload(channel, id, params);
    return connections[id] = ChannelConnection(this, channel, id, params);
  }

  /// Closes all channel connections.
  void closeAll() {
    for (final connection in connections.values) {
      connection.close();
    }
  }
}