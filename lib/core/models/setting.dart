class Setting {
  Type type;
  dynamic value;

  Setting({this.type, this.value})
      : assert(value.runtimeType == type);

  Setting.clone(Setting setting)
      : this(type: setting.type, value: setting.value);

  @override
  String toString() {
    return this.type.toString() + '-' + this.value.toString();
  }
}