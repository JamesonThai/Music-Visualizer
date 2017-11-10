import processing.sound.*;
int cols, rows;
int scl =20;
int h = 1600;
int w = 2000;
float flying = 0;
float[][] terrain;
float [] array; 
Amplitude rms; 

SoundFile file;

float scale = 5;
float smooth_factor = 0.25;
float sum;

void setup()
{
  //size(600,600,P3D);
  size(1100, 750, P3D);
  file = new SoundFile(this, "RunningInThe90s.mp3");
  file.play();

  rms = new Amplitude(this);
  rms.input(file);
  cols = w/scl;
  rows = h/scl;
  terrain = new float[cols][rows];
}

void draw() {
  flying -= 0.1;
  float yoff = flying;

  sum += (rms.analyze() - sum) * smooth_factor;
  float rms_scaled = sum*(yoff/2)*scale;

  yoff = rms_scaled;

  for (int y = 0; y<rows; y++) {
    float xoff = 0;
    for (int x =0; x< cols; x++) {
      //terrain[x][y] = map(noise(xoff,yoff),0,1,-100,100);
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.2;
    }
    yoff += 0.2;
  }

  background(0);
  stroke(0, 255, 255);
  fill(34, 139, 34);
  translate(width/2, height/2 + 50);
  //rotateX(PI/2.5);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  for (int y = 0; y<rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x =0; x< cols; x++) {
      //vertex(x*scl, y*scl, terrain[x][y]);
      //vertex(x*scl, (y+1)*scl,terrain[x][y+1]);
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
}