void drawTab3()
{
  // Hide dropdown.
  cp5.hide();
  
  // Draw tab background.
  fill(tab3c);
  noStroke();
  rect(margin,margin+tabHeight,width-margin*2,height-(margin*2)-tabHeight);  
  
  if (moviesCount > 0) { // If at least 1 movie has been selected.
    
    int counter = 0;    
    
    // Draw graphs background boxes.
    for (int i = 0; i < chosenMovies.length; i++) {      
      int xPos = 0;
      int yPos = 0;      
      if (i < 5) {
        xPos = margin+(gap*(i+1)+(grossChartWidth*i));
        yPos = margin+tabHeight+gap;
      } else {
        xPos = margin+(gap*((i-5)+1)+(grossChartWidth*(i-5)));
        yPos = height-margin-gap-grossChartHeight;
      }      
      fill(grossChartColour);
      rect(xPos, yPos, grossChartWidth, grossChartHeight);
      
      // Draw chosen movies weekly gross charts.
      if (chosenMovies[i].isTaken() == true) {                
        drawGrossChart(chosenMovies[i], counter, xPos, yPos);
        
        // Display their titles underneath.
        String title = chosenMovies[i].getTitle();        
        fill(#000000);
        if (textWidth(title) > grossChartWidth-gap*2) { // If movie title is too long, make it smaller.
          textFont(calibri, 12);
          textAlign(LEFT,TOP);
          text(title,xPos+((grossChartWidth-textWidth(title))/2), yPos+grossChartHeight-gap-8);
        } else {
          textFont(calibri, 15);
          textAlign(LEFT,TOP);
          text(title,xPos+((grossChartWidth-textWidth(title))/2), yPos+grossChartHeight-gap-10);
        }
        textFont(calibri, 15);         
        counter++;
      }
      else { // Display default image.
        image(grossNoData, xPos, yPos);
      }
    }  
    
  } else {
    fill(#ffffff);
    textFont(impact, 20);
    text("NO DATA TO DISPLAY. PLEASE CHOOSE A MOVIE FIRST.",width*.5,height*.45); 
  } 
  
  // Display top right corner information text.
  image(grossText, width-margin-400, margin);
  
}
