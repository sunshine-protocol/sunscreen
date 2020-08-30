class Device {
  const Device({
    this.id,
    this.currentDevice = false,
  });
  final String id;
  final bool currentDevice;

  bool get isCurrentDevice => currentDevice;
  @override
  // ignore: hash_and_equals
  int get hashCode => id.hashCode;
}
