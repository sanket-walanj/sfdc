@isTest
private class BasicUseCasesApexTest {


@IsTest
    static void testPasswordAttempts(){
        System.assertEquals('Failure', BasicUseCasesApex.handlePasswordAttemptes('test'));
        System.assertEquals('Failure', BasicUseCasesApex.handlePasswordAttemptes('test'));
        System.assertEquals('Failure', BasicUseCasesApex.handlePasswordAttemptes('test'));
        System.assertEquals('Max attempts reached. Account Locked', BasicUseCasesApex.handlePasswordAttemptes('test'));
    }
}