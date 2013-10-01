void drawTab1()
{  
  // Show dropdown.
  cp5.show();
  
  // Draw tab background.
  fill(tab1c);
  noStroke();
  rect(margin,margin+tabHeight,width-margin*2,height-(margin*2)-tabHeight);
  
  // Draw input box background.
  fill(inputColour);
  rect(250,margin+tabHeight+margin+25,width-500,32);
  
  // Dipslay search and chosen movies.
  drawSearch();  
  drawChosenMovies();
  
}
