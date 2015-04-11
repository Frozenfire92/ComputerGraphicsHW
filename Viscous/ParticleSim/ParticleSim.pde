boolean showWalls = true;
boolean isForce = false;
float collisionForce = 0.5;
float repellorStrength = 0.0075; //higher is stronger

ParticleSystem ps;

void setup() {
  size(640,640);
  ps = new ParticleSystem(new PVector(width/2,100));
  ps.addMedium(0.015, new PVector(46, 204, 113), width/4, (width/4)*3, height/4, height/2);
  ps.addMedium(0.05, new PVector(231, 76, 60), width/4, (width/4)*3, (height/8)*5, (height/8)*7);
  for (int i=0; i<100; i++)
  {
    ps.addParticle();
  }
}

void draw() {
  
  background(0);
  stroke(255);
  if (showWalls){
    line(0,600, 640,600); //Bottom Wall
    line(0,40, 640,40);  //Top Wall
    line(40,0, 40,640); //Left Wall
    line(600,0, 600,640); //Right Wall
  }
  ps.run();
}


