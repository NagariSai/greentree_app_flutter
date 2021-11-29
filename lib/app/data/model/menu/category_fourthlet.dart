class CategoryFourthlet<T, U, V, W> {
  final T title;
  final U icon;
  final V bgColor;
  final W shadowColor;

  CategoryFourthlet({this.title, this.icon, this.bgColor, this.shadowColor});

  T getTitle() {
    return title;
  }

  U getIcon() {
    return icon;
  }

  V getBgColorColor() {
    return bgColor;
  }

  W getShadowColor() {
    return shadowColor;
  }
}
