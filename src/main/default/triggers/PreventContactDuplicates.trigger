/**
 * @description       : 
 * @author            : Paul-Nasser Dawod BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-21-2023
 * @last modified by  : Paul-Nasser Dawod, BearingPoint GmbH
**/
trigger PreventContactDuplicates on Contact (before insert, before update) {
    switch on Trigger.operationType{
        when BEFORE_INSERT{
            ContactTriggerHandler.checkContactDuplicate(Trigger.new);
        }
        when BEFORE_UPDATE{
            ContactTriggerHandler.checkContactDuplicate(Trigger.new);
        }
    }
}