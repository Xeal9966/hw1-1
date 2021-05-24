//Returns TopBar info for logged user
function request_topbar() {
    return fetch('php/request_topbar.php', {
            method: 'POST',
            credentials: 'same-origin'
        })
        .then(onResponse)
        .then((json) => {
            return json;
        });
}

//Returns Cards info for logged user
function requestCardInfo() {
    return fetch('php/requestCard.php', {
            method: 'POST',
            credentials: 'same-origin'
        })
        .then(onResponse)
        .then((json) => {
            return json;
        });
}

//request info about loans for logged user
function requestLoanInfo() {
    return fetch('php/request_loan_info.php', {
            method: 'POST',
            credentials: 'same-origin'
        })
        .then(onResponse)
        .then((json) => {
            return json;
        });
}

//request info about safe deposit boxes for logged user
function requestSafeDepositInfo() {
    return fetch('php/request_safe_deposit.php', {
            method: 'POST',
            credentials: 'same-origin'
        })
        .then(onResponse)
        .then((json) => {
            return json;
        });
}

//Returns History for logged user
function request_history() {
    return fetch('php/requestHistory.php', {
            method: 'POST',
            credentials: 'same-origin'
        })
        .then(onResponse)
        .then((json) => {
            return json;
        });
}

//Returns Transactions made by logged user account
function request_transactions() {
    return fetch('php/requestTransactions.php', {
            method: 'POST',
            credentials: 'same-origin'
        })
        .then(onResponse)
        .then((json) => {
            return json;
        });
}

//Request for bancomat balance
function request_bancomat_balance() {
    return fetch('php/request_bancomat_balance.php', {
            method: 'POST',
            credentials: 'same-origin'
        })
        .then(onResponse)
        .then((json) => {
            return json;
        });
}

//Returns logged user profile info
function request_account_data() {
    return fetch('php/request_account_data.php', {
            method: 'POST',
            credentials: 'same-origin'
        })
        .then(onResponse)
        .then((json) => {
            return json;
        });
}

//EXTERNAL API REQUESTS

//call php script to request data from coinbase.com (Exchange Rates)
function requestExchangeRates() {
    return fetch('php/request_exchange_rates.php', {
            method: 'POST',
            credentials: 'same-origin'
        })
        .then(onResponse)
        .then((json) => {
            return json;
        });
}

//call php script to request data from coinbase.com (Exchange Rates)
function requestStock() {
    return fetch('php/request_stock.php', {
            method: 'POST',
            credentials: 'same-origin'
        })
        .then(onResponse)
        .then((json) => {
            return json;
        });
}