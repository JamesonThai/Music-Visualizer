// Source from Daniel Shiffman, http://codingtra.in http://patreon.com/codingtrain
// Modified by Jameson Thai to be adapated for music amplitudes, temp and frequency

var cols, rows;
var scl = 15;
// specific to Google Chrome MacBook 15 inch
// var w = 1400;
// var h = 1000;
// below is optimal for full screen
// var w = 2300;
// var h = 800;
// small scale
var w = 600;
var h = 880;


var flying = 0;

var terrain = [];
// Function setup and Draw are the main ones
function setup() {
  // full screen below
  // createCanvas(1425, 790, WEBGL);
  // small scale below
  createCanvas(500, 350, WEBGL);
  cols = w / scl;
  rows = h/ scl;

  for (var x = 0; x < cols; x++) {
    terrain[x] = [];
    for (var y = 0; y < rows; y++) {
      terrain[x][y] = 0; //specify a default value for now
    }
  }
}

function draw() {
  // Color Params
  var R = getColor();
  var G = getColor();
  var B = getColor();
  var colorArrayR = [];
  var colorArrayG = [];
  var colorArrayB = [];

  var countX, countY = 0;
  var switchC = 0;

   flying -= 0.99; // Set flying = to tempo
  //flying -=108;
  var yoff = flying;
  var countY = 0;
  for (var y = 0; y < rows; y++) {
    var xoff = 0;
    if (countY == 5){
      countY = 0;
      R = getColor();
      G = getColor();
      B = getColor();
    }
    colorArrayR.push(R);
    colorArrayB.push(B);
    colorArrayG.push(G);
    for (var x = 0; x < cols; x++) {
      // Modify these values to music amplitude
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.2;
    }
    yoff += 0.2;
    countY++;
  }

  // populating color listing first
  // for (var y = 0; y < rows; y++){
  //     if (y == 5){
  //       R = getColor();
  //       G = getColor();
  //       B = getColor();
  //     }
  //     colorArrayR.push(R);
  //     colorArrayG.push(G);
  //     colorArrayB.push(B);
  // }
  background(0);
  translate(0, 50); // to adjust placeing

  rotateX(-PI/3); // to rotate to look like you're flying over it
  // fill(x,y,z,t)
  // x: color y: color z: color t: visibility
  // could have color be randomly generated
  // fill(getColor() ,getColor(),getColor(), 50);
  translate(-w/2, -h/2);
  for (var y = 0; y < rows-1; y++) {

    // if (countY == 5){
    //   countY = 0;
    //   R = getColor();
    //   G = getColor();
    //   B = getColor();
    // }
    // colorArrayR.push(R);
    // colorArrayB.push(B);
    // colorArrayG.push(G);


    // if (switchC == 0){
    // fill(R,G,B, 100);
    //fill(colorArrayR[y], colorArrayG[y], colorArrayB[y], 100);
       fill(10,200,200,50);
    // }
    beginShape(TRIANGLE_STRIP);

    for (var x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]); // declaring vertecies properly
    }
    // countY++;
    endShape();
  }
  colorArrayR.pop();
  colorArrayB.pop();
  colorArrayG.pop();
}
function getColor(){
  var x = Math.floor((Math.random() * 255) + 10);
  return x;
}


