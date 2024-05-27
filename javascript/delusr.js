function validator(theForm)
{

  return (true) ;
  
  if (theForm.lgn.value == "0")
  {
    alert("Wählen Sie eine Benutzerkennung zum Löschen aus.");
    theForm.lgn.focus();
    return (false);
  }
  return (true);
}