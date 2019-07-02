var $ = function (id) { return document.getElementById(id); };

var resizeHeight = $("GridViewResizeHeight");
var resizeWidth = $("GridViewResizeWidth");
var ScrollPositionField = $("ScrollPosition");
var GridViewDivContainer = $("GridViewContainer");

window.onload = function () {
    GridViewDivContainer.onscroll = trackPos;
    GridViewDivContainer.scrollTop = ScrollPositionField.value;

    GridViewDivContainer.onclick = trackSize;
    if (resizeHeight.value != 0) {
        GridViewDivContainer.style.height = resizeHeight.value + "px";
        GridViewDivContainer.style.width = resizeWidth.value + "px";
    }
};


var trackPos = function () {
    ScrollPositionField.value = GridViewDivContainer.scrollTop;
};

var trackSize = function () {
    resizeHeight.value = GridViewDivContainer.offsetHeight;
    resizeWidth.value = GridViewDivContainer.offsetWidth;
};