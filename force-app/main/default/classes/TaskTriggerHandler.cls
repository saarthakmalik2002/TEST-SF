/*public class TaskTriggerHandler {
    public static void handleTaskDueDate(List<Task> newTasks) {
        for (Task taskRecord : newTasks) {
            // Calculate due date as today + 7 days
            Date today = Date.today();
            Integer daysToAdd = 7;
            Date dueDate = today.addDays(daysToAdd);

            // Skip weekends (Saturday and Sunday)
            while (dueDate.day() == 1 ) {
                daysToAdd++;
                dueDate = today.addDays(daysToAdd);
            }
            while(dueDate.day() == 7 ) {
                daysToAdd+=2;
                dueDate = today.addDays(daysToAdd);
            }

            // Set the calculated due date to the task record
            taskRecord.ActivityDate = dueDate;
        }
    }
}
 

    /*public static void updateDueDate(List<Task> tasks) {
        for (Task taskRecord : tasks) {
            // Get the current due date
            Date currentDueDate = taskRecord.ActivityDate;

            // Calculate new due date as current due date + 7 days
            Date newDueDate = currentDueDate.addDays(7);

            // Skip weekends (Saturday and Sunday)
            while (isWeekend(newDueDate)) {
                newDueDate = newDueDate.addDays(1);
            }

            // Set the new due date to the task record
            taskRecord.ActivityDate = newDueDate;
        }
    }

    private static Boolean isWeekend(Date dateToCheck) {
        // Sunday (1) or Saturday (7) is considered a weekend
        return dateToCheck.day() == 1 || dateToCheck.day() == 7;
    }*/


public class TaskTriggerHandler {

    // Method to update Task due date to +7 days from creation date with consideration for business hours
    public static void updateTaskDueDate(List<Task> tasks) {
        // Define the number of days to add
        Integer daysToAdd = 7;

        // Loop through the tasks
        for (Task task : tasks) {
            // Check if the task is not closed
            if (!task.IsClosed) {
                // Calculate the new due date
                DateTime originalDueDate = task.ActivityDate;
                DateTime newDueDate = addBusinessDays(originalDueDate, daysToAdd);

                // Update the task due date
                task.ActivityDate = newDueDate.date(); // Use .date() to get the Date part
            }
        }

        // Update the tasks in the database
        update tasks;
    }

    // Helper method to add business days to a date
    private static DateTime addBusinessDays(DateTime inputDate, Integer businessDays) {
        // Retrieve the default business hours
        BusinessHours defaultBusinessHours = [SELECT Id FROM BusinessHours WHERE IsDefault = true LIMIT 1];

        // Calculate the new date
        DateTime newDate = BusinessHours.add(defaultBusinessHours.Id, inputDate, businessDays);

        return newDate;
    }
}