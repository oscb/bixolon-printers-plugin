/********* BixolonPlugin.m Cordova Plugin Implementation *******/

#import "BixolonPlugin.h"

@implementation BixolonPlugin

- (void)pluginInitialize
{
    _pController = [BXPrinterController getInstance];
    _pController.delegate = self;
    _pController.lookupCount = 5;
    _pController.AutoConnection = BXL_CONNECTIONMODE_NOAUTO;
    [_pController open];
    [_pController lookup];
}

- (void)didFindPrinter:(BXPrinterController *)controller
               printer:(BXPrinter *)printer
{
    NSLog(@"didFindPrinter");
    _pController.target = printer;
    NSLog(_pController.target.address);
}

- (void)printText:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* text = [command.arguments objectAtIndex:0];

    if (text != nil && [text length] > 0) {
        // Print things
        _pController.textEncoding = 0x0C;
        _pController.characterSet = 16;
        [_pController printText:text];
        [_pController printText:@"\r\n"];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:text];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end