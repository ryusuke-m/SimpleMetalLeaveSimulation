final int PARTICLE_SUM=2000;
final int PARTICLE_MOVING=500;
float particleX[],particleY[];
int particleState[];
float particleSize=5;
void setup(){
  size(800,800);
  frameRate(1000);
  particleX=new float[PARTICLE_SUM];
  particleY=new float[PARTICLE_SUM];
  particleState=new int[PARTICLE_SUM];
  
  for(int i=0;i<PARTICLE_SUM;i++){
    particleX[i]=random(0,width);
    particleY[i]=random(0,height);
    particleState[i]=0;
  }
  particleX[0]=width/2;
  particleY[0]=height/2;
  particleState[0]=2;
}
int moving=0;
int i=1;
int stoped=1;
int pending=PARTICLE_SUM-1;
void draw(){
  background(255);
  while(moving<PARTICLE_MOVING){
    if(i>=PARTICLE_SUM){
      break;
    }
    particleState[i]=1;
    i++;
    moving++;
    pending--;
  }
  for(int j=0;j<PARTICLE_SUM;j++){
    if(particleState[j]==1){
      float theta=random(0,2*PI);
      float d=random(0,10);
      particleX[j]+=d*cos(theta)+(width/2-particleX[j])/500.0;
      if(particleX[j]<0){
        particleX[j]=-particleX[j];
      }else if(particleX[j]>=width){
        particleX[j]=2*width-particleX[j];
      }
      particleY[j]+=d*sin(theta)+(height/2-particleY[j])/500.0;
      if(particleY[j]<0){
        particleY[j]=-particleY[j];
      }else if(particleY[j]>=height){
        particleY[j]=2*height-particleY[j];
      }
      for(int k=0;k<PARTICLE_SUM;k++){
        float dist=(particleX[j]-particleX[k])*(particleX[j]-particleX[k])+
        (particleY[j]-particleY[k])*(particleY[j]-particleY[k]);
        if(particleState[k]==2 && dist<=(particleSize*2)*(particleSize*2)){
          particleState[j]=2;
          moving--;
          stoped++;
          break;
        }
      }
    }
    if(particleState[j]==1){
      fill(255,127,127);
      ellipse(particleX[j],particleY[j],particleSize*2,particleSize*2);
    }else if(particleState[j]==2){
      fill(127,127,255);
      ellipse(particleX[j],particleY[j],particleSize*2,particleSize*2);
    }
  }
  fill(0);
  textSize(36);
  text("All particles:    "+PARTICLE_SUM,50,40);
  text("pending particles:"+pending,50,80);
  text("moving particles: "+moving,50,120);
  text("stoped particles: "+stoped,50,160);
  text("FrameRate: "+frameRate,400,40);
}
