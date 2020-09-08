enum Status {
  Deactive,
  Active,
  Blocked,
  Pending,
  Completed,
  Supervised,
  UnSupervised,
  Processing,
  On,
  Off,
  Seen,
  Unseen,
  Unknown,
}

extension StatusExt on Status {
  int getIndex() => this.index;
}
