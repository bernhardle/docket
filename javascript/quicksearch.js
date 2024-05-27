function validator(theForm) {
  return true ;

  if (theForm.token.value == "")
  {
    alert("Geben Sie einen Suchbegriff ein.");
    theForm.token.focus();
    return (false);
  }

  var checkOK = "AÄBCDEFGHIJKLMNOÖPQRSTUÜVWXYZaäbcdefghijklmnoöpqrsßtuüvwxyz0123456789&@+-./ ";
  var checkStr = theForm.token.value;
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
    alert("Geben Sie nur Buchstaben und Ziffern als Suchbegriff ein.");
    theForm.token.focus();
    return (false);
  }
  return (true);
}