window.printText = function(str) {
    cordova.exec(
        function(success){
            alert('Printed!');
        }, 
        function(err) {
            alert("Can't Print");
        }, 
        "BixolonPrinter", 
        "printText", 
        [str]);
};
