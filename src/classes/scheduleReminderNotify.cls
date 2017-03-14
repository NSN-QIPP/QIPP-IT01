global class scheduleReminderNotify implements Schedulable {
    global void execute(SchedulableContext sc) {
        reminderNotify en = new reminderNotify();
        Database.executeBatch(en);
    }
}