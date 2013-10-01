// I hope these methods are pretty clear and don't need explainations.

void moviesNotFound() {
  fill(errorColour);
  textFont(impact, 20);
  textAlign(CENTER,BOTTOM);
  text("No movies found. Please try a different search phrase.",width*.5, 220);
}

void notEnoughData() {
  fill(errorColour);
  textFont(impact, 20);
  textAlign(CENTER,BOTTOM);
  text("This movie doesn't have enough data needed for this application to display.",width*.5, 220);
}

void noFreeSlots() {
  fill(errorColour);
  textFont(impact, 20);
  textAlign(CENTER,BOTTOM);
  text("Please remove a movie to add a new one.",width*.5, 220);
}


