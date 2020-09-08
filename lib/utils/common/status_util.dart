import 'package:newsera/enums/status.dart';
import 'package:newsera/models/status_model.dart';

StatusModel getStatus(code) {
  if (Status.values.length > code) {
    return StatusModel(
        code: code, label: Status.values[code].toString().split(".")[1]);
  } else {
    return StatusModel(
        code: Status.Unknown.getIndex(),
        label: Status.Unknown.toString().split(".")[1]);
  }
}
