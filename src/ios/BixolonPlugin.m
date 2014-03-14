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
    [_pController selectTarget];
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

//
// Plugin Functions
// 
- (void)connect:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    if( NO==[_pController connect] )
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR: Can't connnect to printer"];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Connection Established"];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)printText:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* text = [command.arguments objectAtIndex:0];
    NSString* alignment = [command.arguments objectAtIndex:1]; // p.32
    NSString* textSize = [command.arguments objectAtIndex:2]; // p.32

    if (text != nil && [text length] > 0) {
        _pController.textEncoding = 0x0C; // Español
        _pController.characterSet = 16; // Español
        pController.alignment = BXL_ALIGNMENT_LEFT;
        pController.textSize = BXL_TS_0WIDTH| BXL_TS_1HEIGHT;
        [_pController printText:text];
        // [_pController printText:@"\r\n"];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:text];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)lineFeed:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    int lines = [command.arguments objectAtIndex:0];
    if (BXL_SUCCESS == [pController lineFeed:lines]) 
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Line Feed Complete"];
    else 
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR: Can't line feed"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)printBitmap:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@”Sample” ofType:@”png”]];
    if (BXL_SUCCESS == [pController printBitmap:path width:BXL_WIDTH_FULL level:1050 ])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Printed Image"];
    else 
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR: Can't print Image"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)cutPaper:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    if(BXL_SUCCESS == [pController cutPaper])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Paper Cut"];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR: Can't cut paper"];
}
@end