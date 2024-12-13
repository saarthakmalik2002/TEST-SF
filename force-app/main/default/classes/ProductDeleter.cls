public class ProductDeleter {
    public void deleteOldProducts() {
        Date currentDate = Date.today();
        Date cutoffDate = Date.newInstance(2024, 1, 10);

        List<Product2> productsToDelete = [SELECT Id FROM Product2 WHERE CreatedDate > :cutoffDate];

        try {
            delete productsToDelete;
            System.debug('Product records deleted successfully.');
        } catch (DmlException e) {
            System.debug('Error deleting product records: ' + e.getMessage());
            // Handle the exception or log the error as needed
        }
    }
}

// Usage example:
// Call the method from your Salesforce trigger, batch class, or execute anonymous code block