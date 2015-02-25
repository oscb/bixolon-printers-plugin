# Bixolon Printers Plugin for Phonegap/Cordova
_Work on this plugin is on hold as I don't have anymore a way to test it_
**_If you can provide testing please contact me._**

A simple Bixolon Printer SDK for Phonegap for using Thermal Printers. 
Based on the [official SDK by Bixolon](http://www.bixolon.com/html/en/download/download_category.xhtml?ca_id=103&large_cd=0011&small_cd=0001).

### Compatibility
- SPP-R200II
- SPP-R300
- SPP-R400
- SRP-275
- SRP-275II
- SRP-340
- SRP-350
- SRP-F310

# How to Use

Here is an example inside an ionic app using the atomicPrint functions:

```javascript

$ionicPlatform.ready(function () {
    if (typeof BX_Printer != 'undefined') {
      BX_Printer.atomicPrint(printerIP, text,
        function () {
          console.info("Printer Success");
        }, function() {
          console.error("Printer Failure");
        });
    }
  });
  
```

Now another example using the non-atomic functions that provide a more granular operation:

```javascript

$ionicPlatform.ready(function () {
    if (typeof BX_Printer != 'undefined') {
    
      BX_Printer.connect(printerIP, text, function () {
        
            BX_Printer.alignment = BX_Alignment.BXL_ALIGNMENT_CENTER;
            BX_Printer.widthSize = BX_WidthSize.BXL_TS_2WIDTH;
            BX_Printer.heightSize = BX_WidthSize.BXL_TS_3HEIGHT;
            
            BX_Printer.printText("\r\n\r\nHola Mundo\r\n\r\n", function() {
            
                BX_Printer.cutPaper(function() {
                    BX_Printer.disconnect();
                });
            });   
            
        }, function() {
          console.error("Printer Failure");
        });
    }
  });
  
```

# API

## Variables

#### connected
_Boolean_ Marks if the plugin is currently connected to a printer

#### alignment
_Int_ Sets the alignment of the text. Check BX_Alignment for available options.

#### widthSize
_Int_ Sets the width of the font. Check BX_WidthSize for available options.

#### heightSize
_Int_ Sets the height of the font. Check BX_HeightSize for available options.

## Functions

#### connect( _ip_, _success_callback_, _error_callback_ )
- _ip_ = Printer IP in IPv4 format
- _success_callback_
- _error_callback_

Sets the connection to the printer. Printer must be on local network mode and properly configured.

#### disconnect( _success_callback_, _error_callback_ )
- _success_callback_
- _error_callback_

Disconnects from the printer and releases memory. Always remember to explicitely call disconnect, as the Bixolon Controller will get hold of it for a long time before timing out if you don't disconnect.

#### printText( _text_, _success_callback_, _error_callback_ )
- _text_ = The Text to print. Formatted just like a JS String only line-breaks are in _\r\n_ format
- _success_callback_
- _error_callback_

Sends the text to print. 
You can format the text by setting the object variables: **alignment, widthSize and heightSize** as in the second example.
The Supported Sizes and Alignments are set in globals: **BX_Alignment, BX_WidthSize and BX_HeightSize**.

#### cutPaper( _success_callback_, _error_callback_ )
- _success_callback_
- _error_callback_

Makes the printer cut the paper just where it finished printing. 
_Note: You'll probably want to leave a couple of blank spaces before cutting, as the physical cutter around 2 lines above the last printed line_

#### openDrawer( _success_callback_, _error_callback_ )
- _success_callback_
- _error_callback_

Opens the money drawer if one is connected to the printer.

#### atomicPrint( _ip_, _text_, _success_callback_, _error_callback_ )
- _ip_ = Printer IP in IPv4 format
- _text_ = The Text to print. Formatted just like a JS String only line-breaks are in _\r\n_ format
- _success_callback_
- _error_callback_

Performs all basic operations at once: Connecting, Printing a Text, Cutting the Paper and Disconnecting.
This is useful if your app must connect to several different printers (e.g. a printer in the counter and another in the kitchen), since the Bixolon Official Controller is a Singleton and can only connect at one printer at a time. This atomic function ensures that all opperations are completed before taking on another task.
_Probably there's a better way to manage multiple printers if you have an idea please contact me!_

#### atomicOpen( _ip_, _success_callback_, _error_callback_ )
- ip = Printer IP in IPv4 format
- _success_callback_
- _error_callback_

Performs all operations to open a drawer at once: Connecting, Opening Drawer and Disconnecting.



# Future work (if testers are available)
_Work on this plugin is on hold as I don't have anymore a way to test it_
**_If you can provide testing please contact me._**
- Android Support
- Support to image printing
- Provide multi printer connection without atomic functions
 

