final int WIDTH=800;
final int HEIGHT=600;

//int buildingY = -140;
int[] buildingY = { -200, -320, -175, -240, -190, -210 };
int[] stopY = { 410, 400, 420, 415, 420, 380 };

void setup() {
  size(800,600);
  background(25);
}

void draw() {
  drawSky();
  drawMoon();
  drawMountains();
  drawGround();
  drawWater();
  drawBuildings();
}

void drawSky() {
  // Draw a fancy gradient for the night sky
  color bottomColor = 70;
  color topColor = 0;
  strokeWeight(1);
  for (int j = HEIGHT-1; j >= 0; j--) {
    float val = map(j, 0, HEIGHT-1, 1, 0);
    color c = lerpColor(bottomColor, topColor, val);
    stroke(c);
    line(0, j, WIDTH, j);
  }
}

void drawMoon() {
  color moonColor = color(200,200,150);
  stroke(moonColor);
  fill(moonColor);
  ellipse(600,200,60,60);
}

void drawMountains() {
  color darkGreen = color(0,50,0);
  color darkerGreen = color(0,40,0);
  stroke(darkerGreen);
  fill(darkerGreen);
  triangle(50, 500, 300, 375, 550, 500);
  stroke(darkGreen);
  fill(darkGreen);
  triangle(-200, 500, 150, 350, 400, 550);
}

void drawGround() {
  fill(0,65,11);
  rect(0, HEIGHT-150, WIDTH, HEIGHT-150);
}

void drawWater() {
  color waterColor = color(0,10,30);
  stroke(waterColor);
  fill(waterColor);
  ellipse(700,625,900,220);
}

void drawBuildings() {
  for (int i = 0; i < buildingY.length; i++) {
    if (buildingY[i] < stopY[i]) {
      buildingY[i]++;
    }
  }
  
  drawBuildingOne(-10,buildingY[0]);
  drawBuildingOne(120,buildingY[1]);
  drawBuildingOne(60,buildingY[2]);
  drawBuildingOne(195,buildingY[3]);
  drawBuildingOne(260,buildingY[4]);
  drawBuildingOne(340,buildingY[5]);

  color buildingColor = color(10, 15, 60);
  color windowGlow = color(200,190,40);

  // Second building
  fill(buildingColor);
  stroke(buildingColor);
  rect(160,405,70,160);
  
  // rows of windows on the second building
  for (int r = 0; r < 10; r++) {
    stroke(windowGlow);
    fill(windowGlow);
    rect(169, 412+r*15, 5, 8);
    rect(169+16, 412+r*15, 5, 8);
    rect(169+16*2, 412+r*15, 5, 8);
    rect(169+16*3, 412+r*15, 5, 8);
  }
}

void drawBuildingOne(float x, float y) { // <-- x and y are parameters!
  color buildingColor = color(10, 15, 60);
  color windowGlow = color(200,190,40);
  
  // First building
  fill(buildingColor);
  stroke(buildingColor);
  rect(x,y,70,140);
  
  // rows of windows on first building
  for (int r = 0; r < 8; r++) {
    stroke(windowGlow);
    fill(windowGlow);
    rect(x+9, y+10+(r*15), 5, 8);
    rect(x+9+16, y+10+(r*15), 5, 8);
    rect(x+9+16*2, y+10+(r*15), 5, 8);
    rect(x+9+16*3, y+10+(r*15), 5, 8);
  }
}