
# HelloID-Task-SA-Target-ActiveDirectory-AccountUpdate

## Prerequisites

- [ ] The HelloID SA on-premises agent installed

- [ ] The ActiveDirectory module is installed on the server where the HelloID SA on-premises agent is running.

## Description

This code snippet executes the following tasks:

1. Define a hash table `$formObject`. The keys of the hash table represent the properties of the `Set-ADUser` cmdlet, while the values represent the values entered in the form.

> To view an example of the form output, please refer to the JSON code pasted below.

```json
{
    "UserPrincipalName": "",
    "Title": "",
    "Department": "",
    "OfficePhone": "",
    "EmployeeID": ""
}
```

> :exclamation: It is important to note that the names of your form fields might differ. Ensure that the `$formObject` hashtable is appropriately adjusted to match your form fields.

2. Imports the ActiveDirectory module.

3. Retrieve the account object using the `Get-ADUser` cmdlet.

4. Update the account using the `$user` object retrieved from step 3. The hash table called `$formObject` is passed to the `Set-ADUser` cmdlet using the `@` symbol in front of the hash table name.

> :bulb: Splatting is a technique in PowerShell where you store the parameters and their values in a hash table, and then pass the hash table to a cmdlet or function.
