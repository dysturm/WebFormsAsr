// It is important to place this JavaScript code after ScriptManager1
//alert("hello from js");

var $get = function (id) { return document.getElementById(id); };
var div = $get('ContentPlaceHolder1_Active_Submissions_Panel');
var xPos, yPos;
var prm = Sys.WebForms.PageRequestManager.getInstance();



function BeginRequestHandler(sender, args) {
    //alert("BeginRequest Called");
    if ($get('ContentPlaceHolder1_Active_Submissions_Panel') != null) {

        // Get X and Y positions of scrollbar before the partial postback
        xPos = $get('ContentPlaceHolder1_Active_Submissions_Panel').scrollLeft;
        yPos = $get('ContentPlaceHolder1_Active_Submissions_Panel').scrollTop;
        //alert("storing position: y = " + yPos);
    }
    else {
        alert("position div null");
    }
};

function EndRequestHandler(sender, args) {
    //alert("end request called");
    if ($get('ContentPlaceHolder1_Active_Submissions_Panel') != null) {
        //alert("setting position: y = " + yPos);
        // Set X and Y positions back to the scrollbar
        // after partial postback
        $get('ContentPlaceHolder1_Active_Submissions_Panel').scrollLeft = xPos;
        $get('ContentPlaceHolder1_Active_Submissions_Panel').scrollTop = yPos;
    }
    else {
        alert("position div null");
    }

    //var btn = $get("ContentPlaceHolder1_ComboBox_Client_ComboBox_Client_Button");
    //if (btn != null) {
    //    btn.style.height = '20px';
    //    btn.style.width = '20px';
    //}
    //else {
    //    alert("btn is null");
    //}

    var btnContainers = document.getElementsByClassName("ajax__combobox_buttoncontainer");
    if (btnContainers != null) {
        for (var i = 0; i < btnContainers.length; i++) {
            btnContainers[i].children[0].className += "btnStyle";
        }
    } else {
        alert("btnContainers is null");
    }

    
};

prm.add_beginRequest(BeginRequestHandler);
prm.add_endRequest(EndRequestHandler);