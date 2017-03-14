trigger SPE_ContactTrigger on Contact (before insert,before update) 
{
    SPE_ContactTrigger.GeneratePassword(trigger.new);
}