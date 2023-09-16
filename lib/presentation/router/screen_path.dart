enum ScreenId {
  list,
  edit,
}

extension ScreenPath on ScreenId {
  String get path {
    switch (this) {
      case ScreenId.list:
        return '/list';
      case ScreenId.edit:
        return '/edit/:id';
    }
  }
}

extension ScreenName on ScreenId {
  String get routeName {
    switch (this) {
      case ScreenId.list:
        return 'list';
      case ScreenId.edit:
        return 'edit';
    }
  }
}
