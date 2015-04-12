int tinySize = 10;      // Resolution of tiny image
int largeSize = 500;    // Resolution of large image
boolean isTiny = false; // flag for tiny/large

int noiseDepth = 5; // Recursion depth
float val = 5;      // Value to add/remove brightness

boolean randomDepth = true; // Random recursion depth
boolean randomVal = true;   // Random brightness value
boolean randomColor = true; // Turn color on, randomly pick

void setup() {
  // Set resolution
  int res = (isTiny) ? tinySize : largeSize;
  size(res,res);
  
  // Set all pixels to color c
  float r = random(0,255);
  float g = random(0,255);
  float b = random(0,255);
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      color c;
      if (randomColor) c = color(r, g, b);
      else c = color(128, 128, 128);
      set(i, j, c);
    }
  }
  
  // Loop interesting noise
  if (randomDepth) noiseDepth = (int)random(1, 10);
  for (int i=0; i<noiseDepth; i++){
    interestingNoise();
  }
  
  // Save file
  String name;
  if (isTiny) name = "interestingNoiseSm.png";
  else name = "interestingNoiseLg.png";
  save(name);
}

// Create a 'noise' effect by drawing a line, increasing
// brightness to left of line, decreasing to right of line
void interestingNoise()
{
  // Randomly choose a line
  int pixelOneX = (int)random(0,width);
  int pixelOneY = (int)random(0,height);
  int pixelTwoX = (int)random(0,width);
  int pixelTwoY = (int)random(0,height);
  
  // If random val, set it
  if (randomVal) val = random(0,10);
  
  // Loop thru each pixel
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      // Determine if current pixel is left/right of line
      PVector p = new PVector(i,j);
      boolean left = isLeft(new PVector(pixelOneX, pixelOneY), new PVector(pixelTwoX, pixelTwoY), p);
      //print("x,y isLeft: "+i+","+j+" "+left+"\n"); //Debug
      // Get the current color and increase/decreate brightness
      color c = get(i,j);
      float red = red(c);
      float green = green(c);
      float blue = green(c);
      if (left) c = color(red + val, green + val, blue + val);
      else c = color(red - val, green - val, blue - val);
      set(i, j, c);
    }
  }
}

/* From http://stackoverflow.com/a/3461533/4330669
 * Uses the cross product to determine if point is left/right of line
 * a = line point 1, b = line point 2, c = point checking against
 * If the formula is equal to 0, the points are colinear.
 * If the line is horizontal, then this returns true if the point is above the line.
 */
boolean isLeft(PVector a, PVector b, PVector c){
  return ((b.x - a.x)*(c.y - a.y) - (b.y - a.y)*(c.x - a.x)) > 0;
}
