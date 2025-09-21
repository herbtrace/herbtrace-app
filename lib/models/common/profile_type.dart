enum ProfileType {
  farmer,
  wildCollector,
  processor,
  laboratory,
  manufacturer,
  packer,
  transport,
  storage;

  String toShortString() {
    switch (this) {
      case ProfileType.farmer:
        return 'farmer';
      case ProfileType.wildCollector:
        return 'wild_collector';
      case ProfileType.processor:
        return 'processor';
      case ProfileType.laboratory:
        return 'laboratory';
      case ProfileType.manufacturer:
        return 'manufacturer';
      case ProfileType.packer:
        return 'packer';
      case ProfileType.storage:
        return 'storage';
      case ProfileType.transport:
        return 'transport';
    }
  }

  static ProfileType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'farmer':
        return ProfileType.farmer;
      case 'wild_collector':
        return ProfileType.wildCollector;
      case 'processor':
        return ProfileType.processor;
      case 'laboratory':
        return ProfileType.laboratory;
      case 'manufacturer':
        return ProfileType.manufacturer;
      case 'packer':
        return ProfileType.packer;
      case 'storage':
        return ProfileType.storage;
      default:
        print('Invalid ProfileType string: $value');
        throw ArgumentError('Invalid ProfileType string: $value');
    }
  }
}
