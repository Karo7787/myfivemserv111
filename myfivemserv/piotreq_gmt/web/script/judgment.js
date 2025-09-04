const Judgments = {
    ['small']: {
        label: 'OGOLNE',
        options: [
            {
                name: 'siniaki', // unique name
                label: 'Siniaki',
                fine: 750
            },
            {
                name: 'zadrapania', // unique name
                label: 'Zadrapania',
                fine: 750
            },
            {
                name: 'littleopatrunek', // unique name
                label: 'Maly Opatrunek',
                fine: 1250
            },
            {
                name: 'bigopatrunek', // unique name
                label: 'Duzy opatrunek',
                fine: 1500
            }

        ]
    },
    ['broken']: {
        label: 'ZLAMANIA',
        options: [
            {
                name: 'zlamanie', // unique name
                label: 'Zamkniete bez przemieszczenia',
                fine: 2500
            },
            {
                name: 'zlamanie2', // unique name
                label: 'Zamkniete z przemieszczeniem',
                fine: 3000
            },
            {
                name: 'otwarte', // unique name
                label: 'Otwarte zlamanie',
                fine: 3500
            }
        ]
    },
    ['burn']: {
        label: 'OPARZENIA',
        options: [
            {
                name: 'first', // unique name
                label: '1 stopien',
                fine: 750
            },
            {
                name: 'second', // unique name
                label: '2 stopien',
                fine: 1500
            },
            {
                name: 'third', // unique name
                label: '3 stopien',
                fine: 2250
            }
        ]
    },
    ['work']: {
        label: 'ZABIEGI',
        options: [
            {
                name: 'cut', // unique name
                label: 'Usuniecie ciala obcego z ciala pacjenta',
                fine: 2500
            },
            {
                name: 'szwy', // unique name
                label: 'Szycie rany wyjsciowej',
                fine: 500
            },
            {
                name: 'tamowanie', // unique name
                label: 'Zatrzymywanie krwawienia wewnetrznego',
                fine: 300
            },
            {
                name: 'szwy2', // unique name
                label: 'Szycie rozerwanej tetnicy',
                fine: 3500
            },
            {
                name: 'sprzet', // unique name
                label: 'Uzycie sprzetu chirurgicznego',
                fine: 250
            }
        ]
    },
    ['leki']: {
        label: 'LEKI',
        options: [
            {
                name: 'NLPZ', // unique name
                label: 'NLPZ',
                fine: 250
            },
            {
                name: 'opioidy', // unique name
                label: 'Opioidy',
                fine: 250
            },
            {
                name: 'sen', // unique name
                label: 'Tabletki nasenne',
                fine: 250
            },
            {
                name: 'antyemetki', // unique name
                label: 'Antyemetki',
                fine: 250
            },
            {
                name: 'antybiotyki', // unique name
                label: 'Antybiotyki',
                fine: 500
            },
            {
                name: 'antyalergiczne', // unique name
                label: 'Antyalergiczne',
                fine: 500
            },
            {
                name: 'hemostatyki', // unique name
                label: 'Hemostatyki',
                fine: 500
            },
            {
                name: 'antykoagulanty', // unique name
                label: 'Antykoagulanty',
                fine: 500
            },
            {
                name: 'plyny', // unique name
                label: 'Plyny',
                fine: 500
            }
        ]
    },
    ['badania']: {
        label: 'BADANIA',
        options: [
            {
                name: 'RTG', // unique name
                label: 'RTG',
                fine: 1000
            },
            {
                name: 'USG', // unique name
                label: 'USG',
                fine: 500
            },
            {
                name: 'komputer', // unique name
                label: 'Tomografia komputerowa',
                fine: 1500
            },
            {
                name: 'psycholog', // unique name
                label: 'Psycholog',
                fine: 750
            }
        ]
    },
    ['inne']: {
        label: 'INNE',
        options: [
            {
                name: 'praca', // unique name
                label: 'Utrudnianie pracy EMS',
                fine: 1200
            },
            {
                name: 'transport', // unique name
                label: 'Transport rannych do szpitala',
                fine: 500
            },
            {
                name: 'transport2', // unique name
                label: 'Transport rannych do domu (za kilometr)',
                fine: 1500
            },
            {
                name: 'r1', // unique name
                label: 'Uzycie R1',
                fine: 250
            }
        ]
    },

}