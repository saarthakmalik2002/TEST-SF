public class OpportunityTriggerhandler {
    public static void futureClosedDate(List<Opportunity> oppList){
        if(!oppList.isEmpty()){
            for(Opportunity opp : oppList){
                if(opp.CloseDate < Date.Today()){
                    opp.addError('Please enter a future Closed Date.');
                }
            }
        }
        
    }
    
}