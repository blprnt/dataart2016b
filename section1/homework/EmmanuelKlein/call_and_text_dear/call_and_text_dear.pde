import java.util.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import processing.pdf.*;
//import java.util.Date;


XML xmlSMSLog;
XML xmlCallLog;


Sms[] smss;
Sms[] dateSmss;//holds the Smss from certain dates
Call[] dateCalls;
Sms[] jenSmss;
Call[] jenCalls;
Sms[][] daysSms;

Call[] calls;

//long beggingDate= 1472772816;//epoch seconds
long beggingDate= 1462772816;//epoch seconds
long endDate= 1474768707;
//long endDate= 1472768707;

int numDays=25;

void setup() {
  beginRecord(PDF, "filename.pdf"); 
  size(2000,2000,P3D);
  background(0);
  
  
  
  smss=loadXMLSMSs();
  calls=loadXMLCalls();
  
  dateSmss=getDatesSMS(smss);
  dateCalls=getDatesCall(calls);
  jenSmss=getJenSMS(dateSmss);
  jenCalls=getJenCall(dateCalls);
  Arrays.sort(jenSmss);
  Arrays.sort(jenCalls);
  //Arrays.sort(dateSmss);
  
  
  ArrayList<ArrayList<Sms>> daysSMSs = organizeByDaySMS(jenSmss);
  
  ArrayList<ArrayList<Call>> daysCalls = organizeByDayCall(jenCalls);
  //ArrayList<ArrayList<Sms>> daysSMSs = organizeByDay(dateSmss);
  drawGraphic(daysSMSs, daysCalls);
  
  endRecord();
  
  
  
}
void draw() {
}


void  drawGraphic(ArrayList<ArrayList<Sms>> daysSMSsIn, ArrayList<ArrayList<Call>> daysCallsIn){
  //println(daysSMSsIn.get(1).size());
  //int dayBack=9;
  
  float radiansAround=1.6*PI;
  float xCenter=-50;
  float yCenter=50;
  boolean rotationClockwise=true;
  float startingAngle=PI*.9;
  
  for(int i=0;i<numDays && i<daysSMSsIn.size() && i<daysCallsIn.size();i++){
    
    radiansAround=1.5*PI+(float)Math.random()*.1-.05;
    float[] next = drawDay(daysSMSsIn.get(i), daysCallsIn.get(i),xCenter,yCenter,radiansAround,rotationClockwise,startingAngle);
    xCenter=next[0];
    yCenter=next[1];
    startingAngle=next[2];
    rotationClockwise=!rotationClockwise;
  }
  
  
}
float[] drawDay(ArrayList<Sms> daySMSIn, ArrayList<Call> dayCallsIn,float centerX,float centerY, float radiansEdgeIn, boolean isClockWise , float startingAngle){
  int diamiter=150;
  float[] nextCenter=DrawTimeLine(centerX, centerY, radiansEdgeIn,  isClockWise ,  startingAngle,  diamiter);
  
  strokeWeight(1);
  float scaling=2;
  for(int i=0;i<daySMSIn.size();i++){
    
    //println(daysSMSsIn.get(dayBack).get(i).iCharLength);
    float angle;
    if(!isClockWise){
      angle=startingAngle+(PI*2-(1.0*daySMSIn.get(i).hour/24+1.0*daySMSIn.get(i).minute/(60*24)+1.0*daySMSIn.get(i).second/(60*60*24))*radiansEdgeIn);
    }else{
      angle=startingAngle+((1.0*daySMSIn.get(i).hour/24+1.0*daySMSIn.get(i).minute/(60*24)+1.0*daySMSIn.get(i).second/(60*60*24))*radiansEdgeIn);
    }
    //println(angle);
    
    float x=centerX+1.0*cos(angle)*daySMSIn.get(i).iCharLength*scaling;
    float y=centerY+1.0*sin(angle)*daySMSIn.get(i).iCharLength*scaling;
    
    
    if(daySMSIn.get(i).sType.equals("2")){//text from me
      stroke(250,102,6);
    }else{//text to me
      stroke(46,156,245);
    }
    
    line(centerX, centerY, x, y);
  }
  
  
  
  for(int i=0;i<dayCallsIn.size();i++){
    
    float begAngle, endAngle;
    if(!isClockWise){
      begAngle=startingAngle+(PI*2-(1.0*dayCallsIn.get(i).hour/24+1.0*dayCallsIn.get(i).minute/(60*24)+1.0*dayCallsIn.get(i).second/(60*60*24))*radiansEdgeIn);
      
      endAngle=startingAngle+(PI*2-(1.0*dayCallsIn.get(i).hourEnd/24+1.0*dayCallsIn.get(i).minuteEnd/(60*24)+1.0*dayCallsIn.get(i).secondEnd/(60*60*24))*radiansEdgeIn);
    }else{
      begAngle=startingAngle+((1.0*dayCallsIn.get(i).hour/24+1.0*dayCallsIn.get(i).minute/(60*24)+1.0*dayCallsIn.get(i).second/(60*60*24))*radiansEdgeIn);
      endAngle=startingAngle+((1.0*dayCallsIn.get(i).hourEnd/24+1.0*dayCallsIn.get(i).minuteEnd/(60*24)+1.0*dayCallsIn.get(i).secondEnd/(60*60*24))*radiansEdgeIn);
    }
    //println(angle);
    
    //float x=centerX+1.0*cos(angle)*daySMSIn.get(i).iCharLength*scaling;
    //float y=centerY+1.0*sin(angle)*daySMSIn.get(i).iCharLength*scaling;
    
    
    if(dayCallsIn.get(i).sType.equals("2")){//text from me
      stroke(250,102,6);
    }else{//text to me
      stroke(46,156,245);
    }
    //stroke(250);
    
    
    strokeWeight(4);
    //ellipse(centerX, 46, 55, 55);
    //noFill();
    
    arc(centerX, centerY, diamiter, diamiter, begAngle, endAngle);
    
    
    
    
    for(int k=0; k<diamiter*3;k+=3){
      
      if(dayCallsIn.get(i).sType.equals("2")){//text from me
      fill(250,102,6,1);
      }else{//text to me
        fill(46,156,245,1);
      }
      //fill(255-k,1);
      noStroke();
      arc(centerX, centerY, k, k, begAngle, endAngle);
    }
    

    
  }
  
  return nextCenter;
  
  
}
float[] DrawTimeLine(float centerX,float centerY,float radiansEdgeIn, boolean isClockWise , float startingAngle, float diamiter){
  
  stroke(255,50);
  strokeWeight(3);
  noFill();
  float endAngle;
  if(isClockWise){
     endAngle=startingAngle+radiansEdgeIn;
     arc(centerX, centerY, diamiter, diamiter, startingAngle, endAngle);
     
      //mark end of arc
    strokeWeight(8);
    stroke(255);
    //arc(centerX, centerY, diamiter, diamiter, endAngle-.01, endAngle );
    
    return getNextCenter(centerX, centerY, endAngle, diamiter);
  }else{
    endAngle=startingAngle-radiansEdgeIn;
    arc(centerX, centerY, diamiter, diamiter, endAngle, startingAngle );
    
    
    
    //mark end of arc
    strokeWeight(8);
    stroke(255);
    //arc(centerX, centerY, diamiter, diamiter, endAngle-.01, endAngle );
    
    return getNextCenter(centerX, centerY, endAngle, diamiter);
  }
  
  
  
  
  //arc(width/2, height/2, 100, 100, startingAngle, endAngle);
}

float[] getNextCenter(float xLast, float yLast, float lastEndAngle, float diamiter){
  
  float deltaX=cos(lastEndAngle)*diamiter;//two circles
  float deltaY=sin(lastEndAngle)*diamiter;
  
  float nextX=xLast+deltaX;
  float nextY=yLast+deltaY;
  
  float nextAngle=lastEndAngle+PI;
  
  float[] nextPosition=new float[]{nextX, nextY,nextAngle};
  
  return nextPosition;
}





public ArrayList<ArrayList<Sms>> organizeByDaySMS(Sms[] smssIn){
  Sms lastDay;
  int j=0;
  
  
  ArrayList<ArrayList<Sms>> daysSMSs=new ArrayList<ArrayList<Sms>>();
  daysSMSs.add(new ArrayList<Sms>());
  
  //Sms[] day1=new Sms[0];
  
  lastDay=smssIn[0];
  for(int i=0;i<smssIn.length;i++){
    //println(smssIn[i].day);
    if(lastDay.day!=smssIn[i].day){
      daysSMSs.add(new ArrayList<Sms>());
      lastDay=smssIn[i];
      j++;
    }
    daysSMSs.get(j).add(smssIn[i]);
    
    
   
  }
  //println(daysSMSs.size());
  //println(daysSMSs.get(0).size());
  return daysSMSs;
  
}

public ArrayList<ArrayList<Call>> organizeByDayCall(Call[] callsIn){
  Call lastDay;
  int j=0;
  
  
  ArrayList<ArrayList<Call>> daysCalls=new ArrayList<ArrayList<Call>>();
  daysCalls.add(new ArrayList<Call>());
  
  //Sms[] day1=new Sms[0];
  
  lastDay=callsIn[0];
  for(int i=0;i<callsIn.length;i++){
    //println(smssIn[i].day);
    if(lastDay.day!=callsIn[i].day){
      daysCalls.add(new ArrayList<Call>());
      lastDay=callsIn[i];
      j++;
    }
    daysCalls.get(j).add(callsIn[i]);
    
    
   
  }
  //println(daysSMSs.size());
  //println(daysSMSs.get(0).size());
  return daysCalls;
  
}




Sms[] getDatesSMS(Sms[] smssIn){
  ArrayList<Sms> listSMSs=new ArrayList<Sms>();
  
  for(int i=0;i<smssIn.length;i++){
    
    
    if(smssIn[i].lDate>=beggingDate  && smssIn[i].lDate<=endDate){
       listSMSs.add(smssIn[i]);
    }
    
  }
  
  Sms[] smss = listSMSs.toArray(new Sms[listSMSs.size()]);
  return smss;
}

Call[] getDatesCall(Call[] callsIn){
  ArrayList<Call> listCalls=new ArrayList<Call>();
  
  for(int i=0;i<callsIn.length;i++){
    
    
    if(callsIn[i].lDate>=beggingDate  && callsIn[i].lDate<=endDate){
       listCalls.add(callsIn[i]);
    }
    
  }
  
  Call[] calls = listCalls.toArray(new Call[listCalls.size()]);
  return calls;
}

Sms[] getJenSMS(Sms[] smssIn){
  ArrayList<Sms> listSMSs=new ArrayList<Sms>();
  
  for(int i=0;i<smssIn.length;i++){
    
    
    if(smssIn[i].sContact_name.equals("Jennifer Radoff")){
       listSMSs.add(smssIn[i]);
       //smssIn[i].printSMS();
    }
  }
  
  Sms[] smss = listSMSs.toArray(new Sms[listSMSs.size()]);
  return smss;
}
Call[] getJenCall(Call[] callsIn){
  ArrayList<Call> listCalls=new ArrayList<Call>();
  
  for(int i=0;i<callsIn.length;i++){
    
    
    if(callsIn[i].sContact_name.equals("Jennifer Radoff")){
       listCalls.add(callsIn[i]);
       //smssIn[i].printSMS();
    }
  }
  
  Call[] calls = listCalls.toArray(new Call[listCalls.size()]);
  return calls;
}

Sms[] loadXMLSMSs() {
  xmlSMSLog = loadXML("sms.xml");
  XML[] XMLsmss = xmlSMSLog.getChildren("sms");

  Sms[] retrieveSmss;
  retrieveSmss = new Sms[XMLsmss.length];


  for (int i=0; i<XMLsmss.length; i++) {
    retrieveSmss[i]=new Sms(XMLsmss[i]);
    //retrieveSmss[i].printSMS();
  }
  
  return retrieveSmss;
}
Call[] loadXMLCalls() {
  xmlCallLog = loadXML("calls.xml");
  XML[] XMLcalls = xmlCallLog.getChildren("call");

  Call[] retrieveCalls;
  retrieveCalls = new Call[XMLcalls.length];


  for (int i=0; i<XMLcalls.length; i++) {
    retrieveCalls[i]=new Call(XMLcalls[i]);
    //retrieveSmss[i].printSMS();
  }
  
  return retrieveCalls;
}


public class Sms implements Comparable<Sms>{
  public String sAddress;
  public String sContact_name;
  public String sReadable_date;
  public String sDate;
  public long lDate;
  
  public Date date = new Date(0);;
  
  
  public int year;
  public int month;
  public int day;
  public int hour;
  public int minute;
  public int second;
  
  
  public String sBody;
  public String sDate_sent;
  public String sType;
  public int iCharLength;
  
  

  //constructor
  public Sms(XML smsIn) {
    sAddress=smsIn.getString("address");
    sContact_name=smsIn.getString("contact_name");
    sReadable_date=smsIn.getString("readable_date");
    sDate=smsIn.getString("date");
    lDate=Long.parseLong(sDate)/1000;
    
    
    setDate();
    sBody=smsIn.getString("body");
    //sDate_sent=smsIn.getString("date_sent");
    sType=smsIn.getString("type");
    iCharLength=this.getLength();
  }
  public void setDate(){

    //Date date =new Date(this.lDate*1000);
    
    //DateFormat yearFormat = new SimpleDateFormat("yyyy");
    //DateFormat monthFormat = new SimpleDateFormat("MM");
    //DateFormat dayFormat = new SimpleDateFormat("dd");
    //DateFormat hourFormat = new SimpleDateFormat("HH");
    //DateFormat minuteFormat = new SimpleDateFormat("mm");
    //DateFormat secondFormat = new SimpleDateFormat("ss");
    
    
    //this.year=parseInt(yearFormat.format(date));
    //this.month=parseInt(monthFormat.format(date));
    //this.day=parseInt(dayFormat.format(date));
    //this.hour=parseInt(hourFormat.format(date));
    //this.minute=parseInt(minuteFormat.format(date));
    //this.second=parseInt(secondFormat.format(date));
    
    int[] timesStart=getDate(this.lDate);
    
    
    this.year=timesStart[0];
    this.month=timesStart[1];
    this.day=timesStart[2];
    this.hour=timesStart[3];
    this.minute=timesStart[4];
    this.second=timesStart[5];
  }

  public void printSMS() {
    if (this.sType.equals("2")) {//check it message was sent or received
      print("*Sent   :");
    }

    println("Address "+this.sAddress);

    println("Body "+this.sBody);
  }
  public int getLength(){
    return this.sBody.length();
  }
  
  public int compareTo(Sms compareSMS) {

    long compareQuantity = ((Sms) compareSMS).lDate;
    
    int iCompair =safeLongToInt(this.lDate - compareQuantity);
    return iCompair;

    //ascending order
    //return this.lDate - compareQuantity;

    //descending order
    //return compareQuantity - this.quantity;

  }
  
  
}

public class Call implements Comparable<Call>{
  public String sNumber;
  public String sContact_name;
  public String sReadable_date;
  public String sDate;
  public long lDate;
  
  public int year;
  public int month;
  public int day;
  public int hour;
  public int minute;
  public int second;
  
  
  public int yearEnd;
  public int monthEnd;
  public int dayEnd;
  public int hourEnd;
  public int minuteEnd;
  public int secondEnd;
  
  
  public String sDuration;
  public long lDuration;
  public String sType;
  
  

  //constructor
  public Call(XML callIn) {
    this.sNumber=callIn.getString("number");
    this.sContact_name=callIn.getString("contact_name");
    this.sReadable_date=callIn.getString("readable_date");
    
    
    this.sDate=callIn.getString("date");
    this.lDate=Long.parseLong(sDate)/1000;
    
    this.sDuration=callIn.getString("duration");
    this.lDuration=Long.parseLong(sDuration);
    
    this.setDate();
    
    
    this.sType=callIn.getString("type");
    
  }
  public void setDate(){
    
    int[] timesStart=getDate(this.lDate);
    
    
    this.yearEnd=timesStart[0];
    this.monthEnd=timesStart[1];
    this.dayEnd=timesStart[2];
    this.hourEnd=timesStart[3];
    this.minuteEnd=timesStart[4];
    this.secondEnd=timesStart[5];
    
    int[] timesEnd=getDate(this.lDate+this.lDuration);
    
    
    this.year=timesEnd[0];
    this.month=timesEnd[1];
    this.day=timesEnd[2];
    this.hour=timesEnd[3];
    this.minute=timesEnd[4];
    this.second=timesEnd[5];
  }
  

  public void printCall() {
    if (this.sType.equals("2")) {//check it message was sent or received
      print("*Outgoting   :");
    }

    println("Address "+this.sNumber);

    println("Body "+this.sDuration);
  }
  
  
  public int compareTo(Call compareCall) {

    long compareQuantity = ((Call) compareCall).lDate;
    
    int iCompair =safeLongToInt(this.lDate - compareQuantity);
    return iCompair;

    //ascending order
    //return this.lDate - compareQuantity;

    //descending order
    //return compareQuantity - this.quantity;

  }
  
  
}

public static int safeLongToInt(long l) {
    int i = (int)l;
    if ((long)i != l) {
        throw new IllegalArgumentException(l + " cannot be cast to int without changing its value.");
    }
    return i;
}

public int[] getDate(long dateIn){
  Date date =new Date(dateIn*1000);
  int year;
  int month;
  int day;
  int hour;
  int minute;
  int second;
  
  DateFormat yearFormat = new SimpleDateFormat("yyyy");
  DateFormat monthFormat = new SimpleDateFormat("MM");
  DateFormat dayFormat = new SimpleDateFormat("dd");
  DateFormat hourFormat = new SimpleDateFormat("HH");
  DateFormat minuteFormat = new SimpleDateFormat("mm");
  DateFormat secondFormat = new SimpleDateFormat("ss");
  
  year=parseInt(yearFormat.format(date));
  month=parseInt(monthFormat.format(date));
  day=parseInt(dayFormat.format(date));
  hour=parseInt(hourFormat.format(date));
  minute=parseInt(minuteFormat.format(date));
  second=parseInt(secondFormat.format(date));
  
  
  int[] times=new int[]{year, month, day, hour, minute, second};
  
  return times;
}