class TimeModel {
  String time_12hr;
  String time_24hr;
  int t24hr;
  bool isSelected;
  bool isEnable;

  TimeModel(
      {required this.time_12hr,
      required this.time_24hr,
      required this.t24hr,
      required this.isSelected,
      required this.isEnable});
}


class TimeResModel {
  String time_12hr;
  bool isSelected;
  bool isEnable;
  TimeResModel(
      {
        required this.time_12hr,
        required this.isSelected,
        required this.isEnable
      });
}
