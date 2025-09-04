const Judgments = {
    ['street']: {
        label: 'Wykroczenia drogowe',
        options: [
            { name: 'speed', label: 'Przekroczenie predkosci', jail: 0, fine: 500 },
            { name: 'drunkDriving', label: 'Jazda bez prawa jazdy', jail: 0, fine: 1500 },
            { name: 'red', label: 'Przejazd na czerwonym swietle', jail: 0, fine: 750 },
            { name: 'crash', label: 'Spowodowanie kolizji', jail: 0, fine: 5000 },
            { name: 'oc', label: 'Brak OC', jail: 0, fine: 500 }
        ]
    },
    ['propertyCrime']: {
        label: 'Wykroczenia',
        options: [
            { name: 'radiowoz', label: 'Kradziez radiowozu', jail: 10, fine: 5000 },
            { name: 'auta', label: 'Kradziez pojazdu', jail: 5, fine: 2000 },
            { name: 'dom', label: 'Wlamanie do domu', jail: 15, fine: 5000 },
            { name: 'obraza', label: 'Obraza Funkcjonariusza', jail: 0, fine: 2500 },
            { name: 'utrudnianie', label: 'Utrudnianie pracy funkcjonariusza', jail: 5, fine: 5000 },
            { name: 'terenprywatny', label: 'Wtargniecie na teren prywatny', jail: 10, fine: 5000 },
        ]
    },
    ['heists']: {
        label: 'Napady',
        options: [
            { name: 'shopRobbery', label: 'Napad na sklep', jail: 5, fine: 1500 },
            { name: 'bankRobbery', label: 'Napad na Bank Fleeca', jail: 30, fine: 15000 },
            { name: 'jubi', label: 'Napad na Jubilera', jail: 30, fine: 25000 },
            { name: 'ziutek', label: 'Okradanie obywateli', jail: 5, fine: 1000 },
            { name: 'magazyn', label: 'Włamanie do magazynu', jail: 5, fine: 3500 },
            { name: 'notracker', label: 'Kradziez pojazdu z nadajnikiem', jail: 15, fine: 4000 }
        ]
    },
    ['violence']: {
        label: 'Przestepstwa',
        options: [
            { name: 'assault', label: 'Pobicie', jail: 15, fine: 1500 },
            { name: 'attemptedMurder', label: 'Proba zabojstwa obywatela', jail: 35, fine: 7500 },
            { name: 'porwanieobywatela', label: 'Porwanie obywatela', jail: 25, fine: 12000 },
            { name: 'porwanielspd', label: 'Porwanie Funkcjonariusza LSPD', jail: 30, fine: 15000 },
            { name: 'porwanieemslsc', label: 'Porwanie pracownika EMS/LSC', jail: 30, fine: 15000 },
            { name: 'murder', label: 'Proba zabojstwa funkcjonariusza LSPD', jail: 45, fine: 7500 }
        ]
    },
    ['drugs']: {
        label: 'Narkotyki',
        options: [
            { name: 'possessionSmall', label: 'Posiadanie marihuany', jail: 5, fine: 1500 },
            { name: 'possessionLarge', label: 'Posiadanie metaafetaminy/kokainy', jail: 15, fine: 5000 },
            { name: 'drugProduction', label: 'Handel narkotykami twardymi', jail: 25, fine: 5000 },
            { name: 'drugTrafficking', label: 'Handel narkotykami miekkimi', jail: 15, fine: 5000 }
        ]
    },
    ['weaponsCrimes']: {
        label: 'Bron',
        options: [
            { name: 'illegalPossession', label: 'Posiadanie nielegalnej broni', jail: 15, fine: 12000 },
            { name: 'posiadaniepolicyjnej', label: 'Posiadanie broni policyjnej', jail: 15, fine: 10000 },
            { name: 'dluganielegalna', label: 'Posiadanie nielegalnej broni dlugiej', jail: 30, fine: 12000 },
            { name: 'dlugapolicyjna', label: 'Posiadanie policyjnej broni dlugiej', jail: 40, fine: 12000 },
            { name: 'armsTrafficking', label: 'Posiadanie sprzetu policyjnego', jail: 10, fine: 4000 },
            { name: 'unauthorizedUse', label: 'Nieautorzowane uzycie broni', jail: 10, fine: 2000 },
            { name: 'explosivePossession', label: 'Posiadanie ladunku wybuchowego (C4/Sentex)', jail: 30, fine: 15000 },
            { name: 'weaponBrandishing', label: 'Handel nielegalna bronia', jail: 25, fine: 15000 }
        ]
    },
    ['publicOrder']: {
        label: 'Inne',
        options: [
            { name: 'publicDrinking', label: 'Pomoc w ucieczce', jail: 10, fine: 5000 },
            { name: 'disturbingPeace', label: 'Ucieczka z miejsca przest pstwa', jail: 10, fine: 5000 },
            { name: 'ucieczkakonwoj', label: 'Pomoc w ucieczce z konwoju', jail: 15, fine: 10000 },
            { name: 'wspoludzial', label: 'Wspoludzial w przestpestwie', jail: 10, fine: 10000 },
            { name: 'szefgrupa', label: 'Dowodzenie grupie przestepczej', jail: 90, fine: 50000 },
            { name: 'robolgrupa', label: 'Przynaleznosc do grupy przestpeczej', jail: 45, fine: 25000 },
            { name: 'korump', label: 'Korupcja', jail: 100, fine: 100000 },
            { name: 'vandalism', label: 'Terroryzm', jail: 300, fine: 300000 }
        ]
    },
    //['environmentalCrimes']: {
        //label: 'Environmental Crimes',
        //options: [
            //{ name: 'illegalFishing', label: 'Illegal Fishing', jail: 5, fine: 10000 },
            //{ name: 'illegalHunting', label: 'Illegal Hunting', jail: 10, fine: 15000 },
            //{ name: 'toxicDumping', label: 'Toxic Waste Dumping', jail: 20, fine: 50000 },
            //{ name: 'deforestation', label: 'Deforestation', jail: 15, fine: 40000 },
            //{ name: 'oilSpillNegligence', label: 'Oil Spill Negligence', jail: 25, fine: 70000 }
        //]
    //},
    //['financialCrimes']: {
        //label: 'Financial Crimes',
        //options: [
            //{ name: 'taxEvasion', label: 'Tax Evasion', jail: 10, fine: 30000 },
            //{ name: 'fraud', label: 'Fraud', jail: 15, fine: 40000 },
            //{ name: 'embezzlement', label: 'Embezzlement', jail: 20, fine: 50000 },
            //{ name: 'insiderTrading', label: 'Insider Trading', jail: 25, fine: 75000 },
            //{ name: 'counterfeiting', label: 'Counterfeiting', jail: 30, fine: 100000 }
        //]
    //},
    //['cybercrime']: {
        //label: 'Cybercrimes',
        //options: [
            //{ name: 'hacking', label: 'Hacking into Systems', jail: 10, fine: 15000 },
            //{ name: 'identityTheft', label: 'Identity Theft', jail: 15, fine: 20000 },
            //{ name: 'phishing', label: 'Phishing Attacks', jail: 5, fine: 10000 },
            //{ name: 'ddosAttack', label: 'DDoS Attack', jail: 20, fine: 30000 },
            //{ name: 'cyberExtortion', label: 'Cyber Extortion', jail: 25, fine: 40000 }
        //]
    //}
};
