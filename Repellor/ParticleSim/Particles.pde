// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 
class ParticleSystem {
  ArrayList<Particle> particles;
  ArrayList<Repellor> repellors;
  PVector origin;

  ParticleSystem(PVector location) {
    origin = location.get();
    particles = new ArrayList<Particle>();
    repellors = new ArrayList<Repellor>();
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }
  
  void addRepellor(PVector loc, boolean move) {
    repellors.add(new Repellor(loc, move)); 
  }

  void run() {
    for (int i = repellors.size()-1; i>=0; i--) {
      Repellor r = repellors.get(i);
      r.run(particles);
    }
    
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
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
  
  void addForce(PVector v){
    velocity.add(v);
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

class Repellor{
  PVector location;
  float forceRadius = 150;
  float radius = 50;
  boolean moving = false;
  boolean moveRight = true;

  Repellor(PVector l, boolean m) {
    location = l.get();
    moving = m;
  }

  void run(ArrayList<Particle> particles) {
    update(particles);
    display();
  }

  // move & Check each particle if its in range
  void update(ArrayList<Particle> particles) {
    if (moving){
      if (location.x <= width/6) moveRight = true;
      if (location.x >= (width/6)*5) moveRight = false;
      
      if (moveRight) location.x += 1;
      else location.x -= 1;
    }
    //Check each particle
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      float dist = PVector.dist(p.location, location);
      if (dist <= forceRadius/2)
      {
        PVector force = location.get();
        force.add(p.location.get());
        float invDistSq = 1 / (dist);
        force.mult(invDistSq * repellorStrength);
        p.addForce(force);
      }
    }
  }

  // Method to display
  void display() {
    stroke(255, 0);
    
    fill(255, 200);
    ellipse(location.x,location.y,forceRadius,forceRadius);
    
    fill(41, 128, 185, 150);
    ellipse(location.x,location.y,radius,radius);
  }
}
