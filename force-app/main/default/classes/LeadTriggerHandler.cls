/*public class LeadTriggerHandler {
    public static void tickCheckbox(List<Lead> newLeads){
        for(Lead leadRecord:newLeads){
            if(leadRecord.Choose_User__c.contains('End User')){
                leadRecord.Tick_for_End_User__c=True;
            }
                else{
                leadRecord.Tick_for_End_User__c=False;
        }
    }
    }
    }*/

// Correct Script-->

public class LeadTriggerHandler {
    public static void tickCheckbox(List<Lead> newLeads){
        for(Lead leadRecord : newLeads){
            if (leadRecord.Choose_User__c != null && leadRecord.Choose_User__c.contains('End User')) {
                leadRecord.Tick_for_End_User__c = true;
            } else {
                leadRecord.Tick_for_End_User__c = false;
            }
        }
           String message = scriptPractice.welcomeMessage();
    system.debug(message);
    } 
}