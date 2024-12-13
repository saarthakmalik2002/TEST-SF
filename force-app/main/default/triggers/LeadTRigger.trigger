trigger LeadTRigger on Lead ( Before Update) {
    if(Trigger.isUpdate && Trigger.isBefore ){
        LeadTriggerHandler.tickCheckbox(trigger.new);
        }
    }