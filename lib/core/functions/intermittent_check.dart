bool isInIntermittentSequence(int number) {
  if (number <= 0) {
    return false;
  }
  int count = 0;
  int i = 1;

  while (count < number) {
    if (i == number) {
      return true;
    }
    i += count % 2 == 0 ? 1 : 3;
    count++;
  }

  return false;
}
