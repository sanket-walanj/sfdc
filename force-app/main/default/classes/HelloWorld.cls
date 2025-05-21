public class HelloWorld {
    private String greeting = 'Hello World';
    public String publicGreeting = 'My public greeting variable';
    private String goodMorning = 'Good Morning';
    private String goodAfternoon = 'Good Afternoon';
    private String goodEvening = 'Good Evening';
    
    public void printGreeting() {
        System.debug(greeting);
    }
    /*
        public void printGoodMorning() {
        System.debug(goodMorning);
    }
        public void printGoodAfternoon() {
        System.debug(goodAfternoon);
    }
        public void printGoodEvening() {
        System.debug(goodEvening);
    }
    */
    
    public void printMessage(String msg){
		System.debug(msg);     
    }
    
    public String getDay(Integer dayNumber){
        String dayString = '';
        
        switch on dayNumber{
            when 0 {
                dayString = 'Sunday';
            }
            when 1 {
                dayString = 'Monday';
            }
            when 2 {
                dayString = 'Tuesday';
            }
            when 3 {
                dayString = 'Wednesday';
            }
            when 4 {
                dayString = 'Thursday';
            }
            when 5 {
                dayString = 'Friday';
            }
            when 6  {
                dayString = 'Saturday';
            }
            when else {
                dayString = 'Invalid Number'; 
            }
            
        }
        return dayString;
    }
    
    
    // Global can't be used inside Public
    /*global void printPublicGreeting() {
        System.debug(publicGreeting);
    }*/

}