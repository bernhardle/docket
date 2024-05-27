function validator(theForm) 
{

  return (true) ;

  if (theForm.lgn.value == "")
  {
    alert("Geben Sie einen Wert in das Feld \"Kürzel\" ein.");
    theForm.lgn.focus();
    return (false);
  }

  if (theForm.lgn.value.length > 4)
  {
    alert("Geben Sie höchstens 4 Zeichen in das Feld \"Kürzel\" ein.");
    theForm.lgn.focus();
    return (false);
  }

  checkOK = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÄÜÖäüö" ;
  checkStr = theForm.lgn.value;
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
    alert("Geben Sie nur Buchstaben in das Feld \"Kürzel\" ein.");
    theForm.lgn.focus();
    return (false);
  }


  if (theForm.nme.value == "")
  {
    alert("Geben Sie einen Benutzernamen ein.");
    theForm.nme.focus();
    return (false);
  }
  checkOK = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÄÜÖäüöß- 0123456789" ;
  checkStr = theForm.nme.value;
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
    alert("Geben Sie nur Buchstaben, Ziffern, Leerräume und - in das Feld \"Benutzername\" ein.");
    theForm.nme.focus();
    return (false);
  }

  var checkOK = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
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
    alert("Geben Sie nur Buchstaben und Ziffern in das Feld \"Benutzerkennwort\" ein.");
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
    alert("Geben Sie nur Buchstaben und Ziffern in das Feld \"Benutzerkennwort bestätigen\" ein.");
    theForm.psb.focus();
    return (false);
  }
  var checkStr = theForm.adm.value;
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
    alert("Geben Sie nur Buchstaben und Ziffern in das Feld \"Administratorkennwort\" ein.");
    theForm.adm.focus();
    return (false);
  }

  return (true);
}
