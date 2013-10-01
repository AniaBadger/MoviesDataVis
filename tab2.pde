void drawTab2()
{
  // Hide dropdown.
  cp5.hide();
  
  // Draw tab background.
  fill(tab2c);
  noStroke();
  rect(margin,margin+tabHeight,width-margin*2,height-(margin*2)-tabHeight); 
  
  if (moviesCount > 0) { // If any movies are chosen.
    
    // Gather all infortantion needed for displaying Nominations graph, Awards graph and Oscars graph.  
    gatherAwardsPlotInfo(moviesCount); 
    getMovieTitles(moviesCount);
    
    // Pick graph to display.    
    if (filter.equals("nominations")) {
      String yLabel = "Number of Nominations";
      drawAwardsPlot(openingGrossData, nominationsData, yLabel);
    } else if (filter.equals("awards")) {
      String yLabel = "Number of Awards Won";
      drawAwardsPlot(openingGrossData, awardsData, yLabel);
    } else if (filter.equals("oscars")) {
      String yLabel = "Number of Oscars Won";
      drawAwardsPlot(openingGrossData, oscarsData, yLabel);
    }  
    
    // Display legend.  
    fill(legend);
    textFont(calibri, 20);
    drawLegend(moviesCount, movieTitles, colours);
    
    // Display filter tabs.
    drawFilterTabs();
  } else {
    fill(#ffffff);
    textFont(impact, 20);
    text("NO DATA TO DISPLAY. PLEASE CHOOSE A MOVIE FIRST.",width*.5,height*.45); 
  }
  
}

