String keyword="";
float rot=0;
float rotSpeed=-.02;
PImage head,front,back,left,right,top,bottom;

void setup(){
  size(600,600,P3D);
  textureMode(IMAGE);
  loadHead();
}

void draw(){
  //Setup
  background(200);
  
  //Text
  fill(0);
  noStroke();
  textAlign(CENTER);
  textSize(24);
  text(keyword,width/2,height/2+height/4);
  
  //Head
  fill(255);
  noStroke();
  texture(head);
  translate(width/2,height/2);
  rotateY(rot);
  scale(0.5);
  drawCube();
  rot+=rotSpeed;
}

void keyPressed(){
  if(key>='a' & key<='z' | key>='A' & key<='Z' | key>='0' & key<='9' | key=='_'){
    keyword+=key;
  }else if(key==BACKSPACE){
    /*if(keyword.length()>1){
      keyword=keyword.substring(0,keyword.length()-1);
    }else{*/
      keyword="";
    /*}*/
  }
  
  thread("loadHead");
}

void loadHead(){
  if(keyword==""){
    head=loadImage("http://minotar.net/skin/steve.png", "png");
  }else{
    head=loadImage("http://minotar.net/skin/"+keyword+".png", "png");
  }
  front=head.get(8,8,8,8);
  front=resizeNoBlur(front,20);
  
  back=head.get(24,8,8,8);
  back=resizeNoBlur(back,20);
  
  right=head.get(16,8,8,8);
  right=resizeNoBlur(right,20);
  
  left=head.get(0,8,8,8);
  left=resizeNoBlur(left,20);
  
  top=head.get(8,0,8,8);
  top=resizeNoBlur(top,20);
  
  bottom=head.get(16,0,8,8);
  bottom=resizeNoBlur(bottom,20);
}

void drawCube(){
  //front face
  beginShape(QUADS);
  texture(front);
  vertex(-160, -160,  160, 0, 0);
  vertex( 160, -160,  160, 160, 0);
  vertex( 160,  160,  160, 160, 160);
  vertex(-160,  160,  160, 0, 160);
  endShape();

  //back face
  beginShape(QUADS);
  texture(back);
  vertex( 160, -160, -160, 0, 0);
  vertex(-160, -160, -160, 160, 0);
  vertex(-160,  160, -160, 160, 160);
  vertex( 160,  160, -160, 0, 160);
  endShape();

  //bottom face
  beginShape(QUADS);
  texture(bottom);
  vertex(-160,  160,  160, 0, 0);
  vertex( 160,  160,  160, 160, 0);
  vertex( 160,  160, -160, 160, 160);
  vertex(-160,  160, -160, 0, 160);
  endShape();

  //top face
  beginShape(QUADS);
  texture(top);
  vertex(-160, -160, -160, 0, 0);
  vertex( 160, -160, -160, 160, 0);
  vertex( 160, -160,  160, 160, 160);
  vertex(-160, -160,  160, 0, 160);
  endShape();

  //right face
  beginShape(QUADS);
  texture(right);
  vertex( 160, -160,  160, 0, 0);
  vertex( 160, -160, -160, 160, 0);
  vertex( 160,  160, -160, 160, 160);
  vertex( 160,  160,  160, 0, 160);
  endShape();

  //left face
  beginShape(QUADS);
  texture(left);
  vertex(-160, -160, -160, 0, 0);
  vertex(-160, -160,  160, 160, 0);
  vertex(-160,  160,  160, 160, 160);
  vertex(-160,  160, -160, 0, 160);
  endShape(); 
}

PImage resizeNoBlur(PImage img, int scaleFactor){
  PImage out_img=createImage(img.width*scaleFactor,img.height*scaleFactor,RGB);
  
  img.loadPixels();
  out_img.loadPixels();
  for(int x=0; x<img.width; x++){
    for(int y=0; y<img.height; y++){
      for(int i=0; i<scaleFactor; i++){
        for(int j=0; j<scaleFactor; j++){
          out_img.pixels[(x*scaleFactor+i)+(y*scaleFactor+j)*out_img.width]=img.pixels[x+y*img.width];
        }
      }
    }
  }
  out_img.updatePixels();
  
  return out_img;
}