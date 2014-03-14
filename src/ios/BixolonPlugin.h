/********* BixolonPlugin.h Cordova Plugin Header *******/

#import <Cordova/CDV.h>
#import "BXPrinterController.h"

@interface BixolonPlugin : CDVPlugin<BXPrinterControlDelegate>
{
    BXPrinterController* _pController;
}

- (void)pluginInitialize;

- (void)willLookupPrinters:(BXPrinterController *)controller;
- (void)didLookupPrinters:(BXPrinterController *)controller;
- (void)willConnect:(BXPrinterController *)controller printer:(BXPrinter *)printer;
- (void)didConnect:(BXPrinterController *)controller printer:(BXPrinter *)printer;
- (void)didNotConnect:(BXPrinterController *)controller printer:(BXPrinter *)printer withError:(NSError *)error;
- (void)didDisconnect:(BXPrinterController *)controller printer:(BXPrinter *)printer;
- (void)didBeBrokenConnection:(BXPrinterController *)controller printer:(BXPrinter *)printer withError:(NSError *)error;
- (void)didFindPrinter:(BXPrinterController *)controller printer:(BXPrinter *)printer;

- (void)connect:(CDVInvokedUrlCommand*)command;
- (void)disconnect:(CDVInvokedUrlCommand*)command;
- (void)printText:(CDVInvokedUrlCommand*)command;
- (void)lineFeed:(CDVInvokedUrlCommand*)command;
- (void)printBitmap:(CDVInvokedUrlCommand*)command;
- (void)cutPaper:(CDVInvokedUrlCommand*)command;


@end