@isTest
public class OpportunitiesControllerTest {
    
    @isTest
    static void testGetAllOpportunities() {
        Account acc = new Account(Name = 'Test Account', AccountNumber='28487588');
        insert acc;
        
        Contact con = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = acc.Id);
        insert con;
        
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', CloseDate = Date.today(), StageName = 'Prospecting', AccountId = acc.Id);
        insert opp;
        
        Test.startTest();
        List<OpportunitiesController.OppWrapper> result = OpportunitiesController.getAllOpportunities();
        Test.stopTest();
        
        System.assertEquals(1, result.size(), 'Expected only one opportunity wrapper in the result');
        
        OpportunitiesController.OppWrapper wrapper = result[0];
        System.assertEquals(opp.Id, wrapper.opp.Id, 'Opportunity Id should match');
        System.assertEquals(acc.Id, wrapper.opp.AccountId, 'Opportunity Account Id should match');
        System.assertEquals('Test Account', wrapper.opp.Account.Name, 'Opportunity Account Name should match');
        System.assertEquals('Test Contact', wrapper.con.Name, 'Contact Name should match');
    }
}