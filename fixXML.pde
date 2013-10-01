void fixXML(String query) {  
  // Initialise reader and writer objects. 
  BufferedReader reader = null;
  Writer w = null;
  
  try {
    // Get xml query url and save it as URL object.
    URL url = new URL(query);
    boolean firstLine = true;
    
    // Create connection object.
    URLConnection c = url.openConnection();
    
    // Imitate the browser when sending request to xml query url to prevent 403 error.
    System.setProperty("http.agent", "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.4; en-US; rv:1.9.2.2) Gecko/20100316 Firefox/3.6.2");
    c.setRequestProperty("User-Agent", "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.4; en-US; rv:1.9.2.2) Gecko/20100316 Firefox/3.6.2");
    
    // Establish connection.
    c.connect();
    
    // Get data from connection response.
    reader = new BufferedReader(new InputStreamReader(c.getInputStream(), "UTF-8"));
    
    // Create file to save the output. Please change the absolute path HERE:
    FileOutputStream fos = new FileOutputStream("C:/Users/Ania/Documents/Processing/coursework/data/chosenMovie.xml");
    w = new BufferedWriter(new OutputStreamWriter(fos, "Cp1252"));
    
    // Read data line by line and save it to the file.
    for (String line; (line = reader.readLine()) != null;) {
      if (firstLine) { // Sometimes xml output comes back corrupted in the 1st line of the code - remove corruption if it happens.
        line = removeUTF8BOM(line);
        firstLine = false;
      }
      w.write(line + System.getProperty("line.separator"));
      w.flush();      
    }

  }
  catch (Exception e) {
      e.printStackTrace();
      //System.exit(1);
  } finally {
      if (reader != null) try { reader.close(); } catch (IOException ignore) {}
      if (w != null) try { w.close(); } catch (IOException ignore) {}
  }
  
}

String removeUTF8BOM(String s) {
    if (s.startsWith("\uFEFF")) { // Remove currupted bits from the first line if there are any.
        s = s.substring(1);
    }
    return s;
}
