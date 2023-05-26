class Player {
  String name;
  int height;
  int touchdownCatchCounter;
  int touchdownPassCounter;
  int safteyCounter;
  int interceptionCounter;
  int extraPointCatchCounter;
  int extreaPointPassCounter;
  Player({
    required this.name,
    required this.height,
    this.touchdownCatchCounter = 0,
    this.interceptionCounter = 0,
    this.safteyCounter = 0,
    this.touchdownPassCounter = 0,
    this.extraPointCatchCounter = 0,
    this.extreaPointPassCounter = 0,
  });
}
