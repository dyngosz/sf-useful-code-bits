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
}
