var hats;
var frame = 0;
var w = 800; // canvas width 
var h = 600; // canvas height
var k = 300; // length of time for each inmate to be on screen

var inmate = []; // array that holds new Inmate objects

function preload() {
  hats = loadImage("gradhat.png");
}

function setup() { 
  createCanvas(w, h);
  image(hats, 0, 0, w, h);

// create a new Inmate object for each inmate in the array
  for (var i = 0; i < inmates.length; i++) {
    inmate[i] = new Inmate();
  }
} 

function draw() { 
// if frameCount is divisible by interval, increment frame
  if (frameCount % k == 0) {
    frame++; 
    inmate[frame].show();
  }
// if number of frames reaches number of inmates, restart the count
  if (frame == inmates.length - 1) {
    frame = 0;
  }
}

function Inmate() {
  this.show = function() {
    var bgColor = color(46, 52, 122, 150);
    var leftMargin = 45;
    var boxW = 533;

    fill(bgColor);
    noStroke();
    rect(leftMargin, 15, boxW, 55);

    fill(bgColor);
    noStroke();
    rect(leftMargin, 200, boxW, 270);

    textSize(27);
    fill(255, 255, 255);
    text(inmates[frame].name, 50, 50);
    text(inmates[frame].history, 50, 220, boxW, 300);
  }
}
