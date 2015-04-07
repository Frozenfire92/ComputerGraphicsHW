boolean showWalls = true;
boolean isForce = false;
float collisionForce = 0.5;

ParticleSystem ps;

void setup() {
  size(640,640);
  ps = new ParticleSystem(new PVector(width/2,100));
  for (int i=0; i<100; i++)
  {
    ps.addParticle();
    ps.addAttractor();
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


