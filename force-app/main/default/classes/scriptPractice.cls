public class scriptPractice {
    
    // 1. Create 20 new Accounts Records in salesforce with atleast 5 fields filled.    
    public static void insertMultipleAccounts(){
        List<Account> accountsToInsert = new List<Account>();
        
        for(Integer var = 1; var<=20; var++ ){
            Account acc = new Account();
            acc.Name = 'Account ' + var;
            accountsToInsert.add(acc);
        }
        
        insert accountsToInsert;
    }
    
    // 2. Create 10 Contacts with diferent Account(LookUp) values(Relationship with no same 2 accounts) in them.    
    public static void relateMultipleContacts(){
        List<Account> accountsToInsert = new List<Account>();
        
        for(Integer var = 101; var<=111; var++ ){
            Account acc = new Account();
            acc.Name = 'Account ' + var;
            accountsToInsert.add(acc);
        }
        
        insert accountsToInsert;
        
        List<Contact> newContacts = new List<Contact>();
        
        for(Integer var1 = 1; var1 <= 10; var1++){
            Contact con = new Contact();
            con.LastName = 'Contact ' + var1;
            con.AccountId = accountsToInsert[var1].Id;
            newContacts.add(con);
        }
        
        insert newContacts;
        
    }
    
    // 3. Create 20 Opportunity with Closed Date, Stage and Opportyunity Name. With all the accounts attached, which are created in the first step.
    public static void createMuliptleOpp(){
        List<Account> accList = new List<Account>();
        
        for(Integer var = 51; var<=71; var++){
            Account acc = new Account();
            acc.Name = 'oppAccount ' + var;
            accList.add(acc);
        }
        insert accList;
        
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(Integer var1 = 0; var1<=19; var1++){
            Opportunity opp = new Opportunity();
            opp.Name = 'Opp ' + (var1 + 1);
            opp.StageName = 'Prospecting1';
            opp.CloseDate = Date.newInstance(2024, 08, 13);
            opp.AccountId = accList[var1].Id;
            oppList.add(opp);
        }
        insert oppList;
    }
    
    // 4. Create 10 Products with different Product Names, Description & Family 
    public static void createProduct(){
        List<Product2> prodList = new List<Product2>();
        
        for(Integer var = 1; var<=10; var++){
            Product2 prod = new Product2();
            prod.Name = 'New Product ' + var;
            prod.Description = 'Description...';
            prod.Family = 'myFam';
            prodList.add(prod);
        }
        insert prodList;
    }
    
    // 5. Delete all contacts belonging to Accounts Name FIELD having 'A' in them.
    public static void deleteContacts(){
        
        List<Contact> conList = [SELECT Id 
                                 FROM Contact
                                 WHERE Account.Name LIKE '%A%'];
        
        if(!conList.isEmpty()){
            // delete conList;
            System.debug('Sucessfully deleted contact = ' + conList.size());
        }else{
            System.debug('No Contacts matched the criteria.');
        }
        
    }  
    
    // 6. Update all Opportunity with future Closed Date by Opportunity Name=Opportunity Name + 'F' 
    public static void updateOppName(){
        List<Opportunity> oppList = [SELECT Id, Name from Opportunity WHERE CloseDate > :Date.today()];
        System.debug(oppList);
        System.debug(oppList.size());
        
        if(!oppList.isEmpty()){
            for(Opportunity opp : oppList){
                opp.Name += ' F';
            }
            Update oppList;
            
            System.debug('Number of Opportunities Updated = ' + oppList.size());
            
            for(Opportunity opp: oppList){
                System.debug('New Opp Name = ' + opp.Name);
            }
        }   
    }
    
    // 8. Create a apex class with a function that show  a message "Welcome to Salesforce "
    public static String welcomeMessage(){
        return 'Welcome to Salesforce :)';       
    }
    
    // 9. Display the current salesforce user details 'Name', 'Number' & 'EmailId'
    public static void currentUserDetails(){
        User currUser = [SELECT Id,Name,Phone, Email, Username from User where Id = :UserInfo.getUserId()];       
        System.debug(currUser.Name);
        System.debug(currUser.Email);
        System.debug(currUser.Phone);
        System.debug(currUser.Username);
    }    
    
    // 10. Print the Account Names in Alphabetical accending order.
    public static void accNames(){
        List<Account> accList = [SELECT Id,Name FROM Account ORDER BY Name ASC ];
        if(!accList.isEmpty()){
            for(Account acc : accList){
                System.debug('Account Name ' + acc.Name);
            }
        }  
    }
    
    // 11. Print the Account Name in reverse order Ex: Name='Company' => 'ynapmoC'
    public static void accReverse(){
        List<Account> accList = [SELECT Name from Account];
        if(!accList.isEmpty()){
            for(Account acc : accList){
                acc.Name = reverseName(acc.Name);
            }
            update accList;
        }
    }
    
    public static String reverseName(String input) {
        String reversed = '';
        for (Integer i = input.length() - 1; i >= 0; i--) {
            reversed += input.substring(i, i+1);
        }
        return reversed;
    }
    
    // 12. Print the fionacci series. 1, 1, 2, 3, 5, 8, 13..
    public static void fibonacciSeries(){
        List<Integer> fibbList = new List<Integer>();
        Integer lastNum = 54, firstNum = 0, secondNum = 1;       
        fibbList.add(firstNum);
        
        for(Integer i = 1; i<=lastNum; i++){
            Integer j = firstNum + secondNum;
            if(j > 44){
                break;
            }
            firstNum = secondNum;
            secondNum = j;
            fibbList.add(j);
        }
        System.debug(fibbList);
    }
    
    // 13. Print any Integer number in reverse order. Ex: 789234  => 432987 
    public static void reverseInteger(){
        Integer num = 12345;
        num = reverseNum(num);
        System.debug('Reversed Number is ' + num);
    }
    
    public static Integer reverseNum(Integer input){
        String rev = String.valueOf(input);
        String reversed = '';
        for (Integer i = rev.length() - 1; i >= 0; i--) {
            reversed += rev.substring(i, i+1);
        }
        return Integer.valueOf(reversed);
    }
    
    // 14. Find all the Products having Description field containing 'a' in it.
    public static void productDescription(){
        List<Product2> prodList = [SELECT Id,Description from Product2 WHERE Description LIKE '%a%'];
        System.debug(prodList);
    }    
    
    // 15. WAP to enter a startDate='06:07:55 2-jan-2016' & endDate='07:08:55 5-feb-2016' and 
    //display the difference between two dates in Years, months, days, hours, minutes,seconds.
    public static void differenceOfDates(){
        DateTime startDate = DateTime.newInstance(2016, 1, 2, 6, 7, 55);
        // DateTime endDate = DateTime.newInstance(2016, 2, 5, 7, 8, 55);
        DateTime endDate = Date.today();
        
        Long diffInSeconds = (endDate.getTime() - startDate.getTime()) / 1000;
        
        Integer years = (Integer)(diffInSeconds / (365 * 24 * 60 * 60));
        diffInSeconds -= years * 365 * 24 * 60 * 60;
        
        Integer months = (Integer)(diffInSeconds / (30 * 24 * 60 * 60));
        diffInSeconds -= months * 30 * 24 * 60 * 60;
        
        Integer days = (Integer)(diffInSeconds / (24 * 60 * 60));
        diffInSeconds -= days * 24 * 60 * 60;
        
        Integer hours = (Integer)(diffInSeconds / (60 * 60));
        diffInSeconds -= hours * 60 * 60;
        
        Integer minutes = (Integer)(diffInSeconds / 60);
        diffInSeconds -= minutes * 60;
        
        Integer seconds = (Integer)(diffInSeconds);
        
        System.debug('Difference: ' + years + ' Years, ' + months + ' Months, ' + days + ' Days, ' +
                     hours + ' Hours, ' + minutes + ' Minutes, ' + seconds + ' Seconds.');
    }
    
    // 16. Create New Price book 'Algo Pricebook' and 10 Products with Prices in the Pricebook
    public static void productPriceBook(){
        Pricebook2 pb2 = new Pricebook2();
        pb2.Name = 'Algo Pricebook';
        pb2.IsActive = True;
        insert pb2;
        
        List<Product2> prodList = new List<Product2>();
        for(Integer i=1; i<=10; i++){
            Product2 prod = new Product2();
            prod.Name = 'Laptop' + i;
            prod.IsActive = True;
            prodList.add(prod);
        }
        insert prodList;
        
        Id standardPricebookId = [SELECT Id FROM Pricebook2 WHERE IsStandard = true LIMIT 1].Id;
        
        List<PricebookEntry> standardPbes = new List<PricebookEntry>();
        List<PricebookEntry> customPbes = new List<PricebookEntry>();
        
        for (Product2 prod : prodList) {
            PricebookEntry standardPbe = new PricebookEntry();
            standardPbe.Pricebook2Id = standardPricebookId;
            standardPbe.Product2Id = prod.Id;
            standardPbe.UnitPrice = 100000; 
            standardPbe.IsActive = true;
            standardPbes.add(standardPbe);
            
            PricebookEntry customPbe = new PricebookEntry();
            customPbe.Pricebook2Id = pb2.Id;
            customPbe.Product2Id = prod.Id;
            customPbe.UnitPrice = 90000; 
            customPbe.IsActive = true;
            customPbes.add(customPbe);
        }
        
        insert standardPbes;
        insert customPbes;
    }
    
    // 17. WAP to add two binary nos. '100101' & '0101101' which are in text format. 
    public static void addNums(){
        String num1 = '1122';
        String num2 = '1';
        
        Integer sum =  Integer.valueOf(num1) + Integer.valueOf(num2);
        System.debug(sum);
    }
    
    // 18. Write a program in Salesforce to create another System admin user in your dev org with your email. Register the user manually.
    public static void createUser(){
        User newUser = new User();
        Profile sysAdminProfile = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        
        newUser.LastName = 'Required';
        newUser.Email = 'saarthak.malik@caeliusconsulting.com';
        newUser.ProfileId = sysAdminProfile.Id;
        newUser.Username = 'testingusername@abc.com.dev1';
        newUser.Alias = 'testUser';
        newUser.IsActive = True;
        newUser.TimeZoneSidKey = 'America/Los_Angeles'; 
        newUser.LocaleSidKey = 'en_US'; 
        newUser.EmailEncodingKey = 'UTF-8'; 
        newUser.LanguageLocaleKey = 'en_US'; 
        
        try{
            insert newUser;
            System.debug('Succesfully created the user.');
            
        }catch(DmlException e){
            System.debug('Error creating the user ' + e.getMessage());
        }        
    }
    
    // 19. WAP to create 5 Case Records with all the values(Account, Contact, etc) filled in.
    public static void newCase(){
        Account acc  =new Account();
        acc.Name = 'Test Account **APEX**';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'Test Contact **APEX**';
        con.AccountId = acc.Id;
        insert con;
        
        List<Case> caseList = new List<Case>();
        for(Integer i=1; i<=5; i++){
            Case newCase = new Case();
            newCase.AccountId = con.AccountId;
            newCase.ContactId = con.Id;
            newCase.Description = 'Interesting...';
            newCase.Origin = 'Email';
            newcase.Subject = 'Apex is cool!';
            caseList.add(newCase);
        } 
        try{
            insert caseList;
            System.debug('Successfully created five cases.');
        }catch(DmlException e){
            System.debug('Insertion failed due to ' + e.getMessage());
            
        }
    }
    
    // 20.  Manually add 2 (jpg and PDF) attachments under Accounts related list. WAP to copy the attachments to Contact associated(parent child) with Account.
    public static void copyAttachments(Id accountId){
        List<ContentDocumentLink> attachList = [SELECT ContentDocumentId,Id,LinkedEntityId,ShareType FROM ContentDocumentLink WHERE LinkedEntityId = :accountId];
        
        List<Contact> conList = [SELECT Id,Name FROM Contact WHERE AccountId = :accountId];
        
        List<ContentDocumentLink> newattachList = new List<ContentDocumentLink>();
        
        if(!conList.isEmpty() && !attachList.isEmpty()){
            for(Contact con: conList){
                for (ContentDocumentLink cdl : attachList) {
                    ContentDocumentLink newLink = new ContentDocumentLink();
                    newLink.ContentDocumentId = cdl.ContentDocumentId;
                    newLink.LinkedEntityId = con.Id; 
                    newLink.ShareType = 'V'; 
                    newattachList.add(newLink);                 
                }
            }
            try{
                insert newattachList;
                System.debug('Successfully attached to related Contacts.');
            }catch(DmlException e){
                System.debug('Failed to attach due to >>>' + e.getMessage());
            }
        }
    }
    
    // 21. Write a code to clone(copy) 1 Opportunity with all Opportunity line items into a new Opportunity with Closed Date = Old closed date + 30 days & Opportunity name = Opportunity Name+ 'Clone'
    public static Opportunity cloneOpp(Id oppId) {
        Opportunity originalOpp = [SELECT Id, Name, CloseDate, StageName, AccountId, Amount, Probability, 
                                   Type, LeadSource, NextStep, OwnerId  
                                   FROM Opportunity WHERE Id = :oppId];
        
        List<OpportunityLineItem> oppLineItemList = [SELECT Id, Product2Id, UnitPrice, Quantity, 
                                                     Description, PricebookEntryId 
                                                     FROM OpportunityLineItem 
                                                     WHERE OpportunityId = :oppId];
        
        Opportunity newOpp = originalOpp.clone(false, false, false, false);
        newOpp.Name = originalOpp.Name + ' Clone';
        newOpp.CloseDate = originalOpp.CloseDate.addDays(30);
        
        insert newOpp;
        
        List<OpportunityLineItem> newoppLineItemList = new List<OpportunityLineItem>();
        
        for (OpportunityLineItem oli : oppLineItemList) {
            OpportunityLineItem newOli = new OpportunityLineItem();
            newOli.OpportunityId = newOpp.Id;
            newOli.Product2Id = oli.Product2Id;
            newOli.UnitPrice = oli.UnitPrice; 
            newOli.Quantity = oli.Quantity;   
            newOli.Description = oli.Description;
            newOli.PricebookEntryId = oli.PricebookEntryId;
            newoppLineItemList.add(newOli);
        }
        
        if (!newoppLineItemList.isEmpty()) {
            insert newoppLineItemList;
            System.debug('Successfully created new Opportunity and its related Opportunity Line Items.');
        } else {
            System.debug('No Opportunity Line Items to clone.');
        }
        
        return newOpp;
    }
    
    
    // 22. Write a Script to get all the Accounts having Oppotunity Line Items Quantity > 100 under their Opportunities(CLOSED WON only).
    public static void getAccountOpp(){
        List<Opportunity> oppList = [SELECT Id, AccountId FROM Opportunity 
                                     WHERE StageName = 'Closed Won' 
                                     AND Id IN (SELECT OpportunityId FROM OpportunityLineItem WHERE Quantity > 100)];
        
        System.debug(oppList);
        
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : oppList) {
            accountIds.add(opp.AccountId);
        }
        
        List<Account> accountList = new List<Account>();
        if (!accountIds.isEmpty()) {
            accountList = [SELECT Id, Name FROM Account WHERE Id IN :accountIds];
        }
        System.debug('Accounts with Opportunities having Line Items Quantity > 100: ' + accountList);
    }
    
    // 23. Create a new multiplicklist field In Lead Object"Records" [Buyer, Seller, Tenant , Landloard]. Write script to fetch all the Sellers and Tenant which were entered in last year.
    public static void leadMultiPicklist(){
        Date oneYearAgo = Date.today().addYears(-1);
        
        List<Lead> leadList = [SELECT Id, Records__c, CreatedDate FROM Lead WHERE Records__c INCLUDES ('Seller', 'Tenant') AND CreatedDate >= :oneYearAgo];
        
        if(!leadList.isEmpty()){
            System.debug(leadList);
        }else{
            System.debug('No Leads present that match such criteria');
        }
    }
    
    /* 24. Create a Custom Object Plan. Create 2 fields in Plan. 
1. Travel Hours(Integers)
2. Travel Location(A,B,C,D,E,F) Multipicklist.
Write a script to get the total hours of all the Plans record having Multipicklist A or F selected only or with other values.*/
    public static void planRecords(){
        List<Plan__c> planList = [SELECT Id, Name, Travel_Hours__c 
                                  FROM Plan__c 
                                  WHERE Travel_Location__c INCLUDES ('A')
                                  OR Travel_Location__c INCLUDES ('F')];
        
        Decimal totalHours = 0;
        
        if(!planList.isEmpty()){
            for(Plan__c plan : planList){
                totalHours += plan.Travel_Hours__c;
            }
            System.debug(totalHours);
        }
    }
    
    /* 25. Create an Object "Event" (Name Default field and "Event Date" Date time field). Another Junction Object "Event Participant" with 3 fields
1. lookup Contact
2. lookup Event
3. multipicklist ("Attendee Contact", "Presenter Contact","Organizer Contact")
Write a script to create 10 "Event Participant" with 4 Attendee picklist, 4 with Presenter, 2 with organizer.*/
    
    public static void eventParticipant(){
        Account acc = new Account();
        acc.Name = 'Event Account';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'Event Contact';
        con.AccountId = acc.Id;
        insert con;
        
        Event__c singleEventRecord = new Event__c();
        singleEventRecord.Name = 'Second Event';
        singleEventRecord.Event_Date__c = DateTime.newInstance(2025, 22, 08, 22, 22, 22);
        insert singleEventRecord;
        
        List<Event_Participant__c> epList = New List<Event_Participant__c>();
        
        for(Integer i=1; i<=10; i++){
            Event_Participant__c epRecord = new Event_Participant__c();
            epRecord.Name = 'EP ' + i;
            epRecord.Contact__c = con.Id;
            epRecord.Custom_Event__c = singleEventRecord.Id;
            if(i<=4){
                epRecord.Contact_Type__c = 'Attendee Contact';
            }
            if(i<=8){
                epRecord.Contact_Type__c = 'Presenter Contact';
            }
            if(i<=10){
                epRecord.Contact_Type__c = 'Organizer Contact';
            }
            
            epList.add(epRecord);
            
        }
        
        if(!epList.isEmpty()){
            try{
                insert epList;
                System.debug('Successfully created Event Paticipant Records.');
            }catch(DmlException e){
                System.debug(e.getMessage());
            }
        }
    }
    
    //26. Write a Script to get all the Accounts having more than 2 Oppotunity Line Items in their Opportunity.
    //public staic void accOpp(){
    //  List<
    //}
    
    
    //27. In Account Object create a Multi picklist "Working in (ASIA, EMA, NA, SA)".
    // Write a script to get the total "No of employees"  of all the Accounts working in ASIA and NA(North America)
    public static void accEmployees(){
        List<Account> accList = [SELECT Id, NumberOfEmployees
                                 FROM Account
                                 WHERE Working_In__c INCLUDES ('ASIA','NA')];
        Integer totalEmployees = 0;
        
        if(!accList.isEmpty()){
            for(Account acc : accList){
                totalEmployees += acc.NumberOfEmployees;
            }
        }
        System.debug('Total Number of Employees working in ASIA and NA are ' + totalEmployees);
    }
    
    //28. Write a Script to get all the Contacts having same email as any Salesforce User.Email
    public static void conEmail(){
        
        User userId = [SELECT Email FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
        List<Contact> contactEmails = [SELECT Id, Email FROM Contact WHERE Email = :userId.Email];
        
        System.debug(contactEmails);
    }
    
    //29. Create a new Product "Gandhiji Chasma". Add Price as 100$ in standard price book and any other price books as well. 
    //Create few oppportunites with Opportunity line item "Gandhiji Chasma". 
    //Write a script to get the total Price of all the Opportunity sold(Closed Won) having Product "Gandhiji Chasma"
    
    public static void gandhiTookOppFromIronMan(){
        List<OpportunityLineItem> oliList =[SELECT OpportunityId,TotalPrice FROM OpportunityLineItem WHERE Product2.Name = 'Gandhiji Chasma' AND Opportunity.StageName = 'Closed Won'];
        Decimal totalPrice = 0;
        List<Id> oppList = new List<Id>();
        
        if(!oliList.isEmpty()){
            for(OpportunityLineItem oli : oliList){
                totalPrice += oli.TotalPrice;
                oppList.add(oli.OpportunityId);
            }
        }
        System.debug('Total Price from the Opportunities is ' + totalPrice);
        System.debug(oppList);     
    }
    
    //30. Create several Accounts and Opportunites and products. Write a Script to get all the Accounts having more than 2 Opportunites with Closed Won.
    public static void accOpportunities(){
        List<AggregateResult> aggResults = [SELECT AccountId FROM Opportunity WHERE StageName = 'Closed Won' GROUP BY AccountId HAVING COUNT(AccountId) >= 2];
        
        Set<Id> accId = new Set<Id>();
        for(AggregateResult agg : aggResults){
            accId.add((Id)agg.get('AccountId'));
        }
        
        System.debug(accId);
    }
    
    //31. Create a look up[Lead] on product so that Products come over in related list of a Lead.  Write script to create 3 Leads and 5 Products with Lead lookup field.
    public static void getleads(){
        List<Lead> leadList = new List<Lead>();
        for(Integer i = 1; i<=3; i++){
            Lead leadRecord = new Lead();
            leadRecord.LastName = 'Testing Lead ' + i;
            leadRecord.Company = 'Testing Company';
            leadRecord.Status = 'Closed - Converted';
            leadList.add(leadRecord);
        }
        insert leadList;
        
        List<Product2> prodList = new List<Product2>();
        Integer leadIndex = 0;
        Integer totalLeads = leadList.size();
        
        for(Integer j = 0; j <= 4; j++) {
            Product2 prod = new Product2();
            prod.Name = 'Testing Product ' + (j + 1);
            prod.Lead__c = leadList[leadIndex].Id;
            prodList.add(prod);
            leadIndex++;
            if (leadIndex > totalLeads) {
                leadIndex = 0;  
            }
        }
        insert prodList;
    }
    
    //32. In Account Object create a Multi picklist "Working in (ASIA, EMA, NA, SA)" Multipicklist.
    //Write a script to get the total Quantity of Products sold in only Accounts working in ASIA.
    public static void accountProducts(){
        List<Account> accList = [SELECT Id, Name FROM Account WHERE Working_In__c INCLUDES ('ASIA')];
        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE AccountId IN :accList];
        
        if(!accList.isEmpty()){
            // Fetch Products quantity from OppLineItems where account id is from above list
            AggregateResult results = [SELECT SUM(Quantity) FROM OpportunityLineItem where OpportunityId IN :oppList];
            
            System.debug('Total Quanity of Products Working In ' + results);
        }else{
            System.debug('No Accounts have Products Working In ASIA.');
        }
    }
    
    //33. Create a Script to find out all the users in the systems who are having more than 20 Leads allocated[Owner] to them in month of Dec 2017
    public static void userLead(){
        Date startDate = Date.newInstance(2024, 7, 1);
        Date endDate = Date.newInstance(2024, 9, 1);
        
        List<AggregateResult> resultList = [SELECT OwnerId, COUNT(Id) FROM Lead WHERE CreatedDate >= :startDate AND CreatedDate < :endDate
                                            GROUP BY OwnerId
                                            HAVING COUNT(OwnerId) > 20 ];
        
        if(!resultList.isEmpty()){
            for (AggregateResult ar : resultList) {
                Id userId = (Id) ar.get('OwnerId');  
                Decimal leadCount = (Decimal) ar.get('expr0');  
                System.debug('User Id: ' + userId + ' has ' + leadCount + ' leads assigned in December 2017');
            }
        }
        else{
            System.debug('No Leads created in the month of Dec 2017.');
        }
    } 
    
    //34.  Write a script to get all the Account having more than 10 opportunities whose status is closed won and the close date is between one month.
    
    public static void accountOpportunities(){
        Date endDate = Date.Today().addMonths(1);
        List<AggregateResult> arList = [SELECT AccountId FROM Opportunity WHERE CloseDate < :endDate AND StageName = 'Closed Won' GROUP BY AccountId HAVING COUNT(Id) > 10];
        System.debug(arList);
        List<Id> accIdList = new List<Id>();
        if(!arList.isEmpty()){
            for(AggregateResult ar : arList){
                accIdList.add((Id) ar.get('AccountId')); 
            }
        }
        System.debug(accIdList);
    }
    
    // Write a script to send Email to all users which are having more than 100 Account (Having phone number) and 30 contacts(Having email address).
    public static void sendEmailtoUsers(){
        List<AggregateResult> arAccountList = [SELECT OwnerId FROM Account GROUP BY OwnerId HAVING COUNT(Id) > 2];
        List<AggregateResult> arContactList = [SELECT OwnerId FROM Contact GROUP BY OwnerId HAVING Count(Id) > 3];
        Set<Id> uniqueUsers = new Set<Id>();
        
        if(!arAccountList.isEmpty() || !arContactList.isEmpty()){
            for(AggregateResult arAccount : arAccountList){
                uniqueUsers.add((Id) arAccount.get('OwnerId'));
            }
            for(AggregateResult arContact : arContactList){
                uniqueUsers.add((Id) arContact.get('OwnerId'));
            }
        }
        System.debug('List of Owner Id >>> ' + uniqueUsers);
        
        List<User> userEmail = [SELECT Id, Email, Name FROM User WHERE Id IN :uniqueUsers];
        
        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        
        if(!uniqueUsers.isEmpty()){
            for(User user : userEmail){
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new List<String>{user.Email});
                email.setSubject('Account and Contact Ownership Notification');
                email.setPlainTextBody('Hello ' + user.Name + ',\n\n This is Salesforce Notifictaion Email Body.');
                
                emailMessages.add(email);
            }
        }
        
        if(!emailMessages.isEmpty()){
            try{
                Messaging.sendEmail(emailMessages);
            }catch(DmlException e){
                System.debug(e.getMessage());
            }
        }
        
        //  System.debug('Emails sent to Users: ' + uniqueUsers);
    }
    
    
    //Write a script to get all Account those are associated with opportunity and put the attachment from account to their opportunity.
    // If the account does not have attachment put opportunity close lost otherwise close won.   
    public static void accountOpportunity(){
        List<Opportunity> oppList = [SELECT Id, AccountId, Stagename FROM Opportunity WHERE AccountId != null];
        Set<Id> uniqueAccount = new Set<Id>();
        
        for(Opportunity opp : oppList){
            uniqueAccount.add(opp.AccountId);
        }
        
        List<ContentDocumentLink> accountAttachments = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId IN : uniqueAccount];
                
        Map<Id, List<ContentDocumentLink>> accountToAttachments = new Map<Id, List<ContentDocumentLink>>();
        
        for (ContentDocumentLink attachment : accountAttachments) {
            if (!accountToAttachments.containsKey(attachment.LinkedEntityId)) {
                accountToAttachments.put(attachment.LinkedEntityId, new List<ContentDocumentLink>());
            }
            accountToAttachments.get(attachment.LinkedEntityId).add(attachment);
        }
        
        // Prepare lists for update and attachment linking
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        List<ContentDocumentLink> oppAttachments = new List<ContentDocumentLink>();
        
        // Loop through each opportunity
        for(Opportunity opp : oppList) {
            if (accountToAttachments.containsKey(opp.AccountId)) {
                // If the account has attachments, copy them to the opportunity and mark it as Closed Won
                List<ContentDocumentLink> attachments = accountToAttachments.get(opp.AccountId);
                
                for (ContentDocumentLink attachment : attachments) {
                    // Create new ContentDocumentLink to link to Opportunity
                    ContentDocumentLink oppAttachment = new ContentDocumentLink();
                    oppAttachment.ContentDocumentId = attachment.ContentDocumentId;
                    oppAttachment.LinkedEntityId = opp.Id; // Link to the opportunity
                    oppAttachments.add(oppAttachment);
                }
                
                // Set Opportunity Stage to 'Closed Won'
                opp.StageName = 'Closed Won';
            } else {
                // If no attachments, mark the opportunity as Closed Lost
                opp.StageName = 'Closed Lost';
            }
            oppToUpdate.add(opp);
        }
        
        // Update the opportunity records
        if (!oppToUpdate.isEmpty()) {
            update oppToUpdate;
        }
        
        // Insert the new opportunity attachments
        if (!oppAttachments.isEmpty()) {
            insert oppAttachments;
        }
        
        System.debug('Opportunities updated: ' + oppToUpdate.size());
        
    }
}