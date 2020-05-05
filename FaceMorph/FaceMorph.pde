// Face Morphing Demo
// Based on: https://ccrma.stanford.edu/~jacobliu/368Report/
// Daniel Shiffman

// Two images
PImage a;
PImage b;

// A Morphing object
Morpher morph;

// How much to morph, 0 is image A, 1 is image B, everything else in between
float amt =  0;
// Morph bar position
float x = 100; 
int pair = 0;
ArrayList<Morpher> morphs;
void setup() {
  size(1200, 900, P2D);
  morphs = new ArrayList<Morpher>();
  
  for(int i = 0; i<71;i++){
    a = loadImage("2000sALL/pic" + str(i) + ".jpg");
    b= loadImage("2000sALL/pic" + str(i+1) + ".jpg");
    if(a.width > 500) a.resize(500, 0);
    if(a.height > 500) a.resize(0, 500);
    if(b.width > 500) b.resize(500, 0);
    if(b.height>500) b.resize(0, 500);
    morph = new Morpher(a, b);
    morph.loadPoints();
    morphs.add(morph);
  }
  

  //// Load the images
  //a = loadImage("2010sALL/image1.jpg");
  //b = loadImage("2010sALL/image2.jpg");

  // Create the morphing object
  //morph = new Morpher(a, b);
  
  //morph.loadPoints();
}

void draw() {


  background(0);

  pushMatrix();

  // //Show Image A and its triangles
  //morph.displayImageA();
  //morph.displayTrianglesA();

  //// Show Image B and its triangles
  //translate(a.width, 0);
  //morph.displayImageB();


  //translate(-a.width, a.height);

  ////// Update the amount according to mouse position when pressed
  //if (mousePressed && mouseY > a.height) {
  //  x = constrain(mouseX, 100, width-100);
  ////  amt = map(x, 100, width-100, 0, 1);
  //}
  
  
  if(amt < 1){
    amt+=0.005;
  }
  

  else{
    amt = 0;
    if(pair < morphs.size() - 1)  pair+=1;
    else pair = 0;
  }
    
   

  // Morph an amount between 0 and 1 (0 being all of A, 1 being all of B)
  morphs.get(pair).drawMorph(amt);

  popMatrix();

  // Have you clicked on the images?
  if (va != null) {
    fill(255, 0, 0);
    ellipse(va.x, va.y, 8, 8);
  }
  if (vb != null) {
    fill(255, 0, 0);
    ellipse(vb.x, vb.y, 8, 8);
  }


}

// Save or load points based on key presses
void keyPressed() {
  if (key == 's') {
    morph.savePoints();
  } 

}

// Variables to keep track of mouse interaction
int counter = 0;
PVector va;
PVector vb;

void mousePressed() {
  
  
  // If we clicked on an image
  if (mouseY < a.height) {
    // Point on image A first
    if (counter == 0) {
      va = new PVector(mouseX, mouseY);
    } 
    // Corresponding point on image B
    else if (counter == 1) {
      PVector vb = new PVector(mouseX-a.width, mouseY);
      morph.addPair(va, vb);
    }
    // Increment click counter
    counter++;
    if (counter == 2) {
      // Start over
      counter = 0;
      va = null;
      vb = null;
    }
  }
}
