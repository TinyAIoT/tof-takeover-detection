String[] lines; // Array to store lines from the CSV file
int currentRow = 0; // Variable to keep track of the current row being drawn
String[] depths = new String[1282]; // Create a list to parse serial into
boolean found = false; 
boolean paused = false; // Variable to control the pause between rows


// Mesh Generation Variables

final int WIDTH = 1500;
final int HEIGHT = 1000;
final int BLOCKX = WIDTH / (8*5);
final int BLOCKY = HEIGHT / (8*4);
int cols = 8; // Sensor is 8x8
int rows = 8;
int scale = 100; // Scale value for drawing our mesh
float[][][] terrain = new float[20][9][9]; // Create a table of distance values by pixel location

void setup() {
    size(1650,1100);
    background(255);

    // Fill our list with 0s to avoid a null pointer exception
    // in case the sensor data is not immediately available
    for(int idx = 0; idx < 64; idx++){
        depths[idx] = "0,0,0,0"; 
    }

    textSize(35);

    // Load the CSV file
    lines = loadStrings("training/temp/stadtlohnweg_auto_cropped_reversed.csv");
}

void draw() {
  // If not paused, draw the current row
  if (!paused) {
    drawRow();
    currentRow++; // Move to the next row
    if (currentRow >= lines.length) {
      noLoop(); // Stop drawing when all rows are drawn
    } else {
      // Pause for 5 milliseconds before drawing the next row
      redraw();
      //delay(1);
    }
  }
}

void drawRow() {
    // Split the current row into values
    depths = split(lines[currentRow], ",");
    colorMode(HSB); // HSB color space make+s it easy to map hue
    background(0); // Fill background with black
    
    scale(.5);

    for(int i=0; i<20; i++) {
      for(int y=0; y<rows; y++){
          for(int x=0; x<cols; x++){
          if(depths.length >= 64){
              terrain[i][x][y] = float(depths[i*64+x+y*cols]);
          }
          }
      }
    }
    int count = 0;
    for(int i=0; i<4; i++) {
      for(int j=0; j<5; j++) {
        for(int y=0; y<rows; y++){
            //beginShape(TRIANGLE_STRIP);
            for(int x=0; x<cols; x++){ 
              if(terrain[0][cols-x-1][y] == 500) {
                  fill(255);
              } else {
                  fill(map(terrain[count][cols-x-1][y],0,2600,255,0) ,255,255);
              }
              rect((x+j*9)*BLOCKX*2, (y+i*9) * BLOCKY*2, (x + 1+j*9) * BLOCKX*2, (y + 1+i*9) * BLOCKY*2);
            }
             fill(0);
             rect((8+j*9)*BLOCKX*2, (y+i*9) * BLOCKY*2, (8 + 1+j*9) * BLOCKX*2, (y + 1+i*9) * BLOCKY*2);
          endShape();
        };
        
             fill(0);
             rect((0+j*9)*BLOCKX*2, (8+i*9) * BLOCKY*2, (8 + 1+j*9) * BLOCKX*2, (8 + 1+i*9) * BLOCKY*2);
          count = count + 1;
      }
    }
    fill(0, 0, 0);
    text(depths[1280], 50, 50,200);
    textSize(120);
    text(depths[1281], BLOCKX*2, 6*BLOCKY*2,200);
    // if(!found){
        if(float(depths[1281])>0.8) {
            if(!found) {
              found = true;
              paused = true;
            }
            text("takeover!", BLOCKX*2, 3*BLOCKY*2,200);
            delay(50);
        } else {
          found = false;
          
        }
            textSize(35);
    // }
    // else {
    //        textSize(120);
    //     text("takeover!", BLOCKX*2, 3*BLOCKY*2,200);
    //     textSize(35);
    //     if(isInArray(depths[1280])) {
    //         found = false;
    //     }
    //     delay(50);
    // }
}    

boolean isInArray(String valueToCheck) {
  String[] timepairs = {
        // training/trainingsdata/unlabeled/luca/Fahrraeder.csv
        "16:05:27.627", "16:05:28.203",
        "16:05:33.571", "16:05:33.961",
        "16:05:40.675", "16:05:41.171",
        "16:05:42.784", "16:05:43.068",
        "16:05:46.620", "16:05:47.057",
        "16:05:49.594", "16:05:49.986",
        "16:05:53.056", "16:05:53.488",
        "16:05:56.041", "16:05:56.232",
        "16:06:02.370", "16:06:02.711",
        "16:06:04.813", "16:06:05.249",
        "16:06:10.464", "16:06:10.708",
        "16:06:17.048", "16:06:17.382",
        "16:06:25.419", "16:06:25.752",
        "16:06:55.549", "16:06:56.079",
        "16:06:58.914", "16:06:59.156",
        "16:07:06.113", "16:07:06.502",
        "16:07:13.184", "16:07:13.461",
        "16:07:21.934", "16:07:22.376",
        "16:07:27.359", "16:07:27.593",
        "16:07:28.582", "16:07:28.822",
        "16:07:33.490", "16:07:33.698",
        "16:07:45.569", "16:07:45.966",
        "16:07:47.617", "16:07:47.907",
        "16:08:01.206", "16:08:01.501",
        "16:08:28.654", "16:08:29.194",
        "16:08:33.968", "16:08:34.398",
        "16:08:40.836", "16:08:41.268",
        "16:08:42.450", "16:08:42.648",
        "16:08:48.834", "16:08:49.173",
        "16:08:52.021", "16:08:52.401",
        "16:08:53.655", "16:08:54.012",
        "16:08:54.499", "16:08:54.743", 
        "16:08:56.556", "16:08:56.755",
        "16:08:57.050", "16:08:57.344",
        "16:08:57.443", "16:08:57.882",
        "16:08:58.520", "16:08:58.969",
        "16:08:59.112", "16:08:59.407", 
        "16:09:00.917", "16:09:01.309",
        "16:09:03.940", "16:09:04.481",
        "16:09:05.216", "16:09:05.648",
        "16:09:09.349", "16:09:09.696",
        // "16:09:43.428", "16:09:44.368", not a take over, just pass by 
        "16:09:57.503", "16:09:57.802",
        "16:10:12.465", "16:10:13.048",
        "16:10:13.091", "16:10:13.491",
        "16:10:14.947", "16:10:15.289",
        "16:10:15.547", "16:10:15.919",
        "16:10:18.618", "16:10:18.946",
        "16:10:22.169", "16:10:22.646",
        "16:10:26.537", "16:10:26.833",
        "16:10:51.585", "16:10:51.975",
        "16:11:33.294", "16:11:33.734",
        "16:11:38.018", "16:11:38.400",
        "16:11:40.171", "16:11:40.451",
        "16:11:45.238", "16:11:45.462",
        "16:11:46.644", "16:11:46.953",
        "16:11:56.634", "16:11:56.977",
        "16:11:58.677", "16:11:59.075",
        "16:11:59.173", "16:11:59.570",
        "16:12:00.501", "16:12:00.784",
        "16:12:02.102", "16:12:02.454",
        "16:12:06.073", "16:12:06.300",
        "16:12:33.083", "16:12:33.234",
        "16:12:56.829", "16:12:57.456",
        "16:13:03.352", "16:13:03.790",
        "16:13:06.608", "16:13:06.750",
        "16:13:07.576", "16:13:07.811",
        "16:13:08.485", "16:13:08.831",
        "16:13:11.068", "16:13:11.611",
        "16:13:12.294", "16:13:12.870",
        "16:13:18.040", "16:13:18.285",
        "16:13:19.329", "16:13:19.517",
        "16:13:20.115", "16:13:20.354",
        "16:13:24.249", "16:13:24.591",
        "16:13:25.225", "16:13:25.767",
        "16:13:26.104", "16:13:26.349", 
        // unknown video that Luca recorded
        "16:54:32.105","16:54:33.889",
        "16:54:35.068","16:54:37.002",
        "16:54:38.378","16:54:40.211",
        "16:54:42.082","16:54:43.769",
        "16:54:45.002","16:54:46.835",
        "16:54:49.099","16:54:50.786",
        "16:54:52.801","16:54:54.587",
        "16:54:55.868","16:54:57.698",
        "16:54:59.618","16:55:01.604",
        "16:55:03.080","16:55:04.864",
        "16:55:06.686","16:55:08.520",
        "16:55:10.043","16:55:11.827",
        "16:55:14.189","16:55:16.073",
        "16:55:17.697","16:55:19.482",
        "16:55:21.201","16:55:23.086",
        "16:55:24.856","16:55:26.890",
        "16:55:29.104","16:55:31.134",
        "16:55:32.415","16:55:34.198",
        "16:55:36.362","16:55:38.247",
        "16:55:39.870","16:55:41.705",
        "16:55:43.574","16:55:45.360",
        "16:55:47.821","16:55:49.755",
        "16:55:50.495","16:55:52.131",
        "16:55:55.575","16:55:57.361",
        "16:55:59.232","16:56:00.967",
        "16:56:03.377","16:56:05.314",
        "16:56:07.626","16:56:09.462",
        "16:56:11.675","16:56:13.413",
        "16:56:15.724","16:56:17.560",
        "16:56:19.727","16:56:21.463",
        "16:56:23.723","16:56:25.360",
        "16:56:27.527","16:56:29.211",
        "16:56:30.343","16:56:31.928",
        "16:56:33.552","16:56:35.138",
        "16:56:37.208","16:56:38.840",
        "16:56:39.576","16:56:41.262",
        "16:56:42.936","16:56:44.621",
        "16:56:45.213","16:56:46.799",
        "16:56:48.666","16:56:50.202",
        "16:56:50.892","16:56:52.426",
        "16:56:54.246","16:56:55.882",
        "16:56:56.619","16:56:58.203",
        "16:57:00.123","16:57:01.707",
        "16:57:02.643","16:57:04.229",
        "16:57:05.902","16:57:07.485",
        "16:57:08.815","16:57:10.602",
        "16:57:11.980","16:57:13.566",
        "16:57:16.126","16:57:17.911",
        "16:57:18.746","16:57:20.532",
        "16:57:23.137","16:57:24.728",
        "16:57:26.300","16:57:27.785",
        "16:57:29.015","16:57:30.554",
        "16:57:32.423","16:57:33.861",
        "16:57:34.990","16:57:36.475",
        "16:57:38.050","16:57:39.687",
        "16:57:40.719","16:57:42.204",
        "16:57:44.176","16:57:45.762",
        "16:57:46.355","16:57:47.892",
        "16:57:50.053","16:57:51.690",
        "16:57:52.328","16:57:53.865",
        "16:57:56.079","16:57:57.666",
        "16:57:58.602","16:58:00.136",
        "16:58:02.551","16:58:04.033",
        "16:58:04.869","16:58:06.307",
        // training/trainingsdata/unlabeled/luca/reverseData.csv
        "11:46:00.018","11:46:01.892",
        "11:46:02.460","11:46:04.152",
        "11:46:05.167","11:46:06.384",
        "11:46:11.396","11:46:12.933",
        "11:46:13.650","11:46:14.408",
        "11:46:15.170","11:46:16.590",
        "11:46:17.900","11:46:18.962",
        "11:46:19.355","11:46:20.384",
        "11:46:21.405","11:46:22.431",
        "11:46:23.700","11:46:24.740",
        "11:46:25.500","11:46:26.734",
        "11:46:27.802","11:46:28.200",
        "11:46:33.600","11:46:34.970",
        "11:46:38.000","11:46:39.100",
        "11:46:41.800","11:46:42.400",
        "11:46:43.780","11:46:44.400",
        "11:46:45.650","11:46:46.400",
        "11:46:47.670","11:46:48.861",
        "11:46:50.065","11:46:51.222",
        "11:46:53.352","11:46:53.800",
        "11:47:03.400","11:47:04.000",
        "11:47:07.300","11:47:07.960",
        "11:47:09.600","11:47:09.800",
        "11:47:10.420","11:47:11.670",
        "11:47:12.500","11:47:12.850",
        "11:47:27.400","11:47:27.800",
        "11:47:30.450","11:47:31.100",
        "11:47:31.650","11:47:32.944",
        "11:47:33.700","11:47:34.670",
        "11:47:40.870","11:47:41.999",
        "11:47:42.900","11:47:44.000",
        "11:47:46.210","11:47:46.897",
        "11:47:57.200","11:47:58.510",
        "11:47:59.250","11:48:00.100",
        "11:48:01.333","11:48:02.200",
        "11:48:06.300","11:48:08.236",
        "11:48:09.320","11:48:10.364",
        "11:48:14.760","11:48:15.632",
        "11:48:16.800","11:48:17.386",
        "11:48:18.170","11:48:18.893",
        "11:48:21.200","11:48:22.617",
        "11:48:23.300","11:48:24.056",
        "11:48:24.700","11:48:25.566",
        "11:48:31.415","11:48:32.198",
        "11:48:33.600","11:48:34.045",
        "11:48:38.858","11:48:39.846",
        "11:48:47.550","11:48:48.200",
        "11:48:54.578","11:48:55.510",
        "11:48:56.700","11:48:57.405",
        "11:49:21.598","11:49:23.000",
        "11:49:23.800","11:49:25.286",
        "11:49:26.318","11:49:27.333",
        "11:49:31.971","11:49:33.300",
        "11:49:33.986","11:49:34.790",
        "11:49:35.689","11:49:36.579",
        "11:49:37.745","11:49:38.922",
        "11:49:39.255","11:49:40.155",
        "11:49:40.800","11:49:41.815",
        "11:49:42.881","11:49:43.927",
        "11:49:44.603","11:49:45.675",
        "11:49:46.697","11:49:47.188",
        "11:49:51.972","11:49:53.199",
        "11:49:56.114","11:49:56.900",
        "11:49:59.400","11:50:00.189",
        "11:50:01.306","11:50:01.893",
        "11:50:02.850","11:50:03.743",
        "11:50:04.958","11:50:05.907",
        "11:50:07.128","11:50:08.153",
        "11:50:10.000","11:50:10.100",
        "11:50:18.500","11:50:19.096",
        "11:50:21.815","11:50:22.744",
        "11:50:24.670","11:50:25.533",
        "11:50:43.666","11:50:44.647",
        "11:50:45.600","11:50:46.061",
        "11:50:47.568","11:50:48.412",
        "11:50:58.630","11:50:59.675",
        "11:50:59.950","11:51:00.954",
        "11:51:01.874","11:51:02.414",
        "11:51:03.299","11:51:03.938",
        "11:51:23.550","11:51:24.350",
        "11:51:33.824","11:51:34.315",
        "11:51:34.800","11:51:35.500",
        "11:51:44.000","11:51:45.215",
        "11:51:49.062","11:51:49.700",
        "11:51:59.152","11:52:00.386",
        "11:52:01.158","11:52:02.003",
        "11:52:03.317","11:52:04.096",
        "11:52:07.900","11:52:09.025",
        "11:52:10.734","11:52:11.660",
        "11:52:15.960","11:52:16.999",
        "11:52:17.389","11:52:18.358",
        "11:52:18.890","11:52:19.745",
        "11:52:31.852","11:52:33.160",
        "11:52:33.893","11:52:34.817",
        "11:52:39.704","11:52:40.777",
        "11:52:41.752","11:52:42.500",
        "11:52:55.066","11:52:55.959",
        "11:52:56.768","11:52:57.415",
        // training/trainingsdata/unlabeled/paula/autos_1.csv
        "12:56:36.859","12:56:37.065",
        "12:56:39.958","12:56:40.355",
        "12:56:47.355","12:56:47.577",
        "12:56:50.655","12:56:50.785",
        "12:56:53.559","12:56:53.622",
        "12:56:55.603","12:56:56.071",
        "12:56:57.914","12:56:57.176",
        "12:56:59.762","12:57:00.223",
        "12:57:02.138","12:57:02.533",
        "12:57:04.055","12:57:04.315",
        "12:57:42.999","12:57:43.331",
        "12:57:44.060","12:57:44.253",
        "12:57:45.773","12:57:45.903",
        "12:57:51.713","12:57:51.779",
        // training/trainingsdata/unlabeled/paula/autos_2.csv
        "13:00:39.962","13:00:39.962",
        "13:00:42.335","13:00:42.335",
        "13:00:43.325","13:00:43.596",
        "13:00:52.371","13:00:52.503",
        "13:00:56.989","13:00:57.121",
        "13:01:00.620","13:01:00.886",
        "13:01:04.118","13:01:04.184",
        "13:01:15.013","13:01:15.208", // maybe this is too long?
        "13:01:16.403","13:01:16.926", // spotty
        "13:01:18.048","13:01:18.144",
        "13:01:20.688","13:01:20.756",
        "13:01:33.692","13:01:33.825",
        "13:01:34.815","13:01:35.145",
        "13:01:37.256","13:01:37.856",
        "13:01:43.332","13:01:44.188",
        "13:01:47.027","13:01:47.165",
        "13:01:49.668","13:01:49.800",
        "13:01:53.695","13:01:53.961",
        "13:01:55.410","13:01:55.874",
        "13:01:57.593","13:01:57.992",
        "13:01:59.437","13:01:59.773",
        "13:02:01.816","13:02:02.011",
        "13:02:05.840","13:02:06.107",
        "13:02:19.966","13:02:20.237",
  };
  
    // Iterate through the array
  for (int i = 0; i < timepairs.length; i++) {
    // Check if the current element is equal to the value we are checking
    if (timepairs[i].equals(valueToCheck)) {
      // If found, return true
      print("\n\nfound!\n\n");
      return true;
    }
  }
  return false;
}

void keyPressed() {
  //println("Key pressed: " + key + ", ASCII value: " + int(key));
  // Press any arrow key to pause and move back or forward one frame
  if (key == 'a') {
    if (currentRow > 0) {
      currentRow--;
      drawRow();
      redraw();
      delay(3);
    }
  } else if (key == 'd') {
    if (currentRow < lines.length - 2) {
      currentRow++;
      drawRow();
      redraw();
      delay(3);
    }
  } else if (key == ' ') {
    // Press space to pause or resume the animation
    paused = !paused;
    if (!paused) {
      redraw();
    }
  }
}