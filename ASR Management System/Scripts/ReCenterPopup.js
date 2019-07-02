var $$ = function (id) {
    return document.getElementById(id);
};

var popup = $$('<%=popupMenu_View_All_Submissions.ClientID %>');

var ReCenter = function () {
    popup.style.backgroundColor = "green";
    return false;
};