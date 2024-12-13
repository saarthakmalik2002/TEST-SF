public class testPractice {
    public static void contactOpportunity(Id contactId){
        List<ContentDocumentLink> attachList = [SELECT Id, ContentDocumentId, LinkedEntityId, ShareType FROM ContentDocumentLink WHERE LinkedEntityId =: contactId];
        Contact contact = [SELECT Id, AccountId FROM Contact WHERE Id = :contactId];
        
        List<Opportunity> oppList = [SELECT Id, AccountId FROM Opportunity WHERE AccountId = :contact.AccountId];
        System.debug(oppList);
        
        List<ContentDocumentLink> newCDLList = new List<ContentDocumentLink>();
        
        if(!oppList.isEmpty()){
            for(Opportunity opp : oppList){
                for(ContentDocumentLink oldCDL: attachList){
                    ContentDocumentLink newCDL = new ContentDocumentLink();
                    newCDL.LinkedEntityId = opp.Id;
                    newCDL.ContentDocumentId = oldCDL.ContentDocumentId;
                    newCDL.ShareType ='V';
                    newCDLList.add(newCDL);
                }
            }
        }
        try{
            insert newCDLList;
            System.debug('Succesfully Inserted Files on related Opportunities.');
        }catch(DmlException e){
            System.debug('Failed to upload file due to >>> ' + e.getMessage());
        }
    }
}