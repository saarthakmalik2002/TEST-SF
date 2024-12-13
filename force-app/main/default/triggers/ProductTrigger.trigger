trigger ProductTrigger on Product2 (after insert) {
    if(Trigger.isInsert && Trigger.isAfter ){
        ProductHandler.defaultPriceBookEntry(Trigger.new);
    }
}