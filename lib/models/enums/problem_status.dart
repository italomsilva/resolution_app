enum ProblemStatus {
  open(0, "Aberto"),
  inProgress(1, "Em Andamento"),
  resolved(2, "Resolvido"),
  canceled(3, "Cancelado");

  final int value;
  final String textValue;

  const ProblemStatus(this.value, this.textValue);

  factory ProblemStatus.fromInt(int value) {
    switch (value) {
      case 0:
        return ProblemStatus.open;
      case 1:
        return ProblemStatus.inProgress;
      case 2:
        return ProblemStatus.resolved;
      case 3:
        return ProblemStatus.canceled;
      default:
        return ProblemStatus.open;
    }
  }

  factory ProblemStatus.fromText(String text) {
    switch (text.toLowerCase()) {
      case "aberto":
        return ProblemStatus.open;
      case "em andamento":
        return ProblemStatus.inProgress;
      case "resolvido":
        return ProblemStatus.resolved;
      case "cancelado":
        return ProblemStatus.canceled;
      default:
        return ProblemStatus.open;
    }
  }
}