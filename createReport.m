%Created by Morgan McNulty, SEAP, 8-7-2019

% Import report API classes 
import mlreportgen.report.*
import mlreportgen.dom.*

%Load data from app to be accessed in the report generation
load('reportInfo');
load('testSetUps');
load('testData');

% Add report container 
rpt = Report('output','pdf');

%Add title page
page = TitlePage;
page.Title = strcat("Fan Performance Report for ", namesList(currentIndex), " at ", num2str(RPM), " RPM");
page.Author = "Carderock Division Naval Surface Warfare Center - Philadelphia";
add(rpt, page);


%Add test info section with all relevant test set up dimensions and test
%run information
testInfo = Section();

add(testInfo, Heading2("Test Identification Information"))
add(testInfo, Paragraph(strcat("Test Date: ", datestr(date))))
add(testInfo, Paragraph(strcat("Test Series: ", testSeries)));
add(testInfo, Paragraph(strcat("Test Identification Number: ", testID)));
add(testInfo, Paragraph("Test Standards: ANSI/AMCA Standard 210-07 or 210-99 or 210-85"));
add(testInfo, Paragraph("Labratory Test Set Up: AMCA 210 - 07 Fig. 12 Main Chamber described as: Outlet Chamber Setup - Nozzle on End of Chamber"));
testPersonnelTable = Table(testSetUpList(currentIndex).testPersonnel);
testPersonnelTable.TableEntriesInnerMargin='3px';
add(testInfo, "Test Personnel: ");
add(testInfo, testPersonnelTable);
add(testInfo, " ");

add(testInfo, Heading2("Fan Test Set Up Information"))
add(testInfo, Paragraph(strcat("Fan Type: ", namesList(currentIndex))));
add(testInfo, Paragraph(strcat("Test Unit: ", testSetUpList(currentIndex).testUnit)));
add(testInfo, Paragraph(strcat("Station 6 Nozzle Type: ", testSetUpList(currentIndex).D6Type)));
add(testInfo, "Nozzle Dimensions:")
for i=1:9
if testSetUpList(currentIndex).D6(i) == 0 
    nozzleLine = Paragraph(strcat("Nozzle ", num2str(i), " Diameter: ", "Not Used"));
    nozzleLine.FirstLineIndent = '30px';
    add(testInfo, nozzleLine);
else
    nozzleLine = Paragraph(strcat("Nozzle ", num2str(i), " Diameter: ", num2str(testSetUpList(currentIndex).D6(i)), " in"));
    nozzleLine.FirstLineIndent = '30px';
    add(testInfo, nozzleLine);
end
end

add(testInfo, strcat("Nozzle L/D Ratio: ", testSetUpList(currentIndex).LD));
testFanDimTable = Table(testSetUpList(currentIndex).transitionDim);
add(testInfo, Paragraph("Test Fan Transition Ducting Type and Dimensions: "));
add(testInfo, testFanDimTable);
faultyDataTable = Table(testSetUpList(currentIndex).notes);
add(testInfo, Paragraph("Known Faulty Data and Additional Notes: "));
add(testInfo, faultyDataTable);
add(testInfo, " ");

add(testInfo, Heading2("Fan Test Run Information"))
add(testInfo, Paragraph(strcat("Fan RPM: ", num2str(RPM))));
add(testInfo, Paragraph(strcat("RPM Test Number: ", RPMtestNum)));
add(testInfo, "Test Fan Variable Frequency Drive Notes:");
freqLine = Paragraph(strcat("Freqency: ", num2str(freq), " Hz"));
freqLine.FirstLineIndent = '30 px';
add(testInfo,  freqLine);
currentLine = Paragraph(strcat("Current: ", num2str(current), " Amps"));
currentLine.FirstLineIndent = '30 px';
add(testInfo,  currentLine);
voltageLine = Paragraph(strcat("Voltage: ", num2str(voltage), " VAC"));
voltageLine.FirstLineIndent = '30 px';
add(testInfo,  voltageLine);
notesTable = Table(notes);
add(testInfo, Paragraph("Additional Notes: "));
add(testInfo, notesTable);

add(rpt, testInfo);

%Add section with Fan Performance Curve and estimates of shutoff and free
%delivery values

fanPreformanceCurve = Section();

dateStr = Paragraph(datestr(date));
dateStr.HAlign = 'right';
add(fanPreformanceCurve, dateStr);

heading = Heading1(strcat("Report for ", namesList(currentIndex), " at ", num2str(RPM), " RPM"));
heading.HAlign = 'center';
add(fanPreformanceCurve, heading);
add(fanPreformanceCurve, filePath);

[xData, yData] = prepareCurveData( Q, P );

% Set up fittype and options.
ft = fittype( 'smoothingspline' );

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft );

% Plot fit with data.
figure( 'Name', 'Fan Performance Curve' );
h = plot( fitresult, xData, yData );
legend('P vs Q', 'Fit with Smoothing Spline');
grid on

title('Fan Characteristic Performance Curve');
xlabel('Fan Airflow Rate, Q (ft^3 / min)');  
ylabel('Fan Static Pressure, P (in. wg.)');

%Calculate Intercepts
shutoff(1) = interp1(Q, P, 0, 'smoothingspline', 'extrap');
shutoff(2) = interp1(Q, P, 0, 'linear', 'extrap');
freeDelivery(1) = interp1(P, Q, 0, 'smootingspline', 'extrap');
freeDelivery(2) = interp1(P, Q, 0, 'linear', 'extrap');

add(fanPreformanceCurve, Figure());

%Removes outliers for free delivery and shutoff values
if abs(shutoff(1) - shutoff(2))> 500
    bestShutoff = shutoff(2);
else
bestShutoff = mean(shutoff);
end
if abs(freeDelivery(1) - freeDelivery(2))> 500
    bestFreeDelivery = freeDelivery(2);
else
    bestFreeDelivery = mean(freeDeliveryVal);
end

add(fanPreformanceCurve, strcat("Best Estimate of Flow Rate at Free Delivery: ", num2str(bestFreeDelivery), " cfm"));
add(fanPreformanceCurve, strcat("Best Estimate of Static Pressure at Shutoff: ", num2str(bestShutoff), " in. wg.")); 
add(fanPreformanceCurve, strcat("Static Pressure at Shutoff Calculated with Smoothing Spline Extrapolation: ", num2str(shutoff(1)), " in. wg."));
add(fanPreformanceCurve, strcat("Static Pressure at Shutoff Calculated with Linear Extrapolation: ", num2str(shutoff(2)), " in. wg."));
add(fanPreformanceCurve, strcat("Flow Rate at Free Delivery Calculated with Smoothing Spline Extrapolation: ", num2str(freeDelivery(1)), " cfm"));
add(fanPreformanceCurve, strcat("Flow Rate at Free Delivery Calculated with Linear Extrapolation: ", num2str(freeDelivery(2)), " cfm"));

add(rpt, fanPreformanceCurve);

%Adds section for  appendix with calculated Q, Ps, and Q5 values
tableOfValues = Section();
headingAppendixA = Heading1("Appendix A: Calculated Flow Rate and Pressure Values");
add(tableOfValues, headingAppendixA);

Qtable = Table({"Run #", "Fan Airflow Rate(cfm) - Q", "Fan Static Pressure (in. wg.) - Ps", "Airflow Rate for Nozzle 5(cfm) - Q5"; RunNumber, Q, P, Q5});
Qtable.Border = 'double';
Qtable.ColSep = 'single';
Qtable.RowSep = 'single';
Qtable.TableEntriesInnerMargin='2px';
add(tableOfValues,Qtable);

add(rpt, tableOfValues);

%Adds section with appendix containign all raw data form test file
appendixRawData = Section();
headingAppendixB = Heading1("Appendix B: DAQ File Raw Data");
add(appendixRawData, headingAppendixB);

rawDataTable1 = Table({'Run #','Target Disk Posistion (%)','Target Cone Position (%)','Nominal NFan (RPM)'; ...
RunNumber,targetDiskPos_percent,targetConePos_percent,NominalNfan_RPM});
rawDataTable1.TableEntriesInnerMargin='2px';
rawDataTable1.Border = 'double';
rawDataTable1.ColSep = 'single';
rawDataTable1.RowSep = 'single';

rawDataTable2 = Table({'Run #','Nmotor (RPM)','Nfan (Instantaneous) RPM','Nfan (RPM)'; ...
RunNumber,Nmotor_RPM, Nfan_instantaneous_RPM,Nfan_RPM});
rawDataTable2.TableEntriesInnerMargin='2px';
rawDataTable2.Border = 'double';
rawDataTable2.ColSep = 'single';
rawDataTable2.RowSep = 'single';


rawDataTable3 = Table({'Run #','Torque (lbs)', 'Ps2L (in wg)','delta Ps2.5-2L (in wg)'; ...
RunNumber,Tq_lb, Ps2L_wg,deltaPs2_5_2L_wg});
rawDataTable3.TableEntriesInnerMargin='2px';
rawDataTable3.Border = 'double';
rawDataTable3.ColSep = 'single';
rawDataTable3.RowSep = 'single';

rawDataTable15 = Table({'Run #','Ps2.5L (in wg)','Ps7L (in wg)','Ps5L (in wg)'; ...
RunNumber,Ps2_5L_wg,Ps7L_wg,Ps5L_wg});
rawDataTable15.TableEntriesInnerMargin='2px';
rawDataTable15.Border = 'double';
rawDataTable15.ColSep = 'single';
rawDataTable15.RowSep = 'single';

rawDataTable16 = Table({'Run #',' delta Ps5-6L (in wg)','Ps6L (in wg)', 'Ps0 (in wg)' ; ...
RunNumber, deltaPs5_6L_wg,Ps6L_wg, Ps0_wg});
rawDataTable16.TableEntriesInnerMargin='2px';
rawDataTable16.Border = 'double';
rawDataTable16.ColSep = 'single';
rawDataTable16.RowSep = 'single';

rawDataTable4 = Table({'Run #','T2.5aL (°F)', 'T2.5bL (°F)','T2.5cL (°F)'; ...
RunNumber, T2_5aL_F, T2_5bL_F,T2_5cL_F});
rawDataTable4.TableEntriesInnerMargin='2px';
rawDataTable4.Border = 'double';
rawDataTable4.ColSep = 'single';
rawDataTable4.RowSep = 'single';

rawDataTable5 = Table({'Run #','T7aL (°F)','T7bL (°F)','T7cL (°F)'; ...
RunNumber,T7aL_F,T7bL_F,T7cL_F});
rawDataTable5.TableEntriesInnerMargin='2px';
rawDataTable5.Border = 'double';
rawDataTable5.ColSep = 'single';
rawDataTable5.RowSep = 'single';

rawDataTable6 = Table({'Run #','Trtd7L (°F)','T5aL (°F)','T5bL (°F)'; ...
RunNumber,Trtd7L_F,T5aL_F,T5bL_F});
rawDataTable6.TableEntriesInnerMargin='2px';
rawDataTable6.Border = 'double';
rawDataTable6.ColSep = 'single';
rawDataTable6.RowSep = 'single';

rawDataTable7 = Table({'Run #','T5cL (°F)','Trtd5L (°F)','T6aL (°F)'; ...
RunNumber,T5cL_F,Trtd5L_F,T6aL_F});
rawDataTable7.TableEntriesInnerMargin='2px';
rawDataTable7.Border = 'double';
rawDataTable7.ColSep = 'single';
rawDataTable7.RowSep = 'single';

rawDataTable8 = Table({'Run #','T6bL (°F)','T6cL (°F)','Trtd6L (°F)'; ...
RunNumber,T6bL_F,T6cL_F,Trtd6L_F});
rawDataTable8.TableEntriesInnerMargin='2px';
rawDataTable8.Border = 'double';
rawDataTable8.ColSep = 'single';
rawDataTable8.RowSep = 'single';

rawDataTable9 = Table({'Run #','Pba (mbar)','Pbb (mbar)','Pbc (mbar)'; ...
RunNumber,Pba_mbar,Pbb_mbar,Pbc_mbar});
rawDataTable9.TableEntriesInnerMargin='2px';
rawDataTable9.Border = 'double';
rawDataTable9.ColSep = 'single';
rawDataTable9.RowSep = 'single';

rawDataTable10 = Table({'Run #','T0a (°F)','T0b (°F)','T0c (°F)'; ...
RunNumber,T0a_F,T0b_F,T0c_F});
rawDataTable10.TableEntriesInnerMargin='2px';
rawDataTable10.Border = 'double';
rawDataTable10.ColSep = 'single';
rawDataTable10.RowSep = 'single';

rawDataTable11 = Table({'Run #','Tdewa (°F)','Tdewb (°F)','Tdewc (°F)'; ...
RunNumber,Tdewa_F, Tdewb_F,Tdewc_F});
rawDataTable11.TableEntriesInnerMargin='2px';
rawDataTable11.Border = 'double';
rawDataTable11.ColSep = 'single';
rawDataTable11.RowSep = 'single';

rawDataTable12 = Table({'Run #','Rha (%)','Rhb (%)','Rhc (%)'; ...
RunNumber,Rha_percent,Rhb_percent,Rhc_percent});
rawDataTable12.TableEntriesInnerMargin='2px';
rawDataTable12.Border = 'double';
rawDataTable12.ColSep = 'single';
rawDataTable12.RowSep = 'single';

rawDataTable13 = Table({'Run #','DLC (in)','DL0 (in)','DL45 (in)','DL90 (in)','DL135 (in)','DL180 (in)','DL225 (in)'; ...
RunNumber,DLC_in,DL0_in,DL45_in,DL90_in, DL135_in,DL180_in,DL225_in});
rawDataTable13.TableEntriesInnerMargin='2px';
rawDataTable13.Border = 'double';
rawDataTable13.ColSep = 'single';
rawDataTable13.RowSep = 'single';

rawDataTable14 = Table({'Run #','DL270 (in)','DL315 (in)','Exhaust Fan Pitch (°)'; ...
RunNumber,DL270_in,DL315_in,EFanPitch_deg});
rawDataTable14.TableEntriesInnerMargin='2px';
rawDataTable14.Border = 'double';
rawDataTable14.ColSep = 'single';
rawDataTable14.RowSep = 'single';

add(appendixRawData, rawDataTable1);
add(appendixRawData, PageBreak());
add(appendixRawData, rawDataTable2);
add(appendixRawData, PageBreak());
add(appendixRawData, rawDataTable3);
add(appendixRawData, PageBreak());
add(appendixRawData, rawDataTable15);
add(appendixRawData, PageBreak());
add(appendixRawData, rawDataTable16);
add(appendixRawData, PageBreak());
add(appendixRawData, rawDataTable4);
add(appendixRawData, PageBreak());
add(appendixRawData, rawDataTable5);
add(appendixRawData, PageBreak());
add(appendixRawData, rawDataTable6);
add(appendixRawData, PageBreak());
add(appendixRawData, rawDataTable7);
add(appendixRawData, PageBreak());
add(appendixRawData, rawDataTable8);
add(appendixRawData, PageBreak());
add(appendixRawData, rawDataTable9);
add(appendixRawData, PageBreak());
add(appendixRawData, rawDataTable10);
add(appendixRawData, PageBreak());
add(appendixRawData, rawDataTable11);
add(appendixRawData, PageBreak());
add(appendixRawData, rawDataTable12);
add(appendixRawData, PageBreak());
add(appendixRawData, rawDataTable13);
add(appendixRawData, PageBreak());
add(appendixRawData, rawDataTable14);

add(rpt, appendixRawData);



% Close the report (required)
close(rpt);
% Display the report (optional)
rptview(rpt);