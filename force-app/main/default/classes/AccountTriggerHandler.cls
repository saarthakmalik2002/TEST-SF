public class AccountTriggerHandler {
    public static void createPrimaryContact(List<Account> newAccounts){
        
        List<Contact> conList = new List<Contact>();
        
        if(!newAccounts.isEmpty()){
            for(Account acc : newAccounts){
                Contact con = new Contact();
                con.FirstName = 'Primary';
                con.LastName = 'Contact';
                con.AccountId = acc.Id;
                con.Primary__c = True;
                conList.add(con);
            }
        }
        if(!conList.isEmpty()){
        insert conList;
        }
    }
}