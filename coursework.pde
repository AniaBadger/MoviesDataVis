import java.io.*;                    // For xml file saving.
import java.net.URL;                 // For xml file saving.
import java.net.URLConnection;       // For xml file saving.
import java.text.NumberFormat;       // For debugging.
import org.gicentre.utils.gui.*;     // For text input.
import org.gicentre.utils.stat.*;    // For chart classes.
import org.gicentre.utils.colour.*;  // For colour tables.
import java.net.URI;                 // For quering the movie APIs.
import controlP5.*;                  // For dropdown.

// Main tabs variables.
float[] tabXPos, tabYPos;
int tabWidth, tabHeight;
color tabInactive, tab1c, tab2c, tab3c, tabHover, inputColour;
int tab;
int tabToHighlight;
PImage tab1, tab2, tab3;

// Search area in tab 1 variables.
TextInput textInput;
String searchPhrase, imdbID, title, year, type;
XML[] movies;
URI uri;

// Error messages in tab 1 variables.
color errorColour = #ff0000;
boolean moviesNotFound;
boolean notEnoughData;
boolean noFreeSlots;

// Dropdown in tab 1 variables.
ControlP5 cp5;
DropdownList d1;
String[] movieList;
int resultsCount;

// General display variables.
int margin;
int gap;

// Font variables.
PFont levenimMT, impact, calibri;

// Chosen movies in tab 1 variables.
float[] movieBoxXPos, movieBoxYPos;
int movieBoxWidth, movieBoxHeight;
color movieBoxColour;
int posterWidth, posterHeight;
PImage defaultPoster;

// Deletion of a chosen movie in tab 1 variables.
float[] deleteXPos, deleteYPos;
int deleteSize;
color deleteColour = #ff0000;
int deleteToHighlight;
PImage remove;

// Chosen movies variables.
Movie[] chosenMovies;
Movie movie0, movie1, movie2, movie3, movie4, movie5, movie6, movie7, movie8, movie9;

// Awards vs. Opening weekend gross plot in tab 2 variables.
XYChart awardsPlot;
float[] colours;        // Point colours.
float[] nominationsData;
float[] awardsData;
float[] oscarsData;
float[] openingGrossData;
String[] movieTitles;
ColourTable cTable;
int moviesCount;
int awardsPlotWidth, awardsPlotHeight, awardsPlotMargin;
color legend;

// Awards vs. Opening weekend gross plot filter side tabs in tab 2 variables.
float[] filterXPos, filterYPos;
int filterWidth, filterHeight;
color filterColour, filterChosen, filterHover;
String filter;
int filterToHighlight;
PImage nominationsImg, awardsImg, oscarsImg;

// Single movie weekly gross charts in tab 3 variables.
int grossChartWidth, grossChartHeight, grossChartGap, grossChartMargin;
color grossChartColour;
PImage grossText;
PImage grossNoData;

// Debugging text on/off.
boolean debug = false;

void setup()
{
  // Display app window.
  size(1280,720);
  
  // Set general display margin and gap.
  margin = 20;
  gap = 5;
  
  // Set main tabs variables.
  tabInactive = #999999;
  tab1c = #FFCC6C;
  tab2c = #FFCC6C;
  tab3c = #FFCC6C;
  tabHover = #666666;   
  tabWidth = 200;
  tabHeight = 30;  
  tabXPos = new float[] {margin,margin+tabWidth+gap,margin+(tabWidth*2)+(gap*2)};
  tabYPos = new float[] {margin,margin,margin};  
  tab1 = loadImage("tab1.png");
  tab2 = loadImage("tab2.png");
  tab3 = loadImage("tab3.png");
  tab = 1;
  tabToHighlight = -1;
  
  // Load fonts.
  levenimMT = loadFont("LevenimMT-25.vlw");
  impact = loadFont("Impact-30.vlw");
  calibri = loadFont("Calibri-30.vlw");
  
  // Set input variables.
  textInput = new TextInput(this, impact, 25);
  inputColour = #ffffff;
  
  // Set dropdown variables.
  cp5 = new ControlP5(this);
  cp5.setControlFont(new ControlFont(calibri, 15));
  d1 = cp5.addDropdownList("Search Results")
          .setPosition(100, 190)
          ;          
  customize(d1);
  
  // Set chosen movies area variables.  
  movieBoxWidth = 242;
  movieBoxHeight = 230;
  movieBoxColour = #ffffff;
  posterWidth = 131;
  posterHeight = 200;  
  defaultPoster = loadImage("film.png");
  defaultPoster.resize(posterWidth, posterHeight);  
  movieBoxXPos = new float[] {margin+(movieBoxWidth*0)+(gap*1),
                             margin+(movieBoxWidth*1)+(gap*2),
                             margin+(movieBoxWidth*2)+(gap*3),
                             margin+(movieBoxWidth*3)+(gap*4),
                             margin+(movieBoxWidth*4)+(gap*5),
                             
                             margin+(movieBoxWidth*0)+(gap*1),
                             margin+(movieBoxWidth*1)+(gap*2),
                             margin+(movieBoxWidth*2)+(gap*3),
                             margin+(movieBoxWidth*3)+(gap*4),
                             margin+(movieBoxWidth*4)+(gap*5)
                             };
  movieBoxYPos = new float[] {height-margin-(movieBoxHeight*2)-(gap*2),
                             height-margin-(movieBoxHeight*2)-(gap*2),
                             height-margin-(movieBoxHeight*2)-(gap*2),
                             height-margin-(movieBoxHeight*2)-(gap*2),
                             height-margin-(movieBoxHeight*2)-(gap*2),
                             
                             height-margin-(movieBoxHeight*1)-(gap*1),
                             height-margin-(movieBoxHeight*1)-(gap*1),
                             height-margin-(movieBoxHeight*1)-(gap*1),
                             height-margin-(movieBoxHeight*1)-(gap*1),
                             height-margin-(movieBoxHeight*1)-(gap*1)
                             };
  
  // Set deletion boxes variables.                           
  deleteSize = 20;                             
  deleteXPos = new float[] {margin+(movieBoxWidth*1)+(gap*1)-deleteSize,
                             margin+(movieBoxWidth*2)+(gap*2)-deleteSize,
                             margin+(movieBoxWidth*3)+(gap*3)-deleteSize,
                             margin+(movieBoxWidth*4)+(gap*4)-deleteSize,
                             margin+(movieBoxWidth*5)+(gap*5)-deleteSize,
                             
                             margin+(movieBoxWidth*1)+(gap*1)-deleteSize,
                             margin+(movieBoxWidth*2)+(gap*2)-deleteSize,
                             margin+(movieBoxWidth*3)+(gap*3)-deleteSize,
                             margin+(movieBoxWidth*4)+(gap*4)-deleteSize,
                             margin+(movieBoxWidth*5)+(gap*5)-deleteSize
                             };
  deleteYPos = new float[] {height-margin-(movieBoxHeight*2)-(gap*2),
                             height-margin-(movieBoxHeight*2)-(gap*2),
                             height-margin-(movieBoxHeight*2)-(gap*2),
                             height-margin-(movieBoxHeight*2)-(gap*2),
                             height-margin-(movieBoxHeight*2)-(gap*2),
                             
                             height-margin-(movieBoxHeight*1)-(gap*1),
                             height-margin-(movieBoxHeight*1)-(gap*1),
                             height-margin-(movieBoxHeight*1)-(gap*1),
                             height-margin-(movieBoxHeight*1)-(gap*1),
                             height-margin-(movieBoxHeight*1)-(gap*1)
                             };
  deleteToHighlight = -1;
  remove = loadImage("remove.png");
  
  // Set chosen movies array and populate it with 10 Movie objects.
  chosenMovies = new Movie[10];  
  movie0 = new Movie(); movie0.setTaken(false);
  movie1 = new Movie(); movie1.setTaken(false);
  movie2 = new Movie(); movie2.setTaken(false);
  movie3 = new Movie(); movie3.setTaken(false);
  movie4 = new Movie(); movie4.setTaken(false);
  movie5 = new Movie(); movie5.setTaken(false);
  movie6 = new Movie(); movie6.setTaken(false);
  movie7 = new Movie(); movie7.setTaken(false);
  movie8 = new Movie(); movie8.setTaken(false);
  movie9 = new Movie(); movie9.setTaken(false);  
  chosenMovies[0] = movie0;   chosenMovies[1] = movie1;
  chosenMovies[2] = movie2;   chosenMovies[3] = movie3;
  chosenMovies[4] = movie4;   chosenMovies[5] = movie5;
  chosenMovies[6] = movie6;   chosenMovies[7] = movie7;
  chosenMovies[8] = movie8;   chosenMovies[9] = movie9;  
  
  // Set awards vs. opening weekend gross area variables.
  cTable = ColourTable.getPresetColourTable(ColourTable.PAIRED_10);
  awardsPlotMargin = 10;
  awardsPlotWidth = width-margin*2-awardsPlotMargin*2;
  awardsPlotHeight = 400;
  legend = #000000;
  
  // Set variables for awards vs. opening weekend gross area filter tabs.
  filterColour = #999999;
  filterChosen = #FFCC6C;  
  filterWidth = 200;
  filterHeight = 30;  
  filterXPos = new float[] {width-margin-awardsPlotMargin*2-filterWidth,
                            width-margin-awardsPlotMargin*2-filterWidth,
                            width-margin-awardsPlotMargin*2-filterWidth
                            };
  filterYPos = new float[] {margin+tabHeight+awardsPlotMargin*2+awardsPlotHeight+(filterHeight*0)+(awardsPlotMargin*0),
                            margin+tabHeight+awardsPlotMargin*2+awardsPlotHeight+(filterHeight*1)+(awardsPlotMargin*1),
                            margin+tabHeight+awardsPlotMargin*2+awardsPlotHeight+(filterHeight*2)+(awardsPlotMargin*2)
                            };  
  filter = "nominations";
  filterToHighlight = -1;
  nominationsImg = loadImage("nominations.png");
  oscarsImg = loadImage("oscars.png");
  awardsImg = loadImage("awards.png");
  
  // Set weekly gross charts variables.
  grossChartWidth = 242;
  grossChartHeight = 317;
  grossChartColour = #ffffff;
  grossText = loadImage("gross.png");
  grossNoData = loadImage("grossNoData.jpg");
  
  // Set error messages variables.
  moviesNotFound = false;
  notEnoughData = false;
  noFreeSlots = false;
}

void draw()
{
  // Set background colour.
  background(#cccccc);
  
  // Count chosen movies.   
  moviesCount = countChosenMovies();
  
  // Set colour array.
  colours = new float[moviesCount];
  setColours(moviesCount);
  
  // Select colours for main tabs depending on which tab is active.
  for (int i=0; i<tabXPos.length; i++)
  {
    // Draw tabs.
    if ((i == 0) && (tab == 1)) { // tab1 selected condition
      fill(tab1c);
    } else if ((i == 1) && (tab == 2)) { // tab2 selected condition
      fill(tab2c);
    } else if ((i == 2) && (tab == 3)) { // tab3 selected condition
      fill(tab3c);
    } else { // tab not selected
      fill(tabInactive); 
    }
    
    // Draw main tabs.
    rect(tabXPos[i], tabYPos[i], tabWidth, tabHeight);
    
    // Draw tabs' text.
    if (i == 0) {
      image(tab1, tabXPos[i], tabYPos[i]);
    } else if (i == 1) {
      image(tab2, tabXPos[i], tabYPos[i]);
    } else if (i == 2) {
      image(tab3, tabXPos[i], tabYPos[i]);
    }

  // Display tabs content depending on which tab is active.
  if (tab == 1)
   {
     drawTab1();  
     
     // Display error messages if appropriate.
     if (moviesNotFound) {
       moviesNotFound();
     }
     if (notEnoughData) {
       notEnoughData();
     }
     if (noFreeSlots) {
       noFreeSlots();
     }
   }
   else if (tab == 2)
   {
     drawTab2();
   }
   else if (tab == 3)
   {
     drawTab3();
   }
  }
}

void mouseClicked()
{
  // Select tabs to be active when mouse is clicked.
  tabToHighlight = -1;
  for (int i=0; i<tabXPos.length; i++)
  {
    if (mouseX > tabXPos[i] && mouseX < tabXPos[i] + tabWidth && mouseY > tabYPos[i] && mouseY < tabYPos[i] + tabHeight)
    {
      tabToHighlight = i+1;
      
      if (tabToHighlight == 1) {
        tab = 1;
      } else if (tabToHighlight == 2) {
        tab = 2;
      } else if (tabToHighlight == 3) {
        tab = 3;
      }
    }
  }
  
  // When in tab 1.
  if (tab == 1) {
    
    // When delete button is clicked, remove chosen movie.
    deleteToHighlight = -1;
    for (int i=0; i<deleteXPos.length; i++)
    {
      if (mouseX > deleteXPos[i] && mouseX < deleteXPos[i] + deleteSize && mouseY > deleteYPos[i] && mouseY < deleteYPos[i] + deleteSize)
      {
        deleteToHighlight = i;
        chosenMovies[i].setTaken(false);
      }
    }
    
  }
  
  // When in tab 2.
  if (tab == 2) {
    
    // When specific filter button is clicked, set active filter variable. 
    filterToHighlight = -1;
    for (int i=0; i<filterXPos.length; i++)
    {
      if (mouseX > filterXPos[i] && mouseX < filterXPos[i] + filterWidth && mouseY > filterYPos[i] && mouseY < filterYPos[i] + filterHeight)
      {
        filterToHighlight = i+1;
        
        if (filterToHighlight == 1) {
          filter = "nominations";
        } else if (filterToHighlight == 2) {
          filter = "awards";
        } else if (filterToHighlight == 3) {
          filter = "oscars";
        }
      }
    }
  
  }
}

void keyPressed()
{
  // Search for movies when Enter key is pressed and in tab 1.
  if ((tab == 1) && ( (keyCode == RETURN) || (keyCode == ENTER) ))
  {
    searchPhrase = textInput.getText().toString();
    searchQuery(searchPhrase);
  }
  // Scroll down the dropdown scrollbar with DOWN key and in tab 1.
  else if ((tab == 1) && (keyCode == DOWN)) {
    if (d1 != null) {
      d1.scroll(0.5);
    }
  }
  else if (tab == 1)
  {
    // Transfer any key presses to the text input.
    textInput.keyPressed();
  }
}
