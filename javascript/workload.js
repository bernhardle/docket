function validator(theForm)
{
  return (true) ;

  if (theForm.dd1.value.length < 1)
  {
    alert("Geben Sie eine Zahl in das Feld \"Von [Tag]\" ein.");
    theForm.dd1.focus();
    return (false);
  }
  if (theForm.mm1.value == 0)
  {
    alert("Wählen Sie einen Monat für das Datum in der Zeile \"Von\" aus.");
    theForm.mm1.focus();
    return (false);
  }


  var checkOK = "0123456789";
  var checkStr = theForm.dd1.value;
  var allValid = true;
  var decPoints = 0;
  var allNum = "";
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
    allNum += ch;
  }
  if (!allValid)
  {
    alert("Geben Sie nur eine Zahl in das Feld \"Von [Tag]\" ein.");
    theForm.dd1.focus();
    return (false);
  }
  var monlen = 0 ;
  switch (theForm.mm1.value) {
    case "1" :
        monlen = 31 ;
      break ;
    case "2" :
        monlen = 29 ;
      break ;
    case "3" :
        monlen = 31 ;
      break ;
    case "4" :
        monlen = 30 ;
      break ;
    case "5" :
        monlen = 31 ;
      break ;
    case "6" :
        monlen = 30 ;
      break ;
    case "7" :
        monlen = 31 ;
      break ;
    case "8" :
        monlen = 31 ;
      break ;
    case "9" :
        monlen = 30 ;
      break ;
    case "10" :
        monlen = 31 ;
      break ;
    case "11" :
        monlen = 30 ;
      break ;
    case "12" :
        monlen = 31 ;
      break ;
    default :
      break ;
  }
  var chkVal = allNum;
  var prsVal = parseInt(allNum);
  if (chkVal != "" && !(prsVal >= 0 && prsVal <= monlen))
  {
    alert("Geben Sie eine Zahl zwischen 1 und " + monlen + " in das Feld \"Von [Tag]\" ein.");
    theForm.dd1.focus();
    return (false);
  }

  if (theForm.yyyy1.value.length != 4)
  {
    alert("Geben Sie eine Zahl mit 4 Stellen in das Feld \"Von [Jahr]\" ein.");
    theForm.yyyy1.focus();
    return (false);
  }

  var checkOK = "0123456789";
  var checkStr = theForm.yyyy1.value;
  var allValid = true;
  var decPoints = 0;
  var allNum = "";
  for (i = 0; i < checkStr.length;  i++)
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
    allNum += ch;
  }
  if (!allValid)
  {
    alert("Geben Sie nur Ziffern in das Feld \"Von [Jahr]\" ein.");
    theForm.yyyy1.focus();
    return (false);
  }

  var chkVal = allNum;
  var prsVal = parseInt(allNum);
  if (chkVal != "" && !(prsVal >= 2000 && prsVal <= 2020))
  {
    alert("Geben Sie eine Zahl zwischen 2000 und 2020 in das Feld \"Von [Jahr]\" ein.");
    theForm.yyyy1.focus();
    return (false);
  }

  if (theForm.dd2.value.length < 1)
  {
    alert("Geben Sie eine Zahl in das Feld \"Bis [Tag]\" ein.");
    theForm.dd2.focus();
    return (false);
  }

  var checkOK = "0123456789";
  var checkStr = theForm.dd2.value;
  var allValid = true;
  var decPoints = 0;
  var allNum = "";
  for (i = 0; i < checkStr.length;  i++)
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
    allNum += ch;
  }
  if (!allValid)
  {
    alert("Geben Sie nur eine Zahl in das Feld \"Bis [Tag]\" ein.");
    theForm.dd2.focus();
    return (false);
  }
  var monlen = 0 ;
  switch (theForm.mm2.value) {
    case "1" :
        monlen = 31 ;
      break ;
    case "2" :
        monlen = 29 ;
      break ;
    case "3" :
        monlen = 31 ;
      break ;
    case "4" :
        monlen = 30 ;
      break ;
    case "5" :
        monlen = 31 ;
      break ;
    case "6" :
        monlen = 30 ;
      break ;
    case "7" :
        monlen = 31 ;
      break ;
    case "8" :
        monlen = 31 ;
      break ;
    case "9" :
        monlen = 30 ;
      break ;
    case "10" :
        monlen = 31 ;
      break ;
    case "11" :
        monlen = 30 ;
      break ;
    case "12" :
        monlen = 31 ;
      break ;
    default :
      break ;
  }
  var chkVal = allNum;
  var prsVal = parseInt(allNum);
  if (chkVal != "" && !(prsVal > 0 && prsVal <= monlen))
  {
    alert("Geben Sie eine Zahl zwischen 1 und " + monlen + " in das Feld \"Bis [Tag]\" ein.");
    theForm.dd2.focus();
    return (false);
  }

  if (theForm.yyyy2.value.length != 4)
  {
    alert("Geben Sie eine Zahl mit 4 Stellen in das Feld \"Bis [Jahr]\" ein.");
    theForm.yyyy2.focus();
    return (false);
  }

  var checkOK = "0123456789";
  var checkStr = theForm.yyyy2.value;
  var allValid = true;
  var decPoints = 0;
  var allNum = "";
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
    allNum += ch;
  }
  if (!allValid)
  {
    alert("Geben Sie nur Ziffern in das Feld \"Bis [Jahr]\" ein.");
    theForm.yyyy2.focus();
    return (false);
  }

  var chkVal = allNum;
  var prsVal = parseInt(allNum);
  if (chkVal != "" && !(prsVal >= 2000 && prsVal <= 2020))
  {
    alert("Geben Sie eine Zahl zwischen 2000 und 2020 in das Feld \"Bis [Jahr]\" ein.");
    theForm.yyyy2.focus();
    return (false);
  }
  if (parseInt (theForm.yyyy1.value) > parseInt (theForm.yyyy2.value) 
	|| (parseInt (theForm.yyyy1.value) == parseInt (theForm.yyyy2.value) && parseInt (theForm.mm1.value) > parseInt (theForm.mm2.value))
	|| (parseInt (theForm.yyyy1.value) == parseInt (theForm.yyyy2.value) && parseInt (theForm.mm1.value) == parseInt (theForm.mm2.value) && parseInt (theForm.dd1.value) >= parseInt (theForm.dd2.value)))
  {
    alert("Das Datum im Feld \"Von\" muss vor dem Datum im Feld \"Bis\" liegen");
    theForm.yyyy1.focus() ;
    return (false);
  }
  if (theForm.asd.value == "0")
  {
    alert("Wählen Sie einen Bearbeiter aus.");
    theForm.asd.focus();
    return (false);
  }
  return (true);
}