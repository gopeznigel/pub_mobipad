class TodoUtil {
  static bool checkProgress(List? list) {
    if (list == null || list.isEmpty) {
      return false;
    }

    var progress = true;

    for (var element in list) {
      progress = progress && element.done;
    }

    return progress;
  }
}
