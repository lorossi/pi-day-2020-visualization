float[] hues; // contains the hues for the 10 digits
float[] spacing; // contains the spacing between lines for every digit
float[] first_free; // first free location in each digit
int[] occurrencies; // occorruncies of each digit
int[] pi_digits; // digits of PI
byte[] pi_bytes; // content of the .txt file

PFont font, italic_font; // title and description fonts
float line_size; // length of each digit line
int pi_length; // number of digits of PI
boolean draw_title; // if set to true, adds title and description

void setup() {
  size(10000, 10000); // change this to get a different image size
  colorMode(HSB, 255, 255, 255, 255);
  randomSeed(3141516); // the random function is used to give a less uniform look
  smooth(8);

  draw_title = false; // change this to disable title and description

  // preloading fonts
  font = createFont("Roboto-Thin.ttf", 128, true);
  italic_font = createFont("Roboto-ThinItalic.ttf", 128, true);

  // size of the single digit segment
  line_size = (float) width / 10;


  // initialization of first_free and occurrencies arrays
  occurrencies = new int[10];
  first_free = new float [10];
  for (int i = 0; i < 10; i++) {
    occurrencies[i] = 0;
    first_free[i] = line_size * i;
  }


  pi_bytes = loadBytes("data/pi.txt"); // loading from file
  pi_length = pi_bytes.length - 2; // the last 2 bytes are CR and LF
  pi_digits = new int[pi_length]; // keep track of the array length

  // loading pi in the pi_digits array
  for (int i = 0; i < pi_length; i++) {
    if (pi_bytes[i] == 13 || pi_bytes[i] == 10) {
      //We want to be sure that the current byte is not a CR or a LF
      break;
    }

    int digit = int(pi_bytes[i] - 48); // ascii conversion
    pi_digits[i] = digit; // store the digit in the array
    occurrencies[digit]++; // keep track of how many times we found a digit
  }

  // calculating the spacing between connections in a single digit
  spacing = new float[10];
  for (int i = 0; i < 10; i++) {
    spacing[i] = line_size / occurrencies[i];
  }

  // initializing hues array (color for each digit)
  hues = new float[10];
  for (int i = 0; i < 10; i++) {
    float h = (float) 255 / 10 * i;
    hues[i] = h;
  }
}

void draw() {
  println("Started");
  push();

  // scaling the image down
  translate(width/2, height/2);
  scale(0.75);
  translate(-width/2, -height/2);
  background(0);

  // draw line arches
  for(int i = 0; i < pi_length - 2; i++) {
    int current_digit = pi_digits[i];
    int next_digit = pi_digits[i+1];

    float x1, x2, arc_center, arc_width, arc_height, dh, y;
    y = (float) height / 2;
    x1 = first_free[current_digit];
    x2 = first_free[next_digit];
    arc_width = abs(x2 - x1); // arc width
    dh = random(-height * 0.005, height * 0.005); // adding some randomness to make the arc look less uniform
    arc_height = arc_width + dh;
    arc_center = (x1 + x2) / 2; //arc center


    float h, a;
    color c;
    // adding some randomness to make the color look less uniform
    dh = random(-3, 3);
    h = hues[current_digit] + dh;
    a = 7;
    c = color(h, 255, 255, a);

    push();
    noFill();
    stroke(c);

    if (current_digit < next_digit) {
      // if the current digit is LESS then the next digit (e.g., 3 to 5)
      // the arc is going to be drawn in the upper half of the sketch
      arc(arc_center, y, arc_width, arc_width, -PI, 0);
    } else {
      // otherwise, is going to be drawn in the lower half
      arc(arc_center, y, arc_width, arc_width, 0, PI);
    }

    pop();

    // we keep track of the first available pixel in which the next arc will
    // be drawn
    first_free[current_digit] += spacing[current_digit];

    // write something in console so we know it's not stuck somewhere
    if (i % (pi_length / 50) == 0 && i > 0) {
      int percent = ceil((float) i / pi_length * 100);
      println(percent, "percent completed");
    }
  }

  // draw number lines
  for (int i = 0; i < 10; i++) {
    float h;
    color c;
    h = hues[i];
    c = color(h, 255, 255, 200);

    float x, y;
    x = i * line_size;
    h = (float) height / 1000 * 4; //rect height
    y = height / 2 - h;

    push();
    fill(c);
    noStroke();
    rect(x, y, line_size, h);
    pop();
  }

  // draw legend
  for (int i = 0; i < 10; i++) {
    float h;
    color c;
    h = hues[i];
    c = color(h, 255, 255, 200);

    float x, y, text_size;
    x = i * line_size;
    h = (float) height / 1000 * 8; //rect height
    y = 0;
    text_size = (float) height * 0.04;

    push();
    translate(line_size * 1.1, height * 1.11);
    scale(0.8);
    fill(c);
    noStroke();
    rect(x, y, line_size, h);
    textFont(font, text_size);
    textAlign(CENTER, BOTTOM);
    fill(255);
    text(i, x + line_size / 2, y - h);
    pop();
    println("Legend drawn");
  }

  pop();

  if (draw_title) {
    // Draw title
    float text_size = (float) height * 0.06;
    push();
    textAlign(LEFT, BOTTOM);
    fill(255);
    textFont(font, text_size);
    translate(text_size/2, text_size*3/2);
    text("Visualizing PI", 0, 0);
    translate(0, text_size/2);
    textFont(italic_font, text_size/2);
    text("1 million digits at a time", 0, 0);
    pop();

    // Draw name
    push();
    rotate(-HALF_PI);
    translate(-width + text_size/2, height - text_size/2);
    textAlign(LEFT);
    fill(255);
    textFont(italic_font, text_size/2);
    text("Lorenzo Rossi - @lorossi97", 0, 0);
    pop();

    println("Title drawn");
  }


  println("Finished");
  int seconds_elapsed = millis() / 1000;
  println("It took", seconds_elapsed, "seconds");
  saveFrame("pi-title-" + width + "px.png");

  noLoop();
}
