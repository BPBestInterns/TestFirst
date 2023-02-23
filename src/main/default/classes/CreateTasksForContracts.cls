/**
 * @description       : 
 * @author            : Paul-Nasser Dawod BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-23-2023
 * @last modified by  : Paul-Nasser Dawod, BearingPoint GmbH
**/
public with sharing class CreateTasksForContracts implements Database.Batchable<SObject>{
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT  Id,OwnerId, EndDate FROM Contract WHERE EndDate < NEXT_N_DAYS:30');
    
    }
    public void execute(Database.BatchableContext bc, List<Contract> records){
        List<Task> taskList = new List<Task>();
        For(Contract cont : records) {
            Task newTask = new Task(
                 WhatId = cont.Id,
                 OwnerId = cont.OwnerId,
                 ActivityDate = Date.today(),
                 Subject = 'Contact Account to renew contract that expires' + cont.id,
                 Description = 'Contact Account to renew Contract');
                 taskList.add(newTask);
              }
              insert taskList;
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Job Done!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
    }
}