/*
function generateTopBar() {
    const name = profile[0].name;
    const surname = profile[0].surname;
    const imgUrl = profile[0].img;
    const nameContainer = document.querySelectorAll('#profile-name');
    const imageContainer = document.querySelectorAll('#profile-image');

    for (let key of nameContainer) key.textContent = name + ' ' + surname;
    for (let key of imageContainer) key.src = imgUrl;
}

function generatePage() {
    generateTopBar();
    generateOverview();
    generateCardsSection();
    generateActivitySection();
    generateServicesSection();
    generateAccountSection();
    generateMarketSection();
}

function generateOverview() {
    const overview_cards_container = document.querySelector('#overview .cards-container');
    const cards_container = document.querySelector('#cards .cards-container');
    const activity_container = document.querySelector('.activity-container');
    const info_container = document.querySelector('.info-container');

    for (let key of cards) {
        const elem = overview_cards_container.appendChild(getChild(CC_TEMPLATE(key)));
        elem.addEventListener('click', setActiveCard);
        const elem2 = cards_container.appendChild(getChild(CC_TEMPLATE(key)));
        elem2.addEventListener('click', setActiveCard);
        if (key.favorite) {
            elem.dataset.active = 'true';
            elem2.dataset.active = 'true';
            // only transaction by favorite card are generated
            for (let temp of transactions) {
                if (temp.card === key.number) {
                    const t = activity_container.appendChild(getChild(TRANSACTION_TEMPLATE(temp)));
                    t.addEventListener('click', showMoreDetails);
                }
            }
        }
    }
    for (let key of history) {
        const elem = info_container.appendChild(getChild(HISTORY_TEMPLATE(key)));
    }
}

function generateCardsSection() {
    const info_container = document.querySelector('#cards .info-container');
    // don't forget to generate cards
    for (let key of cards) {
        if (key.favorite) {
            //for the first gen
            const children = getChildren(CARD_INFO_TEMPLATE(key));
            for (let i of children) {
                const child = info_container.appendChild(i);
            }
        }
    }
}

function generateActivitySection() {
    const info_container = document.querySelector('#activity .info-container');
    const filter_container = document.querySelector('#activity .filter-container');
    const transaction_container = document.querySelector('#activity .activity-container');

    for (let key of cards) {
        let elem = filter_container.appendChild(getChild(CARDS_FILTER_TEMPLATE(key)));
        elem.addEventListener('click', setFilter);
    }
    for (let key of transactions) {
        let elem = transaction_container.appendChild(getChild(TRANSACTION_TEMPLATE(key)));
        elem.addEventListener('click', showMoreDetails);
    }
    for (let key of history) {
        let info_row = document.createElement('div');
        info_row.classList.add('info-row');
        const div = document.createElement('div');
        const img = document.createElement('img');
        img.src = 'images/icons/star_outline.svg';
        img.dataset.img = 'unselected';
        let span1 = document.createElement('span');
        span1.textContent = key.month + '/' + key.year;
        div.appendChild(img);
        div.appendChild(span1);
        info_row.appendChild(div);
        let span2 = document.createElement('span');
        span2.textContent = key.balance;
        info_row.dataset.data = key.month + '/' + key.year;
        info_row.dataset.balance = key.balance;
        info_row.appendChild(span2);
        info_container.appendChild(info_row);
    }
}

function generateServicesSection() {
    const cards_container = document.querySelector('#services .cards-container');
    const info_container = document.querySelector('#services .info-container');
    const branch_container = document.querySelector('#services #branch.cards-container');

    for (let key of loans) {
        if (key.favorite) {
            //for the first gen
            const children = getChildren(LOANS_INFO_TEMPLATE(key));
            for (let i of children) {
                const child = info_container.appendChild(i);
            }
            elem = cards_container.appendChild(getChild(LOANS_TEMPLATE(key)));
            elem.dataset.active = 'true';
        } else elem = cards_container.appendChild(getChild(LOANS_TEMPLATE(key)));
    }
    for (let key of safeBoxes) {
        elem = branch_container.appendChild(getChild(BRANCH_TEMPLATE(key)));
    }
}


function openCloseMenu(e) {
    const elem = e.currentTarget;
    const mobile_menu = document.querySelector('.mobile-menu');
    if (elem.dataset.img === 'open') {
        elem.dataset.img = 'close';
        elem.src = 'images/icons/clear.svg';
        mobile_menu.dataset.active = 'true';
        document.querySelector('header').dataset.overflow = 'hidden';
    } else {
        mobile_menu.dataset.active = 'false';
        elem.dataset.img = 'open';
        elem.src = 'images/icons/burger.svg';
        document.querySelector('header').dataset.overflow = '';
    }
}


const showAllTexts = document.querySelectorAll('.title h3');
const cc = document.querySelectorAll('#Overview .cards-container .cc');
const menu_items = document.querySelectorAll('.menu-item');
const loan_cc = document.querySelectorAll('#Services .cards-container .cc');
const removeFilter = document.querySelector('#activity #remove');
const searchInput = document.querySelector('.search-container input');
const searchClear = document.querySelector('.search-container #clear');
const mobile_menu_items = document.querySelectorAll('.mobile-menu .mobile-menu-item');
const burger_button = document.querySelector('#mobile-menu-burger');
const favorite_img = document.querySelectorAll('#activity .info-row div img');
let filter_list = [];

removeFilter.addEventListener('click', removeAllFilters);
searchInput.addEventListener('keyup', search);
searchClear.addEventListener('click', clearSearch);
burger_button.addEventListener('click', openCloseMenu);

for (let key of loan_cc) key.addEventListener('click', setActiveCard);
for (let key of showAllTexts) key.addEventListener('click', changeSection);
for (let key of menu_items) key.addEventListener('click', changeSection);
for (let key of mobile_menu_items) key.addEventListener('click', changeSection);
for (let key of favorite_img) key.addEventListener('click', addToFavorite);

document.querySelector('#contact h3').removeEventListener('click', changeSection);

//log-out event listener
for (let key of document.querySelectorAll('#logout'))
    key.addEventListener('click', function() {
        fetch('php/logout.php').then(onResponse).then((json) => {
            if (json === 'success') location.href = 'login.html';
        });
    });
*/

function generateMarketSection() {
    const currency_container = document.querySelector('#market .scroll-container[data-set = "currency"]');
    const stock_card_container = document.querySelector('#market .scroll-container[data-set = "stock"]');

    for (let key of currency_list)
        fetch('https://api.coinbase.com/v2/exchange-rates?currency=' + key.base).then(onResponse).then(function(json) {
            for (let temp of key.currencies) {
                currency_container.appendChild(
                    getChild(CURRENCY_BLOCK_TEMPLATE(key.base, temp, json.data.rates[temp].slice(0, 6)))
                );
                //generate chart
            }
        });

    for (let key of stockSymbols)
        fetch(
            'https://cloud.iexapis.com/stable/stock/' + key.symbol + '/quote?token=pk_9bceca2c95c04eee8febdc0b538c89a6'
        )
        .then(onResponse)
        .then(function(json) {
            let block = {
                trend: '',
                name: json.companyName,
                symbol: json.symbol,
                price: json.latestPrice,
                change: json.change,
                changePercent: json.changePercent * 100,
                favorite: 'false',
                high: json.high,
                low: json.low,
                pe: json.peRatio,
                week52High: json.week52High,
                week52Low: json.week52Low,
                volume: json.volume,
                cap: ''
            };
            json.change > 0 ? (block.trend = 'up') : (block.trend = 'down');

            if (key.favorite === true) {
                //if element is favorite we generate the chart
                block.favorite = 'true';
                const stock_details = document.querySelector('#market .stock-info-container');
                stock_details.appendChild(getChild(STOCK_INFO_TEMPLATE(block)));
            }
            const elem = stock_card_container.appendChild(getChild(STOCK_CARD_TEMPLATE(block)));
            elem.addEventListener('click', changeStock);
        });
}

/*
function generateAccountSection() {
    const personal_info = document.querySelector('#account .personal-info-container');
    for (let key of profile) {
        const children = getChildren(PROFILE_INFO_TEMPLATE(key));
        for (let i of children) {
            const child = personal_info.appendChild(i);
        }
    }
}
*/
// EVENT LISTENERS

//open and close transaction details
function showMoreDetails(e) {
    const curr_row = e.currentTarget;
    const expand_img = curr_row.querySelector('#expand');
    const details = curr_row.querySelector('.transaction-details');
    const toHide = curr_row.querySelectorAll('.value>span');
    if (curr_row.dataset.close === 'true') {
        //details are closed so we open them
        curr_row.dataset.close = 'false';
        expand_img.src = 'images/icons/expand_less.svg';
        details.classList.add('opened');
        for (let temp of toHide) temp.classList.add('open');
    } else {
        //details are opened so we close them
        curr_row.dataset.close = 'true';
        expand_img.src = 'images/icons/expand_more.svg';
        details.classList.remove('opened');
        for (let temp of toHide) temp.classList.remove('open');
    }
}

//set the active card and filter transactions by that card
function setActiveCard(e) {
    const cc = e.currentTarget;
    if (cc.dataset.active === 'false') {
        let section_id = cc.closest('section').id;
        document.querySelector('#' + section_id + ' .cards-container .cc[data-active="true"]').dataset.active = 'false';
        cc.dataset.active = 'true';
        if (section_id === 'overview') updateTransactionList(cc);
        else updateInfo(cc);
    }
}

//change section
function changeSection(e) {
    const elem = e.currentTarget;
    const menu = document.querySelector('.menu');
    const burger_button = document.querySelector('#mobile-menu-burger');
    const mobile_menu = document.querySelector('.mobile-menu');

    if (elem.dataset.active === 'false' || elem.tagName === 'H3') {
        let previousActive = menu.querySelector('.menu-items-container .menu-item[data-active="true"]');
        document.querySelector('#' + previousActive.dataset.link).dataset.opened = 'false';
        previousActive.dataset.active = 'false';
        let menuActive = (menu.querySelector('.menu-item[data-link =' + elem.dataset.link + ']').dataset.active =
            'true');
        document.querySelector('#' + elem.dataset.link).dataset.opened = 'true';
        previousActive = mobile_menu.querySelector('[data-active = "true"]');
        previousActive.dataset.active = 'false';
        menuActive = mobile_menu.querySelector('[data-link = ' + elem.dataset.link + ']');
        menuActive.dataset.active = 'true';
        if (elem.classList.contains('mobile-menu-item')) {
            burger_button.src = 'images/icons/burger.svg';
            burger_button.dataset.img = 'open';
            mobile_menu.dataset.active = 'false';
            document.querySelector('body').dataset.overflow = '';
        }
    }
}

//clean the transactions container and update with new selected card number as filter
function updateTransactionList(e) {
    const activity_container = document.querySelector('#Overview .activity-container');
    //clean the container
    while (activity_container.firstChild) activity_container.removeChild(activity_container.firstChild);
    for (let key of transactions)
        if (key.card === e.dataset.number) {
            const elem = activity_container.appendChild(getChild(TRANSACTION_TEMPLATE(key)));
            elem.addEventListener('click', showMoreDetails);
        }
}

//update info of cards (cc and loans)
function updateInfo(e) {
    const section_id = e.closest('section').id;
    const info_container = document.querySelector('#' + section_id + ' .info-container');
    //cleaning the container
    emptyDiv(info_container);
    if (section_id === 'cards') {
        for (let key of cards)
            if (e.dataset.number === key.number) {
                const children = getChildren(CARD_INFO_TEMPLATE(key));
                for (let i of children) {
                    const child = info_container.appendChild(i);
                }
            }
    } else {
        for (let key of loans)
            if (key.number === e.dataset.number) {
                const children = getChildren(LOANS_INFO_TEMPLATE(key));
                for (let i of children) {
                    const child = info_container.appendChild(i);
                }
            }
    }
}

function setFilter(e) {
    const elem = e.currentTarget;
    const activity_container = document.querySelector('#activity #unfiltered');
    const filtered_div = document.querySelector('#activity #filtered-div');

    if (filter_list.includes(elem.dataset.number)) {
        filter_list.splice(filter_list.indexOf(elem.dataset.number), 1);
    } else filter_list.push(elem.dataset.number);
    if (elem.dataset.active === 'false') {
        elem.dataset.active = 'true';
        for (let key of transactions)
            if (key.card === elem.dataset.number) {
                const elem = filtered_div.appendChild(getChild(TRANSACTION_TEMPLATE(key)));
                elem.addEventListener('click', showMoreDetails);
            }
    } else {
        const filtered_transactions = document.querySelectorAll('#filtered-div .activity-row');
        elem.dataset.active = 'false';
        for (let key of filtered_transactions) {
            if (elem.dataset.number === key.dataset.number) {
                filtered_div.removeChild(key);
            }
        }
    }
    if (filter_list.length === 0) {
        hideDiv(filtered_div);
        showDiv(activity_container);
    } else {
        hideDiv(activity_container);
        showDiv(filtered_div);
    }
}

function removeAllFilters() {
    const filter_cards = document.querySelectorAll('#activity .filter-card');
    const filtered_div = document.querySelector('#activity #filtered-div');
    for (let key of filter_cards) key.dataset.active = 'false';
    filter_list = [];
    emptyDiv(filtered_div);
    hideDiv(document.querySelector('#activity #filtered-div'));
    showDiv(document.querySelector('#activity #unfiltered'));
}

function search(e) {
    const val = e.currentTarget.value.toLowerCase();

    const activity_container = document.querySelector('#activity #unfiltered');
    const filtered_div = document.querySelector('#activity #filtered-div');
    const filter_container = document.querySelector('#activity .filter-container');
    if (activity_container.dataset.visible === 'visible') hideDiv(activity_container);
    if (filtered_div.dataset.visible === 'hidden') showDiv(filtered_div);
    if (filter_container.dataset.visible === 'visible') hideDiv(filter_container);

    emptyDiv(filtered_div);

    if (val.length == 0) {
        //restore transactions div
        showDiv(filter_container);
        removeAllFilters();
    } else {
        for (let key of transactions)
            if (key.agent.toLowerCase().indexOf(val) !== -1) {
                const elem = filtered_div.appendChild(getChild(TRANSACTION_TEMPLATE(key)));
                elem.addEventListener('click', showMoreDetails);
            }
    }
}

function clearSearch() {
    const filter_container = document.querySelector('#activity .filter-container');
    searchInput.value = '';
    showDiv(filter_container);
    removeAllFilters();
}

function addToFavorite(e) {
    const elem = e.currentTarget;
    const info_block = elem.closest('.info-row');
    const favorite_element_container = document.querySelector('#activity .favorite-elements-container');
    const favorite_container = document.querySelector('#activity .favorite-container');

    if (elem.dataset.img === 'unselected') {
        favorite_container.dataset.active = 'true';
        elem.src = 'images/icons/star.svg';
        elem.dataset.img = 'selected';
        const newDiv = document.createElement('div');
        newDiv.classList.add('favorite-element');
        newDiv.dataset.data = info_block.dataset.data;
        newDiv.dataset.balance = info_block.dataset.balance;
        newDiv.textContent = info_block.dataset.data + ' | ' + info_block.dataset.balance;
        const newImg = document.createElement('img');
        newImg.addEventListener('click', removeFavorite);
        newImg.src = 'images/icons/clear.svg';
        newDiv.appendChild(newImg);
        favorite_element_container.appendChild(newDiv);
    } else {
        elem.src = 'images/icons/star_outline.svg';
        elem.dataset.img = 'unselected';
        const toRemove = document.querySelector(
            '#activity .favorite-elements-container div[data-data ="' + info_block.dataset.data + '"]'
        );
        favorite_element_container.removeChild(toRemove);
        if (favorite_element_container.children.length === 0) {
            favorite_container.dataset.active = 'false';
        }
    }
}

function removeFavorite(e) {
    const elem = e.currentTarget;
    const toRemove = elem.closest('.favorite-element');
    const favorite_element_container = document.querySelector('#activity .favorite-elements-container');
    const favorite_container = document.querySelector('#activity .favorite-container');

    const info_rows = document.querySelectorAll('#activity .info-container .info-row');
    for (let key of info_rows)
        if (key.dataset.data === toRemove.dataset.data) {
            const img = key.querySelector('div img');
            img.dataset.img = 'unselected';
            img.src = 'images/icons/star_outline.svg';
        }
    favorite_element_container.removeChild(toRemove);
    if (favorite_element_container.children.length === 0) {
        favorite_container.dataset.active = 'false';
    }
}

function changeStock(e) {
    const elem = e.currentTarget;
    const stock_container = document.querySelector('#market .stock-info-container');
    if (elem.dataset.active === 'false') {
        document.querySelector(
                '#market .scroll-container[data-set = "stock"] .stock-card[data-active="true"]'
            ).dataset.active =
            'false';
        elem.dataset.active = 'true';
        document.querySelector("#market .stock-info-container div[data-active='true']").dataset.active = 'false';
        //change chart view
        if (
            document.querySelector('#market .stock-info-container div[data-stock = ' + elem.dataset.link + ']') === null
        ) {
            fetch(
                    'https://cloud.iexapis.com/stable/stock/' +
                    elem.dataset.link +
                    '/quote?token=pk_9bceca2c95c04eee8febdc0b538c89a6'
                )
                .then(onResponse)
                .then(function(json) {
                    let block = {
                        trend: '',
                        name: json.companyName,
                        symbol: json.symbol,
                        price: json.latestPrice,
                        change: json.change,
                        changePercent: json.changePercent * 100,
                        favorite: 'false',
                        high: json.high,
                        low: json.low,
                        pe: json.peRatio,
                        week52High: json.week52High,
                        week52Low: json.week52Low,
                        volume: json.volume,
                        cap: ''
                    };
                    json.change > 0 ? (block.trend = 'up') : (block.trend = 'down');
                    stock_container.appendChild(getChild(STOCK_INFO_TEMPLATE(block)));
                });
        } else {
            document.querySelector(
                    '#market .stock-info-container div[data-stock = ' + elem.dataset.link + ']'
                ).dataset.active =
                'true';
        }
    }
}