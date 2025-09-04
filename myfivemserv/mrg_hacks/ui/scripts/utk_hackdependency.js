
var audioPlayer = null;

CreateScriptMessageListener("utk_hackdependency", function(data){
    if (data.transactionType == "intro") {
        if (audioPlayer != null) {
          audioPlayer.pause();
        }
  
        audioPlayer = new Howl({src: ["./assets/utk_hackdependency/intro.ogg"]});
        audioPlayer.volume(0.2);
        audioPlayer.play();
  
    } else if (data.transactionType == "success") {
    
        if (audioPlayer != null) {
            audioPlayer.pause();
        }
    
        audioPlayer = new Howl({src: ["./assets/utk_hackdependency/success.ogg"]});
        audioPlayer.volume(0.2);
        audioPlayer.play();
    } else if (data.transactionType == "fail") {
        
        if (audioPlayer != null) {
            audioPlayer.pause();
        }
    
        audioPlayer = new Howl({src: ["./assets/utk_hackdependency/fail.ogg"]});
        audioPlayer.volume(0.2);
        audioPlayer.play();
    }
})