public with sharing class UtilityClass {

    //    Method to get picklist values on any SObject field
    @AuraEnabled
    public static List<String> getPickListValues(String objectName, String fieldName) {
        List<String> pickListValuesList = new List<String>();

        DescribeSObjectResult objResult = Schema.getGlobalDescribe()
                .get(objectName).getDescribe();

        DescribeFieldResult fieldResult = objResult.fields.getMap()
                .get(fieldName).getDescribe();

        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry pickListVal : ple) {
            pickListValuesList.add(pickListVal.getLabel());
        }
        return pickListValuesList;
    }

    //    Method to get lookup object based on search query
    @AuraEnabled
    public static List <sObject> fetchLookUpValues(String searchKeyWord, String objectName) {
        String searchKey = '%' + searchKeyWord + '%';

        List <sObject> returnList = new List <sObject> ();

        String sQuery = 'SELECT Id, Name FROM ' + objectName + ' WHERE Name LIKE: searchKey';
        List <sObject> listOfRecords = Database.query(sQuery);

        for (sObject obj : listOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }
}
