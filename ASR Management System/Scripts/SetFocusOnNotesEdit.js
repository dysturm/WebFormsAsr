

var $get = function (id) { return document.getElementById(id); };
var $getByClass = function (className) { return document.getElementsByClassName(className); };


var classArray = $getByClass("consulant_notes_txtbox");


var EditBtn = $get('<%=Button_Edit_Consultant_Notes.ClientID %>');
var notes = classArray[0];
var prm = Sys.WebForms.PageRequestManager.getInstance();


function setPosition() {
    alert("Pos func called");
};

function EndRequestHandler(sender, args) {
    alert("end request called");
    if (notes != null) {
        //alert("id of notes is: " + notes.id)
        notes.focus();
        notes.setAttribute("background-color", "red");
        alert("focus set");
    }
    else
        alert("notes are really null");
}

var setFocus = function () {
    //alert("hello ot you");
    notes.setFocus();   
};


prm.add_endRequest(EndRequestHandler);
