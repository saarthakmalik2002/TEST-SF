trigger OppClosedLost on Opportunity (before update) {
    for (Opportunity opp : Trigger.new) {
        if (opp.StageName == 'Close Lost' && String.isBlank(opp.Loss_Reason__c)) {
            opp.addError('Loss Reason must be filled before changing the stage to Close Lost.');
        }
    }
}