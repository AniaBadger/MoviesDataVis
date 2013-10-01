void drawChosenMovies() {
  // Display movie slot boxes in tab 1.
  for (int i=0; i<movieBoxXPos.length; i++)
  {
    fill(movieBoxColour);
    rect(movieBoxXPos[i], movieBoxYPos[i], movieBoxWidth, movieBoxHeight);
    
    // Display chosen movies inside slot boxes.
    if (chosenMovies[i].isTaken() == true) {
      
      PImage poster = chosenMovies[i].getPoster();
      image(poster, movieBoxXPos[i]+((movieBoxWidth-posterWidth)/2), movieBoxYPos[i]+gap);
      
      String title = chosenMovies[i].getTitle();
      fill(#000000);
      // If movie title is too long, make it smaller.
      if (textWidth(title) > movieBoxWidth-10) {
        textFont(calibri, 12);
        textAlign(LEFT,TOP);
        text(title,movieBoxXPos[i]+((movieBoxWidth-textWidth(title))/2), movieBoxYPos[i]+posterHeight+gap*2+4);
      } else {
        textFont(calibri, 15);
        textAlign(LEFT,TOP);
        text(title,movieBoxXPos[i]+((movieBoxWidth-textWidth(title))/2), movieBoxYPos[i]+posterHeight+gap*2+3);
      }
      textFont(calibri, 15);      
      
    } else { // If movie object is not taken, display default movie image.
      image(defaultPoster, movieBoxXPos[i]+((movieBoxWidth-posterWidth)/2), movieBoxYPos[i]+gap);
    }    
  }
  
  // Display deletion buttons with chosen movies only.
  for (int i=0; i<deleteXPos.length; i++)
  {
    if (chosenMovies[i].isTaken() == true) {      
      fill(deleteColour);
      rect(deleteXPos[i], deleteYPos[i], deleteSize, deleteSize);
      image(remove, deleteXPos[i], deleteYPos[i]);
    }
  }
   
}
