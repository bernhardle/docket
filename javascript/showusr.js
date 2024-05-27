function validator(theForm)
{
  if (theForm.uid.value == "0")
  {
    alert("Wählen Sie eine Benutzerkennung zum Anzeigen oder Bearbeiten aus.");
    theForm.login.focus();
    return (false);
  }
  return (true);
}