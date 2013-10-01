void drawGrossChart(Movie movie, int movieColour, int xPos, int yPos) {
  
  // Create the chart.
  XYChart grossChart = new XYChart(this);
  
  // Prepare X and Y data to display
  float[] grossData = movie.getWeeklyGross();  
  float[] weeksData = new float[grossData.length];
  
  int counter = 0;
  
  for (int i = 0; i < grossData.length; i++) {
    weeksData[i] = (float)i+1;
  }
  
  // Store data in the chart.
  grossChart.setData(weeksData,grossData);
  
  // Set up chart's appearance. 
  grossChart.setMinX(1);
  grossChart.setMinY(0);  
  grossChart.showXAxis(true);
  grossChart.showYAxis(true);  
  grossChart.setYFormat("$###,###");
  //grossChart.setXAxisLabel("Number of Weeks");
  //grossChart.setYAxisLabel("Gross (1,000,000s)");  
  color c = cTable.findColour(colours[movieColour]);
  grossChart.setPointColour(c);
  grossChart.setPointSize(5);
  grossChart.setLineWidth(2);
  
  // Draw chart.
  grossChart.draw(xPos+gap, yPos+gap, grossChartWidth-gap, grossChartHeight-25);  
}
