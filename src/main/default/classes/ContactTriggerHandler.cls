/**
 * @description       : 
 * @author            : Paul-Nasser Dawod BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-21-2023
 * @last modified by  : Paul-Nasser Dawod, BearingPoint GmbH
**/
public with sharing class ContactTriggerHandler {
    public static void checkContactDuplicate(List<Contact> contactTrigger) {

    Set<Id> contactFromTriggerIds = new Set<Id>();
    
    Set<String> firstNames = new Set<String>();
    Set<String> lastNames = new Set<String>();
    Set<String> emailsContacts = new Set<String>();
    Set<String> phoneContacts = new Set<String>();

    // Map<Id, String> firstNames = new Map<Id, String>();
    // Map<Id, String> lastNames = new Map<Id, String>();
    // Map<Id, String> emailsContacts = new Map<Id, String>();
    // Map<Id, String> phoneContacts = new Map<Id, String>();

    Map<String, List<Contact>>  newContactsByPhone = new Map<String, List<Contact>>();
    
    for(Contact cont: contactTrigger){
        contactFromTriggerIds.add(cont.Id);

        firstNames.add(cont.FirstName);
        lastNames.add(cont.LastName);
        emailsContacts.add(cont.Email);
        phoneContacts.add(cont.Phone);
        if(!newContactsByPhone.containsKey(cont.Phone))
        {
            newContactsByPhone.put(cont.Phone, new List<Contact>());
        }
        newContactsByPhone.get(cont.Phone).add(cont);
    }

    
    List<Contact> existingContacts = [SELECT FirstName, LastName, Phone, Email FROM CONTACT WHERE Id NOT IN :contactFromTriggerIds AND (FirstName IN: firstNames OR LastName IN:lastNames OR Email IN:emailsContacts OR Phone IN:phoneContacts)];
    
    

    for(Contact excont: existingContacts)
    {
        List<Contact> contactWithSamePhone =  newContactsByPhone.get(excont.Phone);
        if(contactWithSamePhone!= null){
            for(Contact contPhone : contactWithSamePhone){
                if(contPhone.FirstName.equals(excont.FirstName) && (contPhone.LastName.equals(excont.LastName)) && contPhone.Email.equals(excont.Email))
                {
                    contPhone.addError('This record is a duplicate!');
                }
            }
        }
    }
    }
}