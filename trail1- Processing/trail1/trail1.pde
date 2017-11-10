import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
FFT fft;

BeatDetect beat;
BeatListener bl;


float w;
float bass, mid, high;


class BeatListener implements AudioListener
{
  private BeatDetect beat;
  private AudioPlayer source;

  BeatListener(BeatDetect beat, AudioPlayer source)
  {
    this.source = source;
    this.source.addListener(this);
    this.beat = beat;
  }

  void samples(float[] samps)
  {
    beat.detect(source.mix);
  }

  void samples(float[] sampsL, float[] sampsR)
  {
    beat.detect(source.mix);
  }
}


void setup()
{
  //size(512, 200);
  size(1200, 800);
  smooth();
  minim = new Minim(this);
  song = minim.loadFile("/Users/nityamshrestha/Documents/School/OnlineClasses/p5js/Songs/Sail.mp3", 1024);
  song.play();
  fft = new FFT(song.bufferSize(), song.sampleRate());
  println(song.bufferSize());
  println(song.sampleRate());
  println(fft.specSize());
  float totalHz = (song.sampleRate()/ 2);
  println(totalHz);
  println(totalHz/ 512);
  w= width / 64; 
  //float hz = 
  //bass = cutoff - 15;    // 20-250 hz
  //mid = bass + cutoff;
  //high = fft.specSize();

  //beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  beat = new BeatDetect(); 
  //bl = new BeatListener(beat, song);  
  //println(" bass range: "+ bass);
  //println(" mid range: "+ mid);
  //println(" high range: "+ high);
}

void draw()
{
  background(0);
  beat.detect(song.mix);
  fft.forward(song.mix);
  //stroke(255, 0, 0, 128);
  /* works
   if(beat.isOnset())
   println("***Beat!!*****");
   else
   println("----------------");
   */

    for (int i = 0; i < fft.specSize(); i++)
  {
    //float bassValue = 0;
    //float midValue = 0;
    //float highValue = 0;
    float band = fft.getBand(i); // 0 -> 25..40
    //println(band);
    noStroke();
    //ellipseMode(CENTER);
    ellipse(width/2, height/2, 10, 10);
    ellipse(100, 100, band, band);
    ellipse(1000, 100, band, band);

    if (beat.isOnset()) {
      if (i < 7 && band > 100) {
        fill(255);
        //ellipseMode(CENTER);
        ellipse(width/2, height/2, band, band);
      } else if (i >=11 && i < 17 && band > 100) {
        println("MID!!!");
        fill(163, 238, 63);
        //ellipseMode(CENTER);
        ellipse(100, 100, band, band);
      } else if (band > 100 && i > 17) {
        println("Other band");
        fill(255, 206, 0);
        //ellipseMode(CENTER);
        ellipse(1000, 100, band, band);
        println("I ; " + i + ": " + band);
      } else {
        fill(255);
        strokeWeight(2);
        rect(width/2, 600, 10, band*1000);
        println("I light: " +i +":  "+ band);
      }
    }
    //if(i< bass){
    //  bassValue += band;
    //}else if( i < mid){
    //  midValue += band;
    //}else{
    //  highValue += band;
    //}
    //float bTotal =(bassValue >0.001)? bassValue / bass : 0;
    //float mTotal = (midValue > 0.001)? midValue / mid : 0;
    //float hTotal = (highValue > 0.001)? highValue/ high : 0;

    //println(midValue);
    //println("Bass: "+ bTotal);
    //println("Mis: "+ mTotal);
    //println("Hi: "+ hTotal);

    //float freq = fft.getFreq(i);  //  0->25
    //beat detect
    //if(beatDetect.isRange())

    //visual
    //float y = map(band, 0, 25, height, 0 );
    //fill(i,255,255);
    ////line(i * (i/2) + 20, height, i + 20, height - fft.getBand(i)*8);
    // rect(i*w, y ,w-2, height - y);
  }
}
void stop() {  
  song.close(); // always close Minim audio classes when you are finished with them
  println("stopeed");
  minim.stop(); // always stop Minim before exiting
  super.stop(); // this closes the sketch
}