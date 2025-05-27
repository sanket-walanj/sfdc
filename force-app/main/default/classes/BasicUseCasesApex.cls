public with sharing class BasicUseCasesApex {
    
    public static Integer attemptCounter = 1;
    public static String correctPassword = 'Sanket_Walanj';
    public static String handlePasswordAttemptes(String passwordInput){
        if(passwordInput != correctPassword){
            attemptCounter++;
            if(attemptCounter > 3){
                return 'Max attempts reached. Account Locked';
            } else {
                return 'Failure';
            }
        } else {
            return 'Success';
        }
    }
}