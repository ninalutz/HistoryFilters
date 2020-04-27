import gab.opencv.*;
OpenCV opencv;

int numImages = 224;
PImage sourceImgs[] = new PImage[numImages]; //adjust array size to match amount of source images
String decade = "1940s";
int sampling = 224;
PImage cannyImg[] = new PImage[numImages];
PImage thresImg[] = new PImage[numImages];


void setup() {
  size(320,420); // note: source images must be the exact same pixel dimensions as canvas size!
  loadSrcImgs();  //loading source images into array from data folder
 // getPixelVals(); //getting pixel values from each image
 // saveImage();    //saving new image made from average of pixel values
// avgCanny();
 //saveCanny();
 avgThreshold();
 saveThreshold();
}

void draw() {
  
}

void loadSrcImgs() {
  for (int i = 1; i < sourceImgs.length+1; i++) {
    PImage img = loadImage("vogue/" + decade +"/image" + i + ".jpg");
    sourceImgs[i-1] = img;
    opencv = new OpenCV(this, img);
    
    opencv.findCannyEdges(30,75);
    PImage canny = opencv.getSnapshot();
    cannyImg[i-1] = canny;
   
    opencv = new OpenCV(this, img);
    opencv.threshold(100);
    PImage dst = opencv.getOutput();
    thresImg[i-1] = dst;
    println((float(i)/numImages)*100 + "% complete");
  }
}

void avgThreshold(){
 loadPixels(); 
 
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int loc = x + y*width;

      
      // totals across all images
      float rTotal = 0;
      float gTotal = 0;
      float bTotal = 0;

      for(int i = 0; i < thresImg.length; i+=sampling){
         rTotal = rTotal + red(thresImg[i].pixels[loc]);
         gTotal = gTotal + green(thresImg[i].pixels[loc]);
         bTotal = bTotal + blue(thresImg[i].pixels[loc]);
      }


      float rAvg = rTotal/(thresImg.length/sampling);
      float gAvg = gTotal/(thresImg.length/sampling);
      float bAvg = bTotal/(thresImg.length/sampling);

      // Set the display pixel to the image pixel
      pixels[loc] =  color(rAvg, gAvg, bAvg); 
      
    }
  }
  updatePixels();
}


void avgCanny(){
 loadPixels(); 
 
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int loc = x + y*width;

      
      // totals across all images
      float rTotal = 0;
      float gTotal = 0;
      float bTotal = 0;

      for(int i = 0; i < cannyImg.length; i+=sampling){
         rTotal = rTotal + red(cannyImg[i].pixels[loc]);
         gTotal = gTotal + green(cannyImg[i].pixels[loc]);
         bTotal = bTotal + blue(cannyImg[i].pixels[loc]);
      }


      float rAvg = rTotal/(cannyImg.length/sampling);
      float gAvg = gTotal/(cannyImg.length/sampling);
      float bAvg = bTotal/(cannyImg.length/sampling);

      // Set the display pixel to the image pixel
      pixels[loc] =  color(rAvg, gAvg, bAvg); 
      
    }
  }
  updatePixels();
}

void getPixelVals() {
  loadPixels(); 
  
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int loc = x + y*width;

      
      // totals across all images
      float rTotal = 0;
      float gTotal = 0;
      float bTotal = 0;

      for(int i = 0; i < sourceImgs.length; i+=sampling){
         rTotal = rTotal + red(sourceImgs[i].pixels[loc]);
         gTotal = gTotal + green(sourceImgs[i].pixels[loc]);
         bTotal = bTotal + blue(sourceImgs[i].pixels[loc]);
      }


      float rAvg = rTotal/(sourceImgs.length/sampling);
      float gAvg = gTotal/(sourceImgs.length/sampling);
      float bAvg = bTotal/(sourceImgs.length/sampling);

      // Set the display pixel to the image pixel
      pixels[loc] =  color(rAvg, gAvg, bAvg); 
      
    }
  }
  updatePixels();
}

void saveImage() {
  save("avg" + decade + "_" + sampling+ ".jpg");
}

void saveCanny(){
 save("canny" + decade + "_" + sampling+ ".jpg");
}

void saveThreshold(){
 save("threshold" + decade + "_" + sampling+ ".jpg");
}
