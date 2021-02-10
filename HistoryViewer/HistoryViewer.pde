JSONArray listenHistory;
JSONObject song;
int totalListenTime = 0, temp = 0, temp2 = 0, mouseHover = 0, selected = 0;
int m1 = 1, y1 = 2020, m2 = 1, y2 = 2021;
String tempText = "";
String[] mostPlayedSongs, mostListenedHours;
IntDict songsList = new IntDict(), timesList = new IntDict();

PImage bg;
PFont font;

boolean loaded = false;

void setup() {
  size(600, 800);
  rectMode(CENTER);
  bg = loadImage("bg.png");
  background(bg);
  textAlign(CENTER, CENTER);
  //font = createFont("ALGER.TTF", 35);
  font = createFont("ARLRDBD.TTF", 25);
  textFont(font);
  fill(#1ed760);
  text("Loading...", width/2, height/2);
  noStroke();
  listenHistory = loadJSONArray("StreamingHistory0.json");
  loadStats(m1, y1, m2, y2);
}

// DRAW -----------------------------------------------------------------------------------
void draw() {
  background(bg);
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
  fill(#1ed760);
  text(">", width/2*1.17, height/6.5);

  if (!loaded)text("Loading...", width/2, height/2);
  else {
    text(totalListenTime+"min / "+ nf(totalListenTime/60, 0, 1)+"hrs / "+nf(totalListenTime/60/24f, 0, 1)+"days", width/2, height/1.07);
    text("Most listened to time: "+ nf(int(mostListenedHours[0]), 2, 0)+" & "+nf(int(mostListenedHours[1]), 2, 0), width/2, height/1.12);
    text("Most played songs:\n"+ mostPlayedSongs[0] + ", " + songsList.get(mostPlayedSongs[0]) +"\n&\n"+ 
      mostPlayedSongs[1] + ", " + songsList.get(mostPlayedSongs[1]), width/2, height/1.8);
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
  if (mouseHover>0) {
    selected=mouseHover;
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
  } else {
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
  }
}

// KEY PRESSED ----------------------------------------------------------------------------
void keyPressed() {
  if (selected > 0 && key >= 48 && keyCode <= 57 && tempText.length() < maxLength(selected))tempText+=key;
}

int maxLength (int y) {
  if (selected == 1 || selected == 3)return 2;
  else return 4;
}

// LOAD STATS -----------------------------------------------------------------------------
void loadStats(int a, int b, int c, int d) {
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
