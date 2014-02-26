// TODO Remove
float fromPixelToPaperValue(float pixelValue, float sr_) {
  // normalize the pixel X,Y coordinates to the real paper sheet dimensions expressed in mm
  float paperValue = (pixelValue/sr_); 
  ;
  return paperValue;
}

// TODO Remove
void convertPixelLinesToPaperLines() {

  //  for (int i=0; i<pixelLines.size(); i++) {
  //    // converts the coordinates from pixel to paper values, adjusting for a different origin
  //    Line2D currentLine = pixelLines.get(i);
  //    float paperX1 = fromPixelToPaperValue(currentLine.a.x, sr)-pW/sr;
  //    float paperY1 = fromPixelToPaperValue(currentLine.a.y, sr)-pH/sr;  
  //    float paperX2  = fromPixelToPaperValue(currentLine.b.x, sr)-pW/sr;
  //    float paperY2  = fromPixelToPaperValue(currentLine.b.y, sr)-pH/sr;
  //    Line2D linePaper = new Line2D(new Vec2D(paperX1, paperY1), new Vec2D(paperX2, paperY2));
  //    paperLines.add(linePaper);
  //  }
}

void exportToGcode(ArrayList<ArrayList<PVector>> lines) {
  float scaleRatio = 1.0 / sketchWidth * paperWidth;

  String outputFolder = "Export/";
  String prefix = "selfie-";
  String timeStamp = dateNow();
  String fileName = outputFolder + prefix + timeStamp + ".ngc";
  PrintWriter output = createWriter(fileName);
  writeHeader(output);

  for (ArrayList<PVector>line: lines) {
    boolean first = true;
    for (PVector pt: line) {
      pt.mult(scaleRatio);
      pt.sub(paperHeight/ 2, paperWidth/2, 0);
      if (first) {
        output.println("G0" + " " + "Z" + penUp);
        output.println("G0" + " " + "F" + motorFeedFast);
        output.println("G0" + " " + "X" + pt.x + " " + "Y" + -(pt.y));          
        output.println("G0" + " " + "Z" + penDown); 
        output.println("G0" + " " + "F" + motorFeedSlow);
        first = false;
      } 
      else {
        output.println("G1" + " " + "X" + pt.x + " " + "Y" + -(pt.y));
      }
    }
  }
  writeFooter(output);
  println("G-code: Exported to " + fileName);
}



void writeHeader(PrintWriter output) {
  // writes an header with the required setup instructions for the GCode output file
  output.println("( Made with Processing. Paper size: "  + paperWidth + "x" + paperHeight + "mm )");
  // basic configuration =>> G21 (millimiters) G90 (absolute mode) G64 (constant velocity mode) G40 (turn off radius compensation)
  output.println("G21" + " " + "G90" + " " + "G64" + " " + "G40");
  // output.println("( T0 : 0.8 )");
  // T0 => tool select
  // M6 ==> tool change
  // output.println("T0 M6");
  // G17 ==> select the XY plane
  output.println("G17");
  // M3 ==> start spindle clockwise
  // S1000 ==> spindle speed
  // output.println("M3 S1000");
  // F... set stepper motors speed
  // G0 X0.0 Y0.0 => send plotter head to 'home' position 
  // G0 is movement with penup while G1 is movement with pen down -> not so sure about this! #ancheno
  // G0 Z... ==> pen UP
  output.println("G0" + " " + "Z" + penUp);
  output.println("G0" + " " + "F" + motorFeedFast + " " + "X0.0" + " " +  "Y0.0"); 
  output.println(" ");

  // disegna i due assi X,Y
  /*
  output.println("G0" + " " + "Z" + penDown);
   output.println("G0 X-205 Y0");
   output.println("G0 X205 Y0");
   output.println("G0" + " " + "Z" + penUp);
   output.println("G0 X0 Y140");
   output.println("G0" + " " + "Z" + penDown);
   output.println("G0 X0 Y-140");
   output.println("G0" + " " + "Z" + penUp);
   output.println(" ");
   */
}

void writeFooter(PrintWriter output) {
  // writes a footer with the end instructions for the GCode output file
  output.println(" ");
  // G0 Z90.0
  // G0 X0 Y0 => go home
  // M5 => stop spindle
  // M30 => stop execution
  output.println("G0" + " " + "Z" + penUp);
  //output.println("G0 Z90.0");
  output.println("G0 X0 Y0");  
  output.println("M5");
  output.println("M30"); 
  // finalize the GCode text file and quits the current Processing Sketch
  output.flush();  // writes the remaining data to the file
  output.close();  // finishes the output file
}

// Return a string containing the current date/time.
String dateNow() {
  return String.format("%4d%02d%02d-%02d%02d%02d", year(), month(), day(), hour(), minute(), second());
  //  return(year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second());
}

