function validator(theForm)
{

  return (true) ;
  
  if (theForm.lgn.value == "0")
  {
    alert("W�hlen Sie eine Benutzerkennung zum L�schen aus.");
    theForm.lgn.focus();
    return (false);
  }
  return (true);
}