/**
 * @description       : 
 * @author            : Paul-Nasser Dawod BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-23-2023
 * @last modified by  : Paul-Nasser Dawod, BearingPoint GmbH
**/

//  Schedule in the UI or in console using:
// RemindContractOwnerOfExpiration remind = new RemindContractOwnerOfExpiration();
// String sch = '0 0 9 * * * *';
// String jobID = System.schedule('DailyTask Job', sch, remind);
global class RemindContractOwnerOfExpiration implements Schedulable {
    global void execute(SchedulableContext ctx) {
        CreateTasksForContracts create = new CreateTasksForContracts();
        Database.executeBatch(create);
    }
}