Movie getFreeMovie ()
{
  Movie myMovie = null;  
  noFreeSlots = false;
  
  // Get a movie object with taken parameter set to false.
  for (int i = 0; i < chosenMovies.length && myMovie == null; i++)
  {
    if (chosenMovies[i].isTaken() == false)
    {
      myMovie = chosenMovies[i];
      myMovie.setTaken(true); // When found - set it to true.
    }
  }  
  return myMovie;
}

void addMovie (String movieID)
{  
  // Find free movie object to add a new movie.
  Movie myMovie = getFreeMovie();
  
  // If there is no free objects left, display noFreeSlots error message.
  if(myMovie == null)
  {
    moviesNotFound = false;
    notEnoughData = false;
    noFreeSlots = true;       
  } else {  // Get data about the movie chosen.
    movieQuery(movieID, myMovie);
  }  
}

// Method that counts chosen movies.
int countChosenMovies() {
  int counter = 0;    
  for (int i = 0; i < chosenMovies.length; i++) {
    if (chosenMovies[i].isTaken() == true) {
      counter++;
    }
  }  
  return counter;  
}

// Method that sets colours to chosen movies.
void setColours(int moviesCount) {
    int mc = moviesCount;
    if (mc > 0) {
      for (int i = 0; i < mc; i++) {
        colours[i] = i+1;
      }
    }
}
