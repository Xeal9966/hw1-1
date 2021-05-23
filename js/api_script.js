function subDay(sub) {
    let d = new Date();
    if (sub !== 0) {
        let ret = d.setDate(d.getDate() - sub);
        return new Date(ret).toISOString().slice(0, 10);
    }
    return d.toISOString().slice(0, 10);
}

function getCurrencyChartData() {
    let obj = [];

    for (let i = 0; i < 10; i++) {
        fetch(
                'http://data.fixer.io/api/' +
                subDay(i) +
                '?access_key=c070fff189619f6a0cb2cd37f352d63b&base=EUR&symbols=USD,GBP'
            )
            .then(onResponse)
            .then(function(json) {
                obj.push({
                    date: json.date,
                    rates: json.rates
                });
            });
    }
    return obj;
}

function getLatest() {
    let obj = [];
    for (let key of currency_list)
        fetch('https://api.coinbase.com/v2/exchange-rates?currency=' + key.base).then(onResponse).then(function(json) {
            for (let temp of key.currencies)
                obj[key.base].push({
                    base: key.base,
                    curr: temp,
                    value: json.data.rates[temp]
                });
        });
    return obj;
}

function onResponse(response) {
    return response.json();
}