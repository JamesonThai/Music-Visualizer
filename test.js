// Source from Daniel Shiffman, http://codingtra.in http://patreon.com/codingtrain
// Modified by Jameson Thai to be adapated for music amplitudes, temp and frequency

var cols, rows;
var scl = 20;
// specific to Google Chrome MacBook 15 inch
// var w = 1400;
// var h = 1000;
var w = 1400;
var h = 1000;
var flying = 0;

var terrain = [];
// Function setup and Draw are the main ones
function setup() {
  // createCanvas(600, 600, WEBGL);
  // createCanvas(1425, 790, WEBGL);
  cols = w / scl;
  rows = h/ scl;

}

function draw() {
  background(0);
  stroke(255);
  noFill();
  translate(width/2, height/2);

  rotateX(-PI/3); // to rotate to look like you're flying over it
  translate(-w/2, -h/2);
  for (var y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (var x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]); // declaring vertecies properly
    }
    endShape();
  }
}


