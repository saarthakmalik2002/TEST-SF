public class accountHelper {
    public static void main(){
        list<account> accList= new list<account>();
        
        {Account acc= new Account();
        acc.Name='Delete';
        insert acc;
        
        Case cse= new Case();
        cse.Subject='Yellow';
        cse.AccountId=acc.Id;
        insert cse;
        }
        
}
        
}