void drawLegend (int moviesCounter, String[] movieTitles, float[] colours) {
  
  float[] col = colours;
  String[] mt = movieTitles;
  int mc = moviesCounter;
  
  // Display the chosen movie title and its box colour.
  for (int i = 0; i < mc; i++) {
    int boxSize = 15;
    color c = cTable.findColour(col[i]);
    fill(c);
    noStroke();
    int y = margin+tabHeight+awardsPlotMargin+awardsPlotHeight+awardsPlotMargin+(boxSize*i)+(gap*i);
    rect(margin+awardsPlotMargin*3, y, boxSize, boxSize);
    textAlign(LEFT, TOP);
    textFont(calibri, 20);
    fill(legend);
    text(mt[i], margin+awardsPlotMargin*3+boxSize+gap*2, y+1);
  }
  
}
