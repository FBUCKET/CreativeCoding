import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
Minim minim;
AudioPlayer song;
FFT fft;
int numCircles=7;
int numBands = 7;
float   bandWidth =10;
float   posX ;
float   posY  ;
color [] col = new color[numBands];
float [] speed = new float [numBands];
float [] pre_speed = new float[numBands];

float rotatingRate = 0;
Circle ro_circle;
Circle[] iter_circle= new Circle [numCircles];
void setup(){
  size(600,600);
  minim = new Minim(this);
  song = minim.loadFile("groove.mp3");
  fft = new FFT(song.bufferSize(),song.sampleRate());
  fft.linAverages(numBands);
   posX = 0;
   posY= 0;
  for(int i=0;i<numBands;i++){
    col[i]= color(random(0,255),random(0,255),random(0,255));
    pre_speed[i] = 0;
  }
  for(int i=0;i<numCircles;i++){
    iter_circle[i] = genCircle();
  }
  song.loop(); 
}
void draw(){
  background(0);
  //float w  = width  / numAudioBands;
  fft.forward(song.mix);
  //println(song.mix);
  for (int i=0;i<numBands;i++){
    float strength = fft.getAvg(i)*30;
    //fill(col[i]);
    //ellipseMode(CENTER);
    //ellipse(posX[i],posY[i],40,40);
    //using moving average to soomth the sound
    
    speed[i]=map(strength,0,30,0,PI);
    pre_speed[i] = pre_speed[i]*0.2+speed[i]*0.8;
    //println(pre_speed[i]);
  }
  
  pushMatrix();
  translate(width/2,height/2);
  rotate(rotatingRate);
  ro_circle = new Circle(0,0,bandWidth,pre_speed,col);
  ro_circle.showCircle();
  for(int i=0;i<numBands;i++){
  iter_circle[i].showCircle();
  }
  rotatingRate+=0.02;
  popMatrix();
}

Circle genCircle(){
     Circle cir;
     float   posX ;
     float   posY ;
     float BWidth;
     color [] col = new color[numBands];
     posX = random((numBands+5)*bandWidth,width/2);   
     posY = random((numBands+5)*bandWidth,height/2);
     BWidth =random(1,3);
     for(int j=0;j<numCircles;j++){
         col[j]= color(random(0,255),random(0,255),random(0,255));
     }
     cir= new Circle(posX,posY,BWidth,pre_speed,col);
     return cir;    
}
