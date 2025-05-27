public class LeadDeletionService {
    
    // Public method to delete leads named 'Test Lead Single'
    public static void deleteTestLeadSingle() {
        List<Lead> leadsToDelete = [SELECT Id FROM Lead WHERE Name = 'Test Lead Single'];

        if (!leadsToDelete.isEmpty()) {
            delete leadsToDelete;
            System.debug(leadsToDelete.size() + ' Lead(s) deleted successfully.');
        } else {
            System.debug('No Lead found with name "Test Lead Single".');
        }
    }
}