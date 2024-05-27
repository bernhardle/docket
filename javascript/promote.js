function validator(theForm)
{

  if (theForm.monitor.value == "ON") {

  if (theForm.dd.value.length < 1)
  {
    alert("Geben Sie eine Zahl in das Feld \"Fristende [Tag]\" ein.");
    theForm.dd.focus();
    return (false);
  }
  if (theForm.mm.value == 0)
  {
    alert("Wählen Sie einen Monat für das Fristende aus.");
    theForm.mm.focus();
    return (false);
  }


  var checkOK = "0123456789";
  var checkStr = theForm.dd.value;
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
    alert("Geben Sie nur eine Zahl in das Feld \"Fristende [Tag]\" ein.");
    theForm.dd.focus();
    return (false);
  }
  var monlen = 0 ;
  switch (theForm.mm.value) {
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
    alert("Geben Sie eine Zahl zwischen 1 und " + monlen + " in das Feld \"Fristende [Tag]\" ein.");
    theForm.dd.focus();
    return (false);
  }

  if (theForm.yyyy.value.length != 4)
  {
    alert("Geben Sie eine Zahl mit 4 Stellen in das Feld \"Fristende [Jahr]\" ein.");
    theForm.yyyy.focus();
    return (false);
  }

  var checkOK = "0123456789";
  var checkStr = theForm.yyyy.value;
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
    alert("Geben Sie nur Ziffern in das Feld \"Fristende [Jahr]\" ein.");
    theForm.yyyy.focus();
    return (false);
  }

  var chkVal = allNum;
  var prsVal = parseInt(allNum);
  if (chkVal != "" && !(prsVal >= 2000 && prsVal <= 2020))
  {
    alert("Geben Sie eine Zahl zwischen 2000 und 2020 in das Feld \"Fristende [Jahr]\" ein.");
    theForm.yyyy.focus();
    return (false);
  }

  if (parseInt (theForm.yyyyn.value) > parseInt (theForm.yyyy.value) 
	|| (parseInt (theForm.yyyyn.value) == parseInt (theForm.yyyy.value) && parseInt (theForm.mmn.value) > parseInt (theForm.mm.value))
	|| (parseInt (theForm.yyyyn.value) == parseInt (theForm.yyyy.value) && parseInt (theForm.mmn.value) == parseInt (theForm.mm.value) && parseInt (theForm.ddn.value) >= parseInt (theForm.dd.value)))
  {
    alert("Die neue Frist muss in der Zukunft liegen.");
    theForm.yyyy.focus() ;
    return (false);
  }

  }
  return (true);
}