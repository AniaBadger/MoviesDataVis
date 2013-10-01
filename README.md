MoviesDataVis
=============

User Instructions:<br/>
<br/>
To use the application one must be connected to the internet.<br/>
For the application to read from a saved xml file, one must change the absolute path to the file in tab fixXML line 25. Explanation: I pull data from various movie APIs as XML. One of them works fine in browsers, but when called from Processing using loadXML(), it returns 403 Forbidden error. To overcome that I constructed my own url connection method that changes user-agent and http.agent properties to imitate browsers. I then save the result in the xml file on my disk using: FileOutputStream fos = new FileOutputStream("C:/Users/Ania/Documents/Processing/coursework/data/chosenMovie.x ml"); The problem is that Processing is saving this file inside the folder that Processing runs from, when only the name of file is specified. To be able to load it in my sketch using XML xml = loadXML("chosenMovie.xml"); chosenMovie.xml needs to be inside the data folder of the specific sketch. It works fine when I give the absolute path to the output stream, as given above, but FileOutputStream doesn't work with any relative paths.<br/>
<br/>
The App does not work at the moment as one of the IMDB APIs - imdbapi.org - has been shut down.
