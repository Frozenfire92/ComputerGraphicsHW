boolean showWalls = true;
boolean isForce = false;
float collisionForce = 0.5;
float repellorStrength = 0.0075; //higher is stronger

ParticleSystem ps;

void setup() {
  size(640,640);
  ps = new ParticleSystem(new PVector(width/2,100));
  ps.addRepellor(new PVector(width/4, height/4), false);
  ps.addRepellor(new PVector((width/4)*3, height/4), false);
  ps.addRepellor(new PVector(width/2, (height/4)*3), true);
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


