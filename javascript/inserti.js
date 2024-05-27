function validator(theForm)
{

  return (true) ;

  if (theForm.dd1.value.length < 1)
  {
    alert("Geben Sie eine Zahl in das Feld [Tag] ein.");
    theForm.dd1.focus();
    return (false);
  }
  if (theForm.mm1.value == 0)
  {
    alert("Wählen Sie einen Monat aus.");
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
    alert("Geben Sie nur eine Zahl in das Feld [Tag] ein.");
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
    alert("Geben Sie eine Zahl zwischen 1 und " + monlen + " in das Feld [Tag] ein.");
    theForm.dd1.focus();
    return (false);
  }

  if (theForm.yyyy1.value.length != 4)
  {
    alert("Geben Sie eine Zahl mit 4 Stellen in das Feld [Jahr] ein.");
    theForm.yyyy1.focus();
    return (false);
  }

  var checkOK = "0123456789";
  var checkStr = theForm.yyyy1.value;
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
    alert("Geben Sie nur Ziffern in das Feld [Jahr] ein.");
    theForm.yyyy1.focus();
    return (false);
  }

  var chkVal = allNum;
  var prsVal = parseInt(allNum);
  if (chkVal != "" && !(prsVal >= 2000 && prsVal <= 2020))
  {
    alert("Geben Sie eine Zahl zwischen 2000 und 2020 in das Feld [Jahr] ein.");
    theForm.yyyy1.focus();
    return (false);
  }

  if (parseInt (theForm.yyyyn.value) > parseInt (theForm.yyyy1.value) 
	|| (parseInt (theForm.yyyyn.value) == parseInt (theForm.yyyy1.value) && parseInt (theForm.mmn.value) > parseInt (theForm.mm1.value))
	|| (parseInt (theForm.yyyyn.value) == parseInt (theForm.yyyy1.value) && parseInt (theForm.mmn.value) == parseInt (theForm.mm1.value) && parseInt (theForm.ddn.value) >= parseInt (theForm.dd1.value)))
  {
    alert("Die neue Frist muss in der Zukunft liegen.");
    theForm.yyyy1.focus() ;
    return (false);
  }

  if (theForm.fil.value == "")
  {
    alert("Geben Sie ein Aktenzeichen oder \'0\' ein");
    theForm.fil.focus();
    return (false);
  }

  var checkPr = "RWE" ;
  var checkOK = "0123456789";
  var checkStr = theForm.fil.value;
  var allValid = true;
  var prefix = false ;

  for (i = 0; i < checkPr.length ; i++) {
    if (checkStr.charAt(0) == checkPr.charAt(i)) { prefix = true ; break ; }
  }

  for (i = prefix ? 1 : 0;  i < checkStr.length;  i++)
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
  if (!allValid || theForm.fil.value.length > 6)
  {
    alert("Geben Sie ein gültiges Aktenzeichen oder \'0\' ein.");
    theForm.fil.focus();
    return (false);
  }

  if (theForm.typ.value == "0")
  {
    alert("Wählen Sie eine Wichtigkeit aus.");
    theForm.typ.focus();
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