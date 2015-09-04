void setup() {
  background(200);
  size(800, 600);
}

void draw() {
  stroke(0);
  strokeWeight(5);
  fill(255);
  ellipse(400,300,400,400);
  fill(0);
  ellipse(325,225,25,60);
  ellipse(475,225,25,60);
  arc(400,350,150,70,0,PI,CHORD);
}