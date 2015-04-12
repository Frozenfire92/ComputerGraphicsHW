int tinySize = 10;      // Resolution of tiny image
int largeSize = 500;    // Resolution of large image
boolean isTiny = false; // flag for tiny/large
float sigma = 150;
boolean randomSigma = true;
int res;
boolean noisySigma = true;

void setup() {
  // Set resolution
  res = (isTiny) ? tinySize : largeSize;
  size(res,res);
  
  // Set sigma if random
  if (randomSigma){
    sigma = random(0,1);
    sigma = sigma * res;
  }
  
  // Set all pixels color
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      float p = gauss(new PVector(i,j));
      color c = color((int)255*p, (int)255*p, (int)255*p);
      set(i, j, c);
    }
  }
  
  // Save file
  String name;
  if (isTiny) name = "gaussianSm.png";
  else name = "gaussianLg.png";
  save(name);
}

float gauss(PVector p) {
  // If noisy, set sigma
  if (noisySigma){
    sigma = random(0,1);
    sigma = sigma * res;
  }
  // exponential Gaussian function
  PVector t = p.get();
  t.sub(new PVector(width/2, height/2));
  float top = t.magSq();
  top = -top;
  top = top / (2 * (sigma * sigma));
  return exp(top);
}
