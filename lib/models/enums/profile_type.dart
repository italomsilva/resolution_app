enum ProfileType {
  company(0),
  ngo(1),
  government(2),
  individual(3),
  unknown(-1);

  final int value;

  const ProfileType(this.value);

  factory ProfileType.fromInt(int value) {
    switch (value) {
      case 0:
        return ProfileType.company;
      case 1:
        return ProfileType.ngo;
      case 2:
        return ProfileType.government;
      case 3:
        return ProfileType.individual;
      default:
        return ProfileType.unknown;
    }
  }
}

