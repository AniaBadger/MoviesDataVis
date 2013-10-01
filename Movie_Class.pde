class Movie {   
  // Movie object variables.
  private boolean taken;
  
  private PImage poster;
  private String title, year, director, country;
  private float nominations, awards, oscars;
  private float openingGross;
  private float[] weeklyGross;
  
  // Constructor.
  Movie() {      
  }
  
  // Set and get taken property (When taken is set to false - a new movie data can be loaded into it).
  void setTaken(boolean t) {
    taken = t;
  }
  boolean isTaken() {
    return taken;
  }
  
  // Set and get weekly gross array.
  void setWeeklyGross(float[] wg){
    weeklyGross = wg;
  }
  float[] getWeeklyGross() {
    return weeklyGross;
  }
  
  // Set and get movie poster image.
  void setPoster(String url) {
    poster = loadImage(url);
    poster.resize(posterWidth, posterHeight);
  }  
  PImage getPoster() {
    return poster;
  }
  
  // Set and get movie title.
  void setTitle(String t) {
    title = t;
  }  
  String getTitle() {
    return title;
  }
  
  // Set and get movie year.
  void setYear(String y) {
    year = y;
  }  
  String getYear() {
    return year;
  }
  
  // Set and get movie director.
  void setDirector(String d) {
    director = d;
  }  
  String getDirector() {
    return director;
  }
  
  // Set and get movie country.
  void setCountry(String c) {
    country = c;
  }  
  String getCountry() {
    return country;
  }
  
  // Set and get movie opening weekend gross.
  void setOpeningGross(float og) {
    openingGross = og;
  }  
  float getOpeningGross() {
    return openingGross;
  }
  
  // Set and get number of nominations.
  void setNominations(float n) {
    nominations = n;
  }  
  float getNominations() {
    return nominations;
  }
  
  // Set and get number of awards.
  void setAwards(float a) {
    awards = a;
  }  
  float getAwards() {
    return awards;
  }
  
  // Set and get number of oscars.
  void setOscars(float o) {
    oscars = o;
  }  
  float getOscars() {
    return oscars;
  }
  
} 
