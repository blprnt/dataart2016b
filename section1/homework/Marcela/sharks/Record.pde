class Record
{
  String region;
  int total;
  int fatal;
  int year;

  Record fromJSON(JSONObject js)
  {

    region  = js.getString ("region");
    total = js.getInt ("total");
    fatal = js.getInt ("fatal");
    year = js.getInt ("year");

    return(this);
    
  }
}