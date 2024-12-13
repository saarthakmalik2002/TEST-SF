trigger OpportunityTrigger on Opportunity (before insert, before update) {
    if(Trigger.isInsert && Trigger.isBefore || Trigger.isUpdate && Trigger.isBefore){
        OpportunityTriggerhandler.futureClosedDate(Trigger.new);
        
    }
}