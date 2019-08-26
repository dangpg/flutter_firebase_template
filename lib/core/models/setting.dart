class Setting {
  Type type;
  dynamic value;

  Setting({this.type, this.value})
      : assert(value.runtimeType == type);
}