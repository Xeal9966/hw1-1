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

function print_error(key, msg) {
    key.addEventListener('input', removeError);
    key.closest('.form-box').classList.add('error');
    if (key.closest('.form-element').querySelector('.form-error') === null)
        key.closest('.form-element').appendChild(getChild(ERROR_TEMPLATE(msg)));
}

function check_fill(inputs) {
    let err = false;
    for (let key of inputs)
        if (key.value.length === 0) {
            print_error(key, 'Please fill this field!');
            err = true;
        }
    return err;
}

function removeError(e) {
    const elem = e.currentTarget;
    elem.closest('.form-box').classList.remove('error');
    elem.removeEventListener('input', removeError);
    elem.closest('.form-element').querySelector('.form-error').remove();
}