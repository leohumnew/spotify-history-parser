JSONArray listenHistory;
JSONObject song;
int totalListenTime = 0, temp = 0, temp2 = 0, mouseHover = 0, selected = 0, screen = 1;
int m1 = 1, y1 = 2020, m2 = 1, y2 = 2021;
String tempText = "";
String[] mostPlayedSongs, mostListenedHours;
IntDict songsList = new IntDict(), timesList = new IntDict();

PImage bg, reload;
PFont font;

boolean loaded = false;

void setup() {
  size(600, 800);
  rectMode(CENTER);
  bg = loadImage("bg.png");
  reload = loadImage("reload.png");
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  font = createFont("ARLRDBD.TTF", 25);
  textFont(font);
  fill(#1ed760);
  noStroke();
  listenHistory = loadJSONArray("StreamingHistory0.json");
  //loadStats(m1, y1, m2, y2);
}

// DRAW -----------------------------------------------------------------------------------
void draw() {
  background(bg);
  //If loaded data
  if (loaded) {
    //Buttons
    if (selected<=0 && (mouseY<height/5.4 && mouseX>width/4 && mouseY > height/8)) {
      if (mouseX<width/5*1.9) drawDateButtons(1);
      else if (mouseX<width/5*3) drawDateButtons(2);
      else if (mouseX<width/5*3.65) drawDateButtons(3);
      else drawDateButtons(4);
    } else if (selected == 0) drawDateButtons(5);
    else if (mouseY<height/5.4 && mouseX>width/4 && mouseY > height/8) {
      drawDateButtons(selected);
      if (mouseX<width/5*1.9) mouseHover=1;
      else if (mouseX<width/5*3) mouseHover=2;
      else if (mouseX<width/5*3.65) mouseHover=3;
      else mouseHover=4;
    } else {
      drawDateButtons(selected);
      mouseHover=0;
    }
    if (mouseY<height/5.4 && mouseX<width/4 && mouseY > height/8 && mouseX > width/6) {
      mouseHover=5;
      image(reload, width/4.6, height/6.5, 45, 45);
    } else image(reload, width/4.6, height/6.5, 35, 35);
    fill(#1ed760);
    text(">", width/2*1.17, height/6.5);

    if (screen == 0) {
      if (mouseY < height/1.9 && mouseY > height/2.2 && mouseX < width/4*3 && mouseX > width/4) {
        mouseHover = 6;
      } else if (mouseY < height/1.12 && mouseY > height/1.28 && mouseX < width/4*3 && mouseX > width/4) {
        mouseHover = 7;
      }

      //Menu
      fill(#1ed760, 90);
      rect(width/2, height/3.38, width/1.3, height/15, 20, 20, 0, 0);
      if (mouseHover!=6)rect(width/2, height/2.007, width/3, height/18, 0, 0, 20, 20);
      else rect(width/2, height/2, width/2.8, height/17, 0, 0, 20, 20);
      rect(width/2, height/1.571, width/1.3, height/15, 20, 20, 0, 0);
      if (mouseHover!=7)rect(width/2, height/1.191, width/3, height/18, 0, 0, 20, 20);
      else rect(width/2, height/1.189, width/2.8, height/17, 0, 0, 20, 20);

      fill(#1ed760, 50);
      rect(width/2, height/2.5, width/1.3, height/7, 0, 0, 20, 20);
      rect(width/2, height/1.35, width/1.3, height/7, 0, 0, 20, 20);

      fill(55);
      text("Most played songs", width/2, height/3.4);
      if (mostPlayedSongs[0].length() < 34)text(mostPlayedSongs[0] + "\n" + songsList.get(mostPlayedSongs[0]) + " times!", width/2, height/2.55);
      else text(mostPlayedSongs[0].substring(0, 31) + "...\n" + songsList.get(mostPlayedSongs[0]) + " times!", width/2, height/2.55);
      if (mouseHover!=6)text("MORE", width/2, height/2.03);
      else text("MORE", width/2, height/2.02);

      text("Time and hours", width/2, height/1.57);
      text(totalListenTime+"min / "+ nf(totalListenTime/60, 0, 1)+"hrs / "+nf(totalListenTime/60/24f, 0, 1)+"days", width/2, height/1.31);
      text("Hours with most listens: "+ nf(int(mostListenedHours[0]), 2, 0)+" & "+nf(int(mostListenedHours[1]), 2, 0), width/2, height/1.41);
      if (mouseHover!=7)text("MORE", width/2, height/1.2);
      else text("MORE", width/2, height/1.195);
      
      //Songs played
    } else if (screen == 1){
      fill(#1ed760, 50);
      rect(width/2.45, height/3.38, width/1.8, height/10, 20, 0, 0, 20);
      fill(#1ed760, 90);
      rect(width/1.3, height/3.38, width/6, height/10, 0, 20, 20, 0);
    }
    
    //If not yet loaded data
  } else {
    text("Loading...", width/2, height/2);
    loadStats(m1, y1, m2, y2);
  }
}

void drawDateButtons(int x) {
  switch(x) {
  case 1:
    fill(#1ed760, 200);
    rect(width/5*1.6, height/6.5, width/10, height/17, 10);
    fill(#1ed760, 100);
    rect(width/5*2.35, height/6.5, width/6, height/17, 10);
    rect(width/5*3.35, height/6.5, width/10, height/17, 10);
    rect(width/5*4.1, height/6.5, width/6, height/17, 10);
    mouseHover=1;
    fill(50);
    text(tempText, width/5*1.6, height/6.6);
    text(nf(y1, 2, 0), width/5*2.35, height/6.6);
    text(nf(m2, 2, 0), width/5*3.35, height/6.6);
    text(nf(y2, 2, 0), width/5*4.1, height/6.6);
    break;
  case 2:
    fill(#1ed760, 200);
    rect(width/5*2.35, height/6.5, width/6, height/17, 10);
    fill(#1ed760, 100);
    rect(width/5*1.6, height/6.5, width/10, height/17, 10);
    rect(width/5*3.35, height/6.5, width/10, height/17, 10);
    rect(width/5*4.1, height/6.5, width/6, height/17, 10);
    mouseHover=2;
    fill(50);
    text(nf(m1, 2, 0), width/5*1.6, height/6.6);
    text(tempText, width/5*2.35, height/6.6);
    text(nf(m2, 2, 0), width/5*3.35, height/6.6);
    text(nf(y2, 2, 0), width/5*4.1, height/6.6);
    break;
  case 3:
    fill(#1ed760, 200);
    rect(width/5*3.35, height/6.5, width/10, height/17, 10);
    fill(#1ed760, 100);
    rect(width/5*1.6, height/6.5, width/10, height/17, 10);
    rect(width/5*2.35, height/6.5, width/6, height/17, 10);
    rect(width/5*4.1, height/6.5, width/6, height/17, 10);
    mouseHover=3;
    fill(50);
    text(nf(m1, 2, 0), width/5*1.6, height/6.6);
    text(nf(y1, 2, 0), width/5*2.35, height/6.6);
    text(tempText, width/5*3.35, height/6.6);
    text(nf(y2, 2, 0), width/5*4.1, height/6.6);
    break;
  case 4:
    fill(#1ed760, 200);
    rect(width/5*4.1, height/6.5, width/6, height/17, 10);
    fill(#1ed760, 100);
    rect(width/5*1.6, height/6.5, width/10, height/17, 10);
    rect(width/5*2.35, height/6.5, width/6, height/17, 10);
    rect(width/5*3.35, height/6.5, width/10, height/17, 10);
    mouseHover=4;
    fill(50);
    text(nf(m1, 2, 0), width/5*1.6, height/6.6);
    text(nf(y1, 2, 0), width/5*2.35, height/6.6);
    text(nf(m2, 2, 0), width/5*3.35, height/6.6);
    text(tempText, width/5*4.1, height/6.6);
    break;
  case 5:
    fill(#1ed760, 100);
    rect(width/5*1.6, height/6.5, width/10, height/17, 10);
    rect(width/5*2.35, height/6.5, width/6, height/17, 10);
    rect(width/5*3.35, height/6.5, width/10, height/17, 10);
    rect(width/5*4.1, height/6.5, width/6, height/17, 10);
    mouseHover=0;
    fill(50);
    text(nf(m1, 2, 0), width/5*1.6, height/6.6);
    text(nf(y1, 2, 0), width/5*2.35, height/6.6);
    text(nf(m2, 2, 0), width/5*3.35, height/6.6);
    text(nf(y2, 2, 0), width/5*4.1, height/6.6);
    break;
  }
}

// MOUSE PRESSED --------------------------------------------------------------------------
void mousePressed() {
  if (mouseHover > 0 && mouseHover < 5) {
    if (selected!=0) {
      switch(selected) {
      case 1:
        m1=int(tempText);
        break;
      case 2:
        y1=int(tempText);
        break;
      case 3:
        m2=int(tempText);
        break;
      case 4:
        y2=int(tempText);
        break;
      }
      tempText = "";
    }
    selected=mouseHover;
  } else if (mouseHover <= 0) {
    if (selected!=0) {
      switch(selected) {
      case 1:
        m1=int(tempText);
        break;
      case 2:
        y1=int(tempText);
        break;
      case 3:
        m2=int(tempText);
        break;
      case 4:
        y2=int(tempText);
        break;
      }
      tempText = "";
    }
    selected = 0;
  } else if (mouseHover == 5) {
    loaded = false;
    loadStats(m1, y1, m2, y2);
  } else if (mouseHover == 6) {
    screen = 1;
  } else if (mouseHover == 7) {
    screen = 2;
  }
}

// KEY PRESSED ----------------------------------------------------------------------------
void keyPressed() {
  if (selected > 0 && key >= 48 && keyCode <= 57 && tempText.length() < maxLength())tempText+=key;
}

int maxLength () {
  if (selected == 1 || selected == 3)return 2;
  else return 4;
}

// LOAD STATS -----------------------------------------------------------------------------
void loadStats(int a, int b, int c, int d) {

  totalListenTime = 0;
  songsList.clear();
  timesList.clear();

  //FIND RANGE INDEXES
  //Find range start
  int start = 0, end = 0;
  temp = 0;
  while (temp < listenHistory.size() && temp >= 0) {
    song = listenHistory.getJSONObject(temp);
    if (int(song.getString("endTime").substring(0, 4))>=b && int(song.getString("endTime").substring(5, 7))>=a) {
      start = temp;
      temp = -2;
    }
    temp++;
  }
  //Find range end
  temp = 0;
  while (temp < listenHistory.size() && temp >= 0) {
    song = listenHistory.getJSONObject(temp);
    if (int(song.getString("endTime").substring(0, 4))>d || (int(song.getString("endTime").substring(0, 4))==d && int(song.getString("endTime").substring(5, 7))>c)) {
      end = temp-1;
      temp = -2;
    }
    temp++;
  }
  if (temp >= 0)end = listenHistory.size()-1;

  for (int i = start; i <= end; i++) {
    song = listenHistory.getJSONObject(i);
    totalListenTime += song.getInt("msPlayed");
    if (song.getInt("msPlayed")>1000) {
      timesList.add(song.getString("endTime").substring(11, 13), 1);
      songsList.add(song.getString("trackName"), 1);
    }
  }

  //Calculate stats
  totalListenTime = totalListenTime/1000/60;

  songsList.sortValuesReverse();
  mostPlayedSongs = songsList.keyArray();

  timesList.sortValuesReverse();
  mostListenedHours = timesList.keyArray();

  loaded = true;
}
