void searchQuery(String searchPhrase)
{  
  // Set uri to query.
  try {
    uri = new URI(
      "http", 
      "www.omdbapi.com", 
      "/",
      "s=" + searchPhrase + "&r=XML",
      null);
  } catch (Exception e) {
    println(e);
    println(uri.toString());
  }
  
  // Convert it to string.
  String query = uri.toASCIIString();
  
  if(debug == true) { println(query); }
  
  // Load xml and get response value.
  XML xml = loadXML(query); 
  String response = xml.getString("response");
  
  // Switch the moviesNotFound error message off.
  moviesNotFound = false;
  
  if (response.equals("True")) { // Draw search results.
    movies = xml.getChildren("Movie"); 
    drawSearchResults();   
  } else { // Display moviesNotFound error message.
    notEnoughData = false;
    noFreeSlots = false;
    moviesNotFound = true;
  }
}


void movieQuery(String movieID, Movie myMovie)
{  
  // Set uri to query.
  try {
    uri = new URI(
      "http", 
      "imdbapi.org", 
      "/",
      "id=" + movieID + "&type=xml&plot=simple&episode=0&lang=en-US&aka=simple&release=simple&business=1&tech=0",
      null);
  } catch (Exception e) {
    println(e);
    println(uri.toString());
  }
  
  // Convert it to string.
  String query = uri.toASCIIString();
  
  // Save xml result as file
  fixXML(query);
  
  if(debug == true) { println(query); }
  
  // Read xml result from file.
  XML xml = loadXML("chosenMovie.xml"); 
  
  // If read successful.
  if (xml.getChild("imdb_id") != null) { 
    
    // Get chosen movie's year and title.
    myMovie.setYear(xml.getChild("year").getContent());
    myMovie.setTitle(xml.getChild("title").getContent());
    
    // Get poster URL.
    if (xml.getChild("poster") != null) {    
      myMovie.setPoster(xml.getChild("poster").getContent());
    } else { // If doesn't exist, set it to default one.
      myMovie.setPoster("http://i.media-imdb.com/images/SFaa265aa19162c9e4f3781fbae59f856d/nopicture/medium/film.png");
    }
    
    // Get movie director. Some movies have multiple directors. Separate them by a comma and a space.
    XML[] tmp = xml.getChild("directors").getChildren("item");
    String directors = "";
    for (int i = 0; i < tmp.length; i++)
    {
      directors = directors + tmp[i].getContent() + ", ";
    }
    directors = directors.substring(0, directors.length() - 2);
    myMovie.setDirector(directors);
    
    // Switch the notEnoughData error message off. 
    notEnoughData = false;
    
    // Check if the movie has business data at all, then if it has opening weekend gross data and weekly gross data.
    if ((xml.getChild("business") != null) && (xml.getChild("business").getChild("opening_weekend") != null) && (xml.getChild("business").getChild("gross") != null)) {

      // Opening weekend values look like $27,788,331. Use replaceAll to strip out everything but digits, then convert to float.
      String og = xml.getChild("business").getChild("opening_weekend").getChild("item").getChild("money").getContent().replaceAll("[^\\d.]+", "");
      myMovie.setOpeningGross(Float.parseFloat(og));    
    
      // Weekend takings are in reverse chronological order in the XML response. Put the gross values in an array and then go through it in reverse to add it to the Movie object.
      // First get the items.
      tmp = xml.getChild("business").getChild("gross").getChildren("item");
      
      // Get country of first weekly gross item.
      String grossCountry = tmp[0].getChild("country").getContent();
      // Create temporary array.
      float[] gross = new float[tmp.length];
      // Create counter of items added.
      int j = 0;
      for (int i = 0; i < tmp.length; i++) {
        if(tmp[i].getChild("country").getContent().equals(grossCountry)) { // Check if the item has the same country as the first item (IMDB gives you the weekly gross not only from one country, but multiple countries and cumulated worldwide data)
        
          // Weekend box office values look like $27,788,331.  Use replaceAll() to strip out everything but digits, then convert to float.
          String money = tmp[i].getChild("money").getContent().replaceAll("[^\\d.]+", "");
          gross[j] = Float.parseFloat(money)/1000000; // Divie the value by 1.000.000 so it can be displayed in millions.
          j++;
        }
      }
      
      // Check if there is more than just 1 Weekly gross entry to prevent XYChart error.
      if (j > 1) {
      
        float[] newWeeklyGross = new float[j];
        
        // Copy data from temp array and put the data in reverse (correct) order.
        for (int i = 0; i < newWeeklyGross.length; i++) {
          j--;
          newWeeklyGross[i] = gross[j];
          if(debug == true) { System.out.println("Week " + i + " gross: " + newWeeklyGross[i]); }
        }
        
        // Set weekly gross array in the Movie object.
        myMovie.setWeeklyGross(newWeeklyGross);
        
        // Proceed to awards query.
        awardsQuery(movieID, myMovie);
      
      } else { // If movie doesn't have enough data for graphing, display notEnoughData error and set the movie object free.
        moviesNotFound = false;
        noFreeSlots = false;
        notEnoughData = true;
        myMovie.setTaken(false);
      }
      
    } else { // If movie doesn't have enough data for graphing, display notEnoughData error and set the movie object free.
      moviesNotFound = false;
      noFreeSlots = false;
      notEnoughData = true;
      myMovie.setTaken(false);
    }
    
  }
  else {
    System.out.println("ERROR: Couldn't load XML file.");
  }

  if(debug == true) {
    System.out.println("Year: " + myMovie.getYear());
    System.out.println("Title: " + myMovie.getTitle());
    //  We don't actually store the poster URL in the Movie object so print out the dimensions of the image instead.
    System.out.println("Poster image dimensions: " + myMovie.getPoster().width + " x " + myMovie.getPoster().height);
    System.out.println("Director(s): " + myMovie.getDirector());
    System.out.println("Opening weekend: " + myMovie.getOpeningGross());
  }
  
}


void awardsQuery(String movieID, Movie myMovie)
{  
  try {
    uri = new URI(
      "http", 
      "imdbapi.ladadadada.net", 
      "/webService.php",
      "m=" + movieID + "&o=xml",
      null);
  } catch (Exception e) {
    println(e);
    println(uri.toString());
  }
    
  String query = uri.toASCIIString();
  
  if (debug == true) { println(query); }
  
  fixXML(query);
  
  //XML xml = loadXML(query); 
  XML xml = loadXML("chosenMovie.xml");
  //println("loaded file");
  //String response = xml.getString("response");
  //println(response);
  
  //String error = xml.getChild("ERROR").getContent();
  
  if (xml.getChild("TITLE_ID") != null) { 
    // Add the retrieved details to the Movie.
    // The XML response contains an empty string instead of 0 if no Oscars were won.
    String oscars = xml.getChild("OSCARS").getContent();
    if (oscars.equals("")) {
      oscars = "0";
    }
    //oscars += "F";
    myMovie.setOscars(Float.parseFloat(oscars));
    
    // Repeat the above pattern for awards and nominations.
    
    String awards = xml.getChild("AWARDS").getContent();
    if (awards.equals("")) {
      awards = "0";
    }
    float awardsFloat = Float.parseFloat(awards);
    myMovie.setAwards(awardsFloat);
    
    String nominations = xml.getChild("NOMINATIONS").getContent();
    if (nominations.equals("")) {
      nominations = "0";
    }
    float nominationsFloat = Float.parseFloat(nominations);
    nominationsFloat += awardsFloat;
    myMovie.setNominations(nominationsFloat);
  } else {
    System.out.println("ERROR: Couldn't load XML file.");
  }

  if(debug == true) {
    println("Oscars: "+ myMovie.getOscars());
    println("Awards: "+ myMovie.getAwards());
    println("Nominations: "+ myMovie.getNominations());
  }
  
}
