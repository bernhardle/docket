function validator (theForm)
{
  return true ;

  if (theForm.login.value == "0")
  {
    alert("Wählen Sie eine Benutzerkennung aus.");
    theForm.login.focus();
    return (false);
  }

  var checkOK = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  var checkStr = theForm.passwd.value;
  var allValid = true;
  for (i = 0;  i < checkStr.length;  i++)
  {
    ch = checkStr.charAt(i);
    for (j = 0;  j < checkOK.length;  j++)
      if (ch == checkOK.charAt(j))
        break;
    if (j == checkOK.length)
    {
      allValid = false;
      break;
    }
  }
  if (!allValid)
  {
    alert("Geben Sie nur Buchstaben und Ziffern in das Kennwortfeld ein.") ;
    theForm.passwd.focus();
    return (false);
  }
  return (true) ;
}