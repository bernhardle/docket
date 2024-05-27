function validator(theForm)
{

  return (true);

  if (theForm.psa.value != theForm.psb.value)
  {
    alert("Das Kennwort ist nicht richtig bestätigt.");
    theForm.psb.focus();
    return (false);
  }

  var checkOK = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789" ;
  var checkStr = theForm.pso.value;
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
    alert("Geben Sie nur Buchstaben und Ziffern in das Feld \"Altes Kennwort\" ein.");
    theForm.pso.focus();
    return (false);
  }
  checkStr = theForm.psa.value;
  allValid = true;
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
    alert("Geben Sie nur Buchstaben und Ziffern in das Feld \"Neues Kennwort\" ein.");
    theForm.psa.focus();
    return (false);
  }
  checkStr = theForm.psb.value;
  allValid = true;
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
    alert("Geben Sie nur Buchstaben und Ziffern in das Feld \"Neues Kennwort bestätigen\" ein.");
    theForm.psb.focus();
    return (false);
  }
  return (true);
}