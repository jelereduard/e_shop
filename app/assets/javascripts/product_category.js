
function getCat(){ 
    return getUrlParameter("cat");
}
function getUrlParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
}
function setCat(name){
    var urlParams = new URLSearchParams(window.location.search);
    var vechi="cat="+getUrlParameter("cat");
    var nou="cat="+name;
    var url=window.location.href.replace(vechi,nou);
    window.location=url;
    return false;
}
