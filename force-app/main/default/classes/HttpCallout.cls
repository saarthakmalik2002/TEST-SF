@RestResource(urlMapping='/showAccountsDetails')
global class HttpCallout
{
@HttpPost
global static LIST<Account> getAccount()
{
LIST<Account> lst;
try
{
lst = [select name,phone from Account];
return lst;
}
catch(Exception ex)
{
system.debug('Error'+ex.getMessage());
}
return lst;
}
}