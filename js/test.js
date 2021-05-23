function onResponse(response) {
    return response.json();
}

function onJson(json) {
    console.log(json);
}

function test() {
    fetch('php/log.php', {
            method: 'POST',
            credentials: 'include'
        })
        .then(onResponse)
        .then(onJson);
}

function logout() {
    fetch('php/logout.php', {
            method: 'POST',
            credentials: 'include'
        })
        .then(onResponse)
        .then(onJson);
}