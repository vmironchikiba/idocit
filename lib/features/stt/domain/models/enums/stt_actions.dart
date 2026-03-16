enum SttActions { stop, start, cancel }

extension SttActionsToBool on SttActions {
  bool toBool() => this == SttActions.start;
}
