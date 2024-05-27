function validator(theForm)
{
  if (theForm.text.value == "")
  {
    alert("Geben Sie einen Kommentar ein");
    theForm.text.focus();
    return (false);
  }
  return (true);
}