void gatherAwardsPlotInfo(int moviesCount) {
  
  int mc = moviesCount;
  
  // Create fresh array for graph data.
  nominationsData = new float[mc];
  awardsData = new float[mc];
  oscarsData = new float[mc];
  openingGrossData = new float[mc];
  movieTitles = new String[mc];  
  
  int counter = 0;
  
  // Populate them with data from chosen movies.
  for (int i = 0; i < chosenMovies.length; i++) {
    if (chosenMovies[i].isTaken() == true) {
      nominationsData[counter] = chosenMovies[i].getNominations();
      awardsData[counter] = chosenMovies[i].getAwards();
      oscarsData[counter] = chosenMovies[i].getOscars();
      openingGrossData[counter] = chosenMovies[i].getOpeningGross();
      movieTitles[counter] = chosenMovies[i].getTitle();
      counter++;
    }
  }
}

// Save chosen movies titles to display in legend and weekly gross tab (tab 3).
void getMovieTitles(int moviesCount) {
  
  int mc = moviesCount;
  movieTitles = new String[mc];    
  int counter = 0;
  
  for (int i = 0; i < chosenMovies.length; i++) {
    if (chosenMovies[i].isTaken() == true) {
      movieTitles[counter] = chosenMovies[i].getTitle();
      counter++;
    }
  }
}

void drawFilterTabs() {
  for (int i=0; i<filterXPos.length; i++)
  {
    // Draw filter tabs.
    if ((i == 0) && (filter.equals("nominations"))) { // nominations selected condition
      fill(filterChosen);
    } else if ((i == 1) && (filter.equals("awards"))) { // awards selected condition
      fill(filterChosen);
    } else if ((i == 2) && (filter.equals("oscars"))) { // oscars selected condition
      fill(filterChosen);
    } else { // tab not selected
      fill(filterColour); 
    }
    
    rect(filterXPos[i], filterYPos[i], filterWidth, filterHeight);
    
    if (i == 0) {
      image(nominationsImg, filterXPos[i], filterYPos[i]);
    } else if (i == 1) {
      image(awardsImg, filterXPos[i], filterYPos[i]);
    } else if (i == 2) {
      image(oscarsImg, filterXPos[i], filterYPos[i]);
    }
  }
}


void drawAwardsPlot(float[] xData, float[] yData, String yLabel) {
  
  // Create the plot.
  awardsPlot = new XYChart(this);
  
  // Store data in the plot.
  awardsPlot.setData(xData,yData);
  
  // Calculate the sum of awards and sum of opening weekend gross from the xData and yData arrays 
  // - if one or both of them is 0, then I set the default X and Y ranges so the draw() method doesn't have to calculate it and fail in result.
  float xDataSum = 0;
  float yDataSum = 0;
  
  for (int i = 0; i < xData.length; i++) {
    xDataSum += xData[i];
  }
  
  for (int i = 0; i < yData.length; i++) {
    yDataSum += yData[i];
  }
  
  if (xDataSum == 0) {
    awardsPlot.setMinX(0);
    awardsPlot.setMaxX(1000);
  } else {
    awardsPlot.setMinX(0);
  }
  
  if (yDataSum == 0) {
    awardsPlot.setMinY(0);
    awardsPlot.setMaxY(5);
  } else {
    awardsPlot.setMinY(0);
  }
  
  // Set up plot's appearance.   
  awardsPlot.showXAxis(true);
  awardsPlot.showYAxis(true);
  awardsPlot.setXFormat("$###,###");
  awardsPlot.setXAxisLabel("Opening Weekend Gross");
  awardsPlot.setYAxisLabel(yLabel);  
  awardsPlot.setPointColour(colours,cTable);
  awardsPlot.setPointSize(10);
  
  // Draw the background of the plot area.
  fill(movieBoxColour);
  noStroke();
  rect(margin+awardsPlotMargin, margin+tabHeight+awardsPlotMargin, awardsPlotWidth, height-margin*2-tabHeight-awardsPlotMargin*2);
  
  // Draw plot.
  awardsPlot.draw(margin+awardsPlotMargin*2, margin+tabHeight+awardsPlotMargin, awardsPlotWidth-awardsPlotMargin*2, awardsPlotHeight);
}
