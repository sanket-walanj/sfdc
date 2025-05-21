public class Fitness {
    
    public static decimal calculateBMI(decimal weight, decimal height){
        decimal bmi;
        bmi = weight/(height*height);
        return bmi;
    }
    
    public static decimal calculatePace(decimal distanceCovered, decimal timeTaken){
        decimal pace;
        pace = distanceCovered/(timeTaken*timeTaken);
        return pace;
    }
}