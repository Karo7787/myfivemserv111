$('document').ready(function(){
    $gif = $('.utk_fingerprint_img').first();
});
  


CreateScriptMessageListener("utk_fingerprint", function(data){
    if (data.type === "intro") {
        $gif.attr("src", "./assets/utk_fingerprint/intro.gif");
        setTimeout(function() {
          $gif.attr('src', "./assets/utk_fingerprint/blank.png");
        }, 3500)
      } else if (data.type === "success") {
        $gif.attr("src", "./assets/utk_fingerprint/success.gif");
        setTimeout(function() {
          $gif.attr('src', "./assets/utk_fingerprint/blank.png");
        }, 3000)
      } else if (data.type == "fail") {
        $gif.attr("src", "./assets/utk_fingerprint/fail.gif");
        setTimeout(function() {
          $gif.attr('src', "./assets/utk_fingerprint/blank.png");
        }, 3000)
      }
})