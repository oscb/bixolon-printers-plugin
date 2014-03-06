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

//
// Delegate Mehtods
//
- (void)willLookupPrinters:(BXPrinterController *)controller
{
    NSLog(@"willLookupPrinters");
    
}

- (void)didLookupPrinters:(BXPrinterController *)controller
{
    NSLog(@"didLookupPrinters");
    
    //Add 8
    [_pController selectTarget];
    if( NO==[_pController connect] )
        NSLog(@"Connect Error");
}

- (void)willConnect:(BXPrinterController *)controller
printer:(BXPrinter *)printer
{
    NSLog(@"willConnect");
}

- (void)didConnect:(BXPrinterController *)controller
printer:(BXPrinter *)printer
{
    NSLog(@"didConnect");
    
    NSLog(@"=========== Information Printing Start  ===========\r\n");
    NSLog(@" * printer modelStr : %@ \r\n", printer.modelStr);
    NSLog(@" * printer address : %@ \r\n", printer.address);
    NSLog(@" * printer macAddress : %@ \r\n", printer.macAddress);
    NSLog(@"=========== Information Printing Finish ===========\r\n");
}

- (void)didNotConnect:(BXPrinterController *)controller
printer:(BXPrinter *)printer
withError:(NSError *)error
{
    NSLog(@"didNotConnect");
}

- (void)didDisconnect:(BXPrinterController *)controller
printer:(BXPrinter *)printer
{
    NSLog(@"didDisconnect");
}

- (void)didBeBrokenConnection:(BXPrinterController *)controller
printer:(BXPrinter *)printer
withError:(NSError *)error
{
    NSLog(@"didBeBrokenConnection");
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
        NSLog(@"printing");
        _pController.textEncoding = 0x0C;
        _pController.characterSet = 16;
        [_pController printText:text];
        [_pController printText:@"\r\n"];
        [_pController printText:@"\r\n"];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:text];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end