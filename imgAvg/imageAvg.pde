int numImages = 224;
PImage sourceImgs[] = new PImage[numImages]; //adjust array size to match amount of source images
String decade = "1940s";
int sampling = 5;

void setup() {
  size(320,420); // note: source images must be the exact same pixel dimensions as canvas size!
  loadSrcImgs();  //loading source images into array from data folder
  getPixelVals(); //getting pixel values from each image
  saveImage();    //saving new image made from average of pixel values
}

void draw() {
  
}

void loadSrcImgs() {
  for (int i = 1; i < sourceImgs.length+1; i++) {
    sourceImgs[i-1] = loadImage("vogue/" + decade +"/image" + i + ".jpg");
  }
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
