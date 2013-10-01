void drawSearchResults() {  
  // First clear the dropdown from previous search results.
  d1.clear();
  
  // Create string array to save movies' imdb ids.
  movieList = new String[movies.length];
  
  // Create resultsCount var to display number of movies found.
  resultsCount = 0;
  
  // Exctact data from search query result and save it to display in dropdown.
  for (int i = 0; i < movies.length; i++) {
    if (movies[i].getString("Type").equals("movie")) {
      
      String t = movies[i].getString("Title");
      String y = movies[i].getString("Year");
      String id = movies[i].getString("imdbID");
      
      String item = t + ", " + y;
      
      resultsCount++;
      
      // Add string to dropdown.
      d1.addItem(resultsCount + ": " + item, i);
      // Add imdb id to array.
      movieList[i] = id;     
    }
  }    
  // Make dropdown list pretty.
  customize(d1);
}

void customize(DropdownList ddl) { // A convenience function to customize a DropdownList.  
  ddl.setBackgroundColor(color(190));  
  ddl.setWidth(width-200);
  ddl.setHeight(440);
  ddl.setItemHeight(40);
  ddl.setBarHeight(40);
  ddl.captionLabel().set("Search Results (" + resultsCount + ")");
  ddl.captionLabel().style().marginTop = 15;
  ddl.valueLabel().style().marginTop = 15;
  ddl.setColorBackground(color(#999999));
  ddl.setColorActive(color(#cccccc));
  ddl.setColorForeground(color(#444444));
}

void controlEvent(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.

  if (theEvent.isGroup()) { // check if the Event was triggered from a ControlGroup    
    if(debug == true) { println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup()); }
    
    // Get item chosen by the user from dropdown list.
    int itemChosen = int(theEvent.getGroup().getValue());
    
    if(debug == true) { println("Chosen item : "+ movieList[itemChosen]); } 
    
    // Add chosen movie by its imdb id saved in movieList array.
    addMovie(movieList[itemChosen]);

  } 
  else if (theEvent.isController()) {    
    if(debug == true) { println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController()); }
  }
}
