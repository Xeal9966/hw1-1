function getChild(elem) {
    return new DOMParser().parseFromString(elem, 'text/html').body.firstChild;
}

function getChildren(elem) {
    return new DOMParser().parseFromString(elem, 'text/html').body.querySelectorAll('div');
}

function onResponse(response) {
    return response.json();
}

function onJson(json) {
    console.log(json);
}

function sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
}

function hideDiv(e) {
    e.dataset.visible = 'hidden';
}

function showDiv(e) {
    e.dataset.visible = 'visible';
}

function emptyDiv(e) {
    while (e.firstChild) e.removeChild(e.firstChild);
}