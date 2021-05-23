const cards = [{
        favorite: true,
        vendor: 'visa',
        type: 'Bancomat',
        number: '5678',
        date: '03/24',
        status: 'Active',
        balance: '25.800',
        dailyL: '1200',
        monthL: '3600',
        activationDate: '08-08-2020'
    },
    {
        vendor: 'mastercard',
        type: 'Credit Card',
        number: '7789',
        date: '02/25',
        status: 'Active',
        dailyL: '2500',
        monthL: '5500',
        activationDate: '28-10-2018'
    },
    {
        vendor: 'mastercard',
        type: 'Debit Card',
        number: '1441',
        date: '01/22',
        status: 'Active',
        balance: '375.44',
        dailyL: '600',
        monthL: '1000',
        activationDate: '30-12-2020'
    }
];

const transactions = [{
        inOut: 'in',
        agent: 'Leonard Hoffmann',
        amount: '120.50',
        type: 'Receiving',
        card: '5678',
        date: '19-03-2021'
    },
    {
        inOut: 'out',
        agent: 'Martin Appleseed',
        amount: '88.15',
        type: 'Sending',
        card: '1441',
        date: '19-03-2021'
    },
    {
        inOut: 'out',
        agent: 'Starbucks Coffee',
        amount: '7.50',
        type: 'Payment',
        card: '1441',
        date: '17-03-2021'
    },
    {
        inOut: 'out',
        agent: 'Nike Inc.',
        amount: '254.22',
        type: 'Payment',
        card: '7789',
        date: '18-03-2021'
    },
    {
        inOut: 'in',
        agent: 'Albert Austin',
        amount: '12.50',
        type: 'Receiving',
        card: '5678',
        date: '18-03-2021'
    },

    {
        inOut: 'out',
        agent: 'Apple',
        amount: '499.15',
        type: 'Payment',
        card: '5678',
        date: '19-03-2021'
    },
    {
        inOut: 'out',
        agent: 'Amazon',
        amount: '47.60',
        type: 'Payment',
        card: '7789',
        date: '18-03-2021'
    },
    {
        inOut: 'in',
        agent: 'Amazon',
        amount: '55.22',
        type: 'Refund',
        card: '1441',
        date: '16-03-2021'
    },

    {
        inOut: 'in',
        agent: 'Leonard Hoffmann',
        amount: '22.50',
        type: 'Receiving',
        card: '1441',
        date: '19-03-2021'
    },
    {
        inOut: 'out',
        agent: 'Netflix',
        amount: '33.15',
        type: 'Subscription',
        card: '5678',
        date: '19-03-2021'
    },
    {
        inOut: 'out',
        agent: "McDonald's",
        amount: '14.22',
        type: 'Payment',
        card: '5678',
        date: '18-03-2021'
    },
    {
        inOut: 'in',
        agent: 'Albert Austin',
        amount: '5.50',
        type: 'Receiving',
        card: '5678',
        date: '13-03-2021'
    }
];

const history = [{
        month: '03',
        year: '2021',
        balance: '+ 12.580'
    },
    {
        month: '02',
        year: '2021',
        balance: '+ 9.458'
    },
    {
        month: '01',
        year: '2021',
        balance: '+ 12.005'
    },
    {
        month: '12',
        year: '2020',
        balance: '+ 10.288'
    }
];

const loans = [{
        favorite: true,
        number: '255563',
        startDate: '20-12-2020',
        amount: '5600',
        tax: '3',
        returned: '450',
        toReturn: '5150',
        fee: '150'
    },
    {
        favorite: false,
        number: '257568',
        startDate: '01-03-2021',
        amount: '500',
        tax: '5',
        returned: '0',
        toReturn: '500',
        fee: '150'
    }
];

const safeBoxes = [{
    branch: 'Via Traversari 81 - Florence',
    sector: '3C',
    level: '3',
    startDate: '01-01-2021',
    fee: '30'
}];

const profile = [{
    aNumber: '122-558-00015',
    aType: 'Pro',
    cf: 'DOEJHN80A01H501F',
    mail: 'johndoe@gmail.com',
    name: 'John',
    surname: 'Doe',
    phone: '+39 334 2589710',
    residence: 'Rome',
    dob: '01-01-1980',
    startDate: '08-08-2017',
    fee: '37.50',
    img: 'images/profile.png'
}];

const currency_list = [{
        base: 'EUR',
        currencies: ['USD', 'GBP']
    },
    {
        base: 'USD',
        currencies: ['MXN', 'JPY']
    }
];

const stockSymbols = [{
        symbol: 'AAPL',
        favorite: true
    },
    {
        symbol: 'NKE'
    },
    {
        symbol: 'MSFT'
    },
    {
        symbol: 'SBUX'
    }
];