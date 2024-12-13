trigger TaskTrigger on Task (before insert, before update) {
    TaskTriggerHandler.updateTaskDueDate(Trigger.new);

}