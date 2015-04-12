// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 
class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  ArrayList<Medium> mediums;

  ParticleSystem(PVector location) {
    origin = location.get();
    particles = new ArrayList<Particle>();
    mediums = new ArrayList<Medium>();
  }
  
  void addMedium(float force, PVector mediumColor, float xMin, float xMax, float yMin, float yMax){
    mediums.add(new Medium(force, mediumColor, xMin, xMax, yMin, yMax));
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }

  void run() {
    for (int i = 0; i < mediums.size(); i++) {
      Medium m = mediums.get(i);
      m.run(particles);
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
    velocity = new PVector(random(-3,3),random(-2,2));
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

class Medium {
  float force;
  PVector mediumColor;
  float xMin, xMax;
  float yMin, yMax;
 
  Medium(float f, PVector c, float xMn, float xMx, float yMn, float yMx)
  {
    force = f;
    mediumColor = c;
    xMin = xMn;
    xMax = xMx;
    yMin = yMn;
    yMax = yMx;
  } 
  
  void run(ArrayList<Particle> particles) {
    update(particles);
    display();
  }

  // Check each particle if its in range
  void update(ArrayList<Particle> particles) {
    //Check each particle
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      PVector l = p.location.get();
      if (l.x >= xMin && l.x <= xMax &&
          l.y >= yMin && l.y <= yMax){
        PVector v = p.velocity.get();
        v.mult(-1);
        v.mult(force);
        p.velocity.add(v);      
      }
    }
  }

  // Method to display
  void display() { 
    fill(mediumColor.x, mediumColor.y, mediumColor.z);
    quad(xMin, yMin, xMin, yMax, xMax, yMax, xMax, yMin);
  }
}
