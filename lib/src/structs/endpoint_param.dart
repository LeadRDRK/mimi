class EndpointParam {
  EndpointParam(Map<String, dynamic> map)
  : name = map['name'] as String,
    type = map['type'] as String;

  /// The name of the param.
  final String name;

  /// The type of the param.
  final String type;
}