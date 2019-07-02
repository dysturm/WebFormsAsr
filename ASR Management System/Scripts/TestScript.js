window.onload = function () {
    //$("TestHiddenField").value = 8;
    

  //  alert($('<%= HiddenField1.ClientID %>').text);
   // alert($('<%= HiddenField1.ClientID %>').value);
  //  alert($('<%= HiddenField1.ClientID %>').nodeValue);
    //var div = document.getElementById("divTest");
    //var div_position = document.getElementById("TestHiddenField");
    //var position = parseInt('<%=Request.Form["div_position"] %>');
    //if (isNaN(position)) {
    //    position = 0;
    //}
    //div.scrollTop = position;
    //div.onscroll = function () {
    //    div_position.value = div.scrollTop;
    //};
    $("divTest").onscroll = trackPos;
    $("divTest").scrollTop = $("HiddenField1").value;
}
document.write("hello");

var $ = function (id) { return document.getElementById(id); };

var trackPos = function () {
    $("HiddenField1").value = $("divTest").scrollTop;
}

