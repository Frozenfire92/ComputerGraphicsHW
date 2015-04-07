// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 
class ParticleSystem {
  ArrayList<Particle> particles;
  ArrayList<Attractor> attractors;
  PVector origin;

  ParticleSystem(PVector location) {
    origin = location.get();
    particles = new ArrayList<Particle>();
    attractors = new ArrayList<Attractor>();
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }
  
  void addAttractor() {
    attractors.add(new Attractor(new PVector(width/2, height/2))); 
  }

  void run() {
    for (int i = attractors.size()-1; i>=0; i--) {
      Attractor a = attractors.get(i);
      a.run();
    }
    
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
//      if (p.isDead()) {
//        particles.remove(i);
//      }
    }
  }
}

// A simple Particle class
class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0,0.01); //Gravity
    velocity = new PVector(random(-1,1),random(-2,0));
    location = l.get();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update location
  void update() {
    wallCheck();
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    stroke(255, 200);
    fill(random(0,255),random(0,255),random(0,255));
    ellipse(location.x,location.y,8,8);
  }
  
  void wallCheck(){
    if (location.y >= 600)
    {
      if (isForce) velocity.add(new PVector(0, -collisionForce));
      else velocity.set(velocity.x, -velocity.y);
    } 
    else if (location.y <= 40)
    {
      if (isForce) velocity.add(new PVector(0, collisionForce));
      else velocity.set(velocity.x, -velocity.y);
    }
    else if (location.x <= 40)
    {
      if (isForce) velocity.add(new PVector(collisionForce, 0));
      else velocity.set(-velocity.x, velocity.y);
    }
    else if (location.x >= 600)
    {
      if (isForce) velocity.add(new PVector(-collisionForce, 0));
      else velocity.set(-velocity.x, velocity.y);
    }
  }
  
  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}

class Attractor{
  PVector location;
  float forceRadius = 120;
  float radius = 50;

  Attractor(PVector l) {
    location = l.get();
  }

  void run() {
    //update();
    display();
  }

  // Method to update location
  void update() {

  }

  // Method to display
  void display() {
    stroke(255, 0);
    
    fill(255, 5);
    ellipse(location.x,location.y,forceRadius,forceRadius);
    
    fill(41, 128, 185, 100);
    ellipse(location.x,location.y,radius,radius);
  }
}
