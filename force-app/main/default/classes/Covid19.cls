/**
 * Covid19 Class
 * Track Covid19 recovery
 * */

public class Covid19 {
    public Integer recoveredInArea = 0;
    public Integer recoveredInCountry = 0;
    
    public void treatPatient(){
        recoveredInArea++;
        recoveredInCountry++;
    }
}