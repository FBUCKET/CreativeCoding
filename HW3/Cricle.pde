class Circle{
  float pos_X;
  float pos_Y;
  float[] speed;
  color[] col;
  float bandWidth;
  Circle(float pos_X,float pos_Y,float bandWidth,float[] speed,color[] col){
    this.pos_X = pos_X;
    this.pos_Y = pos_Y;
    this.speed = speed;
    this.col   = col;
    this.bandWidth = bandWidth;
  }
  void showCircle(){
    smooth();
    noFill();
    pushMatrix();
    strokeWeight(bandWidth);
    translate(pos_X,pos_Y);
    for(int i=0;i<speed.length;i++){
      stroke(col[i]);
      //println(speed[i]);
      arc(0,0,(i*2+5)*bandWidth,(i*2+5)*bandWidth,0,speed[speed.length-1-i],OPEN);  
      //arc(0,0,i*20+100,i*20+100,speed[i]+PI/2,OPEN);
      arc(0,0,(i*2+5)*bandWidth,(i*2+5)*bandWidth,PI,speed[speed.length-1-i]+PI,OPEN); 
      //arc(0,0,i*20+100,i*20+100,speed[i]+PI*3/2,OPEN); 
    }
    popMatrix();
  }
}
