var BX_Alignment = {
    BXL_ALIGNMENT_LEFT: 0,
    BXL_ALIGNMENT_CENTER: 1,
    BXL_ALIGNMENT_RIGHT: 2
};

var BX_WidthSize = {
    BXL_TS_0WIDTH: 0,
    BXL_TS_1WIDTH: 16,
    BXL_TS_2WIDTH: 32,
    BXL_TS_3WIDTH: 48,
    BXL_TS_4WIDTH: 64,
    BXL_TS_5WIDTH: 80,
    BXL_TS_6WIDTH: 96,
    BXL_TS_7WIDTH: 112
};

var BX_HeightSize = {
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
    alignment: BX_Alignment.BXL_ALIGNMENT_LEFT,
    widthSize: BX_WidthSize.BXL_TS_0WIDTH,
    heightSize: BX_HeightSize.BXL_TS_1HEIGHT,
    textSize: function() { return this.widthSize | this.heightSize;},

    connect: function(ip, success_callback, error_callback) {
        cordova.exec(
            function(success){
                this.connected = true;
                success_callback();
            },
            function(err) {
                console.error("Can't Connect");
                error_callback();
            },
            "BixolonPlugin",
            "connect",
            [ip]);
    },

    disconnect: function(success_callback, error_callback) {
        cordova.exec(
            function(success){
                console.info("Disconnect");
                this.connected = false;
                // success_callback();
            },
            function(err) {
                console.error("Can't disconnect");
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
                console.error("Can't Print");
                error_callback();
            },
            "BixolonPlugin",
            "printText",
            [str, this.alignment, this.textSize()]);
    },

    cutPaper: function(success_callback, error_callback) {
        cordova.exec(
            function(success){
                // Checar esta llamada
                success_callback();
            },
            function(err) {
                console.error("Can't Cut");
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
                console.error("Can't Open Drawer");
                error_callback();
            },
            "BixolonPlugin",
            "openDrawer",
            []);
    },
    // Atomic Print
    atomicPrint: function(ip, text, success_callback, error_callback) {
        cordova.exec(
            function (success) {
                console.info(success);
                if (success_callback)
                    success_callback();
            },
            function (error) {
                console.error("Can't print");
                if (error_callback)
                    error_callback();
            },
            "BixolonPlugin",
            "atomicPrint",
            [ip, text]
        )
    },
    // Atomic Open Drawer
    atomicOpen: function(ip, success_callback, error_callback) {
        cordova.exec(
            function (success) {
                console.info(success);
                if (success_callback)
                    success_callback();
            },
            function (error) {
                console.error("Can't print");
                if (error_callback)
                    error_callback();
            },
            "BixolonPlugin",
            "atomicOpen",
            [ip]
        )
    }
};
