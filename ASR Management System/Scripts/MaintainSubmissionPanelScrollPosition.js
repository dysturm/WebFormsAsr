// It is important to place this JavaScript code after ScriptManager1
var $get = function (id) { return document.getElementById(id); };
var div = $get('active_submission_scroll_container');
var xPos, yPos;
var prm = Sys.WebForms.PageRequestManager.getInstance();



function BeginRequestHandler(sender, args) {
    //alert("BeginRequest Called");
    if ($get('active_submission_scroll_container') != null) {
        
        // Get X and Y positions of scrollbar before the partial postback
        xPos = $get('active_submission_scroll_container').scrollLeft;
        yPos = $get('active_submission_scroll_container').scrollTop;
        //alert("storing position: y = " + yPos);
    }
    else {
        alert("position div null");
    }
}

function EndRequestHandler(sender, args) {
    //alert("end request called");
    if ($get('active_submission_scroll_container') != null) {
        //alert("setting position: y = " + yPos);
        // Set X and Y positions back to the scrollbar
        // after partial postback
        $get('active_submission_scroll_container').scrollLeft = xPos;
        $get('active_submission_scroll_container').scrollTop = yPos;
    }
    else {
        alert("position div null");
    }
}

prm.add_beginRequest(BeginRequestHandler);
prm.add_endRequest(EndRequestHandler);