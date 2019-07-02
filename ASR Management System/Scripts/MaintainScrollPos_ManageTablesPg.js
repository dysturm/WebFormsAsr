
//will get panel based on class name (since several panels in multiview)

var $get = function (id) { return document.getElementsByClassName(id)[0]; };
var div = $get('active_submission_scroll_container');
var xPos, yPos;
var prm = Sys.WebForms.PageRequestManager.getInstance();



function BeginRequestHandler(sender, args) {
    //alert("BeginRequest Called");
    if ($get('panel_gv') != null) {

        // Get X and Y positions of scrollbar before the partial postback
        xPos = $get('panel_gv').scrollLeft;
        yPos = $get('panel_gv').scrollTop;
        //alert("storing position: y = " + yPos);
    }
    else {
        alert("position div null");
    }
}

function EndRequestHandler(sender, args) {
    //alert("end request called");
    if ($get('panel_gv') != null) {
        //alert("setting position: y = " + yPos);
        // Set X and Y positions back to the scrollbar
        // after partial postback
        $get('panel_gv').scrollLeft = xPos;
        $get('panel_gv').scrollTop = yPos;
    }
    else {
        alert("position div null");
    }
}

prm.add_beginRequest(BeginRequestHandler);
prm.add_endRequest(EndRequestHandler);