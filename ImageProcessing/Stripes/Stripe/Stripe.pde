int tinySize = 10;      // Resolution of tiny image
int largeSize = 500;    // Resolution of large image
boolean isTiny = false; // flag for tiny/large

boolean horizontal = true; // flag for horizontal/vertical bars

void setup() {
  // Set resolution
  int res = (isTiny) ? tinySize : largeSize;
  size(res,res);
  
  // Set all pixels to color c
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      color c = color(255, 255, 255);
      if (horizontal){
        if (j % 6 == 0) c = color(0,0,0);
      } else {
        if (i % 6 == 0) c = color(0,0,0);
      }
      set(i, j, c);
    }
  }
  
  // Save file
  String name;
  if (isTiny) name = "stripeSm.png";
  else name = "stripeLg.png";
  save(name);
}
