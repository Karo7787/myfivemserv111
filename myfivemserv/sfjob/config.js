var language = "pl"; // default support for pl, en

var defaultJobs = {
    "farmer": "Praca farmera to harmonia z naturą i satysfakcja z własnych plonów. Zasiej pasję, zbieraj owoce!",
    "gopostal": "Praca kuriera to szybkie tempo i uśmiechy klientów. Dostarczaj radość prosto pod drzwi!",
    "taxi": "Taksówkarz przewozi pasażerów, zapewniając szybki, wygodny i bezpieczny transport.",
}

var tipsEnabled = true; // true of false

// languages
if(language=="pl")
{
    var locales = {
        main_header: "Witaj w centrum pracy",
        main_desc: "Los Santos",
        main_button: "Pokaż dostępne prace",
        text_header: "Centrum pracy",
        text_button_in: "Zatrudnij się",
        text_button_drop: "Zwolnij się",
        text_description: "...",
        no_jobs: "Brak dostępnych prac",
        text_input_money: "Kwota",
        text_cash_register: "Kasa",
        text_cash_added_products: "Dodane produkty",
        text_cash_summary: "Razem",
        text_cash_button: "Zatwierdź zamówienie",
        text_cash_price: "Kwota do zapłaty",
        text_cash_price2: "Do zapłaty",
        text_cash_pay_money: "Zapłać gotówką",
        text_cash_pay_card: "Zapłać kartą",
        text_cash_bonus: "Napiwek",
        text_input_bonus: "Kwota napiwku",
    }
}

if(language=="en")
{
    var locales = {
        main_header: "Welcome to Job Center",
        main_desc: "Los Santos",
        main_button: "Show Available Job",
        text_header: "Job Center",
        text_button_in: "Get a job",
        text_button_drop: "Quit your job",
        text_description: "...",
        no_jobs: "No jobs available",
        text_input_money: "Amount",
        text_cash_register: "Cash register",
        text_cash_added_products: "Added products",
        text_cash_summary: "Summary",
        text_cash_button: "Confirm the order",
        text_cash_price: "Amount to pay",
        text_cash_price2: "To pay",
        text_cash_pay_money: "Pay in cash",
        text_cash_pay_card: "Pay by card",
        text_cash_bonus: "Tip",
        text_input_bonus: "Tip amount",
    }
}