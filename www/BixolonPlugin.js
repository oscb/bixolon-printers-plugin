var Alignment = {
    BXL_ALIGNMENT_LEFT: 0,
    BXL_ALIGNMENT_CENTER: 1,
    BXL_ALIGNMENT_RIGHT: 2
};

var TextSize = {
    BXL_TS_0WIDTH: 0,
    BXL_TS_1WIDTH: 16,
    BXL_TS_2WIDTH: 32,
    BXL_TS_3WIDTH: 48,
    BXL_TS_4WIDTH: 64,
    BXL_TS_5WIDTH: 80,
    BXL_TS_6WIDTH: 96,
    BXL_TS_7WIDTH: 112,

    BXL_TS_0HEIGHT: 0,
    BXL_TS_1HEIGHT: 1,
    BXL_TS_2HEIGHT: 2,
    BXL_TS_3HEIGHT: 3,
    BXL_TS_4HEIGHT: 4,
    BXL_TS_5HEIGHT: 5,
    BXL_TS_6HEIGHT: 6,
    BXL_TS_7HEIGHT: 7
};

var BX_Printer = {
    connected: false,
    alignment: Alignment.BXL_ALIGNMENT_LEFT,
    textSize: TextSize.BXL_TS_0WIDTH | TextSize.BXL_TS_1HEIGHT,

    connect: function(ip, success_callback, error_callback) {
        cordova.exec(
            function(success){
                this.connected = true;
                success_callback();
            },
            function(err) {
                console.log("Can't Connect");
                error_callback();
            },
            "BixolonPlugin",
            "connect",
            [ip]);
    },

    disconnect: function(success_callback, error_callback) {
        cordova.exec(
            function(success){
                console.log("Disconnect");
                this.connected = false;
                // success_callback();
            },
            function(err) {
                console.log("Can't disconnect");
                // error_callback();
            },
            "BixolonPlugin",
            "disconnect",
            []);
    },

    printText: function(str, success_callback, error_callback) {
        cordova.exec(
            function(success){
                success_callback();
            },
            function(err) {
                console.log("Can't Print");
                error_callback();
            },
            "BixolonPlugin",
            "printText",
            [str, this.alignment, this.textSize]);
    },

    cutPaper: function(success_callback, error_callback) {
        cordova.exec(
            function(success){
                // Checar esta llamada
                success_callback();
            },
            function(err) {
                console.log("Can't Cut");
                error_callback();
            },
            "BixolonPlugin",
            "cutPaper",
            []);
    },

    openDrawer: function(success_callback, error_callback) {
        cordova.exec(
            function(success){
                success_callback();
            },
            function(err) {
                console.log("Can't Open Drawer");
                error_callback();
            },
            "BixolonPlugin",
            "openDrawer",
            []);
    },
    // Atomic Print
    print: function(ip, text, success_callback, error_callback) {
      cordova.exec(
        function (success) {
          success_callback();
        },
        function (error) {
          console.log("can't print");
          error_callback();
        },
        "BixolonPlugin",
        "atomicPrint",
        [ip, text]
      )
    },
    // Atomic Open Drawer
    open: function(ip, success_callback, error_callback) {
      cordova.exec(
        function (success) {
          success_callback();
        },
        function (error) {
          console.log("can't print");
          error_callback();
        },
        "BixolonPlugin",
        "atomicOpen",
        [ip]
      )
    },
};
