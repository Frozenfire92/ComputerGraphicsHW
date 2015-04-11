int tinySize = 10;
int largeSize = 500;
boolean isTiny = false;

void setup() {
  int res;
  if (isTiny) res = tinySize;
  else res = largeSize;
  size(res,res);
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      int grey = (int)random(0,255);
      color c = color(grey, grey, grey);
      set(i, j, c);
    }
  }
  String name;
  if (isTiny) name = "noiseSm.png";
  else name = "noiseLg.png";
  save(name);
}
