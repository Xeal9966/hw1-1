//Load the page, check session variable and if success remove the loading div
window.addEventListener('load', function() {
    fetch('php/check_auth.php', {
            method: 'POST',
            credentials: 'same-origin'
        })
        .then(onResponse)
        .then(async(json) => {
            if (json !== 'logged') location.href = 'login.html';
            else {
                await sleep(300);
                document.querySelector('#loading').remove();
                generateInitial();
            }
        });
});

function generateInitial() {
    //top bar
    request_topbar().then((json) => {
        if (json.error === undefined) {
            const top_bar = document.querySelector('.top-bar');
            const mobile_bar = document.querySelector('.mobile-menu');
            top_bar.appendChild(getChild(TOP_BAR_BALANCE_TEMPLATE(json)));
            top_bar.appendChild(getChild(TOP_BAR_PROFILE_INFO_TEMPLATE(json)));
            mobile_bar.prepend(getChild(MOBILE_PROFILE_INFO_TEMPLATE(json)));
        }
    });
    //Generate overview
    const overview_cards_container = document.querySelector('#overview .cards-container');
    const activity_container = document.querySelector('.activity-container');
    //change pattern for cards
    requestCardInfo().then((json) => {
        for (let key of json) {
            switch (key.Type) {
                case 'Debit':
                    key.src = 'images/pattern3.png';
                    break;
                case 'Credit':
                    key.src = 'images/pattern2.png';
                    break;
                case 'Bancomat':
                    key.src = 'images/pattern1.png';
                    break;
            }
            const elem = overview_cards_container.appendChild(getChild(CC_TEMPLATE(key)));
            elem.addEventListener('click', setActiveCard);
            if (key.Favorite === '1') {
                elem.dataset.active = 'true';
                request_transactions().then((json) => {
                    for (let temp of json) {
                        const t = activity_container.appendChild(getChild(TRANSACTION_TEMPLATE(temp)));
                        t.addEventListener('click', showMoreDetails);
                        if (temp.Number === key.Number) {
                            t.dataset.active = true;
                        }
                    }
                });
            }
        }
    });
    //generate history
    request_history().then((json) => {
        const info_container = document.querySelector('#overview .info-container');
        for (let key of json) {
            info_container.appendChild(getChild(HISTORY_TEMPLATE(key)));
        }
    });
}

function generateSection(id) {
    switch (id) {
        case 'Cards':
            requestCardInfo().then((json) => {
                const info_container = document.querySelector('#cards .info-container');
                const cards_container = document.querySelector('#cards .cards-container');
                for (let key of json) {
                    switch (key.Type) {
                        case 'Debit':
                            key.src = 'images/pattern3.png';
                            break;
                        case 'Credit':
                            key.src = 'images/pattern2.png';
                            break;
                        case 'Bancomat':
                            key.src = 'images/pattern1.png';
                            break;
                    }
                    const elem = cards_container.appendChild(getChild(CC_TEMPLATE(key)));
                    elem.addEventListener('click', setActiveCard);
                    const info = info_container.appendChild(getChild(CARD_INFO_TEMPLATE(key)));
                    info.querySelector('.button').addEventListener('click', setAsFavorite);
                    if (key.Favorite === '1') {
                        //for the first gen
                        elem.dataset.active = 'true';
                        info.dataset.active = 'true';
                    }
                }
            });
            break;
        case 'Activity':
            //generate filters
            requestCardInfo().then((json) => {
                if (json.error === undefined) {
                    const filter_container = document.querySelector('#activity .filter-container');
                    for (let key of json) {
                        let t = filter_container.appendChild(getChild(CARDS_FILTER_TEMPLATE(key)));
                        t.addEventListener('click', setFilter);
                    }
                }
            });
            //generate list of all transactions
            request_transactions().then((json) => {
                if (json.error === undefined) {
                    const filter_cards = document.querySelector('#activity #filter-cards');
                    const filter_search = document.querySelector('#activity #filter-search');
                    for (let temp of json) {
                        //generate elements where to search and a div for cards search
                        const fc = filter_cards.appendChild(getChild(TRANSACTION_TEMPLATE(temp)));
                        fc.addEventListener('click', showMoreDetails);
                        fc.dataset.active = 'true';
                        const fs = filter_search.appendChild(getChild(TRANSACTION_TEMPLATE(temp)));
                        fs.addEventListener('click', showMoreDetails);
                    }
                }
            });
            //generate history values
            request_history().then((json) => {
                const info_container = document.querySelector('#activity .info-container');
                for (let key of json) {
                    info_container.appendChild(getChild(HISTORY_TEMPLATE(key)));
                }
            });
            break;
        case 'Services':
            //request loan information
            requestLoanInfo().then((json) => {
                if (json.error === undefined) {
                    const cards_container = document.querySelector('#services .cards-container');
                    const info_container = document.querySelector('#services .info-container');
                    const branch_container = document.querySelector('#services #branch.cards-container');
                    for (let key of json) {
                        const elem = cards_container.appendChild(getChild(LOANS_TEMPLATE(key)));
                        elem.addEventListener('click', setActiveCard);
                        const info = info_container.appendChild(getChild(LOANS_INFO_TEMPLATE(key)));
                        if (key.Favorite === '1') {
                            //for the first gen
                            elem.dataset.active = 'true';
                            info.dataset.active = 'true';
                        }
                    }
                }
            });
            //request safe deposit informations
            requestSafeDepositInfo().then((json) => {
                if (json.error === undefined) {
                    const branch_container = document.querySelector('#services #branch.cards-container');
                    for (let key of json) branch_container.appendChild(getChild(BRANCH_TEMPLATE(key)));
                }
            });
            break;
        case 'Market':
            //add loading cirle
            const loading = document.querySelector('#stock-market').appendChild(getChild(LOADING_TEMPLATE()));
            requestExchangeRates().then((json) => {
                const currency_container = document.querySelector('#market .scroll-container[data-set="currency"]');
                for (let key in json)
                    for (let t in json[key]) {
                        currency_container.appendChild(getChild(CURRENCY_BLOCK_TEMPLATE(key, t, json[key][t])));
                    }
            });
            requestStock().then((json) => {
                const stock_card_container = document.querySelector('#market .scroll-container[data-set="stock"]');
                const stock_info_container = document.querySelector('#market .stock-info-container');
                for (let key of json) {
                    let stock_info = {
                        trend: '',
                        name: key.companyName,
                        symbol: key.symbol,
                        price: key.latestPrice,
                        change: key.change,
                        changePercent: (key.changePercent * 100).toFixed(3),
                        favorite: 'false',
                        high: key.high,
                        low: key.low,
                        pe: key.peRatio,
                        week52High: key.week52High,
                        week52Low: key.week52Low,
                        volume: key.volume,
                        cap: ''
                    };
                    key.symbol === 'AAPL' ? (stock_info.favorite = 'true') : (stock_info.favorite = 'false');
                    key.change > 0 ? (stock_info.trend = 'up') : (stock_info.trend = 'down');
                    const t = stock_card_container.appendChild(getChild(STOCK_CARD_TEMPLATE(stock_info)));
                    t.addEventListener('click', changeStock);
                    //generate charts and info
                    stock_info_container.appendChild(getChild(STOCK_INFO_TEMPLATE(stock_info)));
                }
                //remove loading circle
                document.querySelector('#loading').remove();
            });
            break;
        case 'Account':
            //Personal Info
            request_account_data().then((json) => {
                if (json.Email !== undefined) {
                    const personal_info = document.querySelector('#account .personal-info-container');
                    const profile_children = getChildren(PROFILE_INFO_TEMPLATE(json));
                    for (let key of profile_children) personal_info.appendChild(key);
                }
            });
            break;
    }
}