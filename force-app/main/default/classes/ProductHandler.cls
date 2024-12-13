public class ProductHandler {
    public static void defaultPriceBookEntry(List<Product2> productList){
        Pricebook2 standardPricebook = [SELECT Id FROM Pricebook2 WHERE IsStandard = true LIMIT 1];
        
        List<PriceBookEntry> pricebookEntriesToCreate = new List<PriceBookEntry>();
        
        if(!productList.isEmpty()){
            for(Product2 prod : productList){
            PricebookEntry pbe = new PricebookEntry();
            pbe.Pricebook2Id = standardPricebook.Id; 
            pbe.Product2Id = prod.Id; 
            pbe.UnitPrice = 1; 
            pbe.IsActive = true; 
            pricebookEntriesToCreate.add(pbe);
            }
        }
        insert pricebookEntriesToCreate;
    }
}