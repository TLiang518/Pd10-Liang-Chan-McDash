PImage bg, img;
String[] images ={"testpic.jpg","coorfind.png"};


void gameSetup(){
    bg = loadImage(images[0]);
    img = loadImage(images[1]);
    img.resize(10,10);
    image(img,50+a,50+b);
