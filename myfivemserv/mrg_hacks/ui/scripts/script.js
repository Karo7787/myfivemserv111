CreateScriptMessageListener = function(script, func){
    window.addEventListener('message', function(event) {
        switch(event.data.script){
            case script:
                func(event.data.data)
            break;
        }
    })
}