void drawSearch() {
  // Set text parameters.
  fill(#ffffff);
  textFont(impact);
  textAlign(CENTER,BOTTOM);
  
  // Display text and input area.
  text("Search for a movie:", width/2, margin+tabHeight+margin*2);
  fill(80);
  textInput.draw((width-textWidth(textInput.getText()))/2, margin+tabHeight+margin+30);  
}

