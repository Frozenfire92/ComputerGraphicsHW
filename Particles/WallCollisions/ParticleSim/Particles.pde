// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 
class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector location) {
    origin = location.get();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }

  void run() {
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
