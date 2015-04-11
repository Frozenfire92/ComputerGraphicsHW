int tinySize = 10;
int largeSize = 500;
boolean isTiny = false;
boolean horizontal = true;

void setup() {
  int res;
  if (isTiny) res = tinySize;
  else res = largeSize;
  size(res,res);
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      float grey;
      if (horizontal) { 
        grey = (j/(width*1.0))*255; 
      }
      else {
        grey = (i/(width*1.0))*255;
      }
      color c = color((int)grey, (int)grey, (int)grey);
      set(i, j, c);
    }
  }
  String name;
  if (horizontal && isTiny) name = "horizontalConstantSm.png";
  else if (horizontal && !isTiny) name = "horizontalConstantLg.png";
  else if (!horizontal && isTiny) name = "verticalConstantSm.png";
  else name = "verticalConstantLg.png";
  save(name);
}

void draw() {
}
