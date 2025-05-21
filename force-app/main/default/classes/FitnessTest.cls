@isTest
public class FitnessTest {
    
    @isTest
    public static void calculateBMITest1(){
        decimal weight = 50;
        decimal height = 2;
        decimal result = Fitness.calculateBMI(weight, height);
        System.assertEquals(12.5,result,'Calculate BMI Failed');
    }
    
     @isTest
    public static void calculatePace1(){
        decimal distance = 50;
        decimal minutes = 300;
        decimal result = Fitness.calculatePace(distance, minutes);
        System.assertEquals(10,result,'Calculate Pace Failed');
    }

}