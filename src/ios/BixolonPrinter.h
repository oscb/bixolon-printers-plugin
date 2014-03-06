/********* Echo.h Cordova Plugin Header *******/

#import <Cordova/CDV.h>

@interface BixolonPrinter : CDVPlugin<BXPrinterControlDelegate>

BXPrinterController* _pController;

- (void)pluginInitialize;

- (void)printText:(CDVInvokedUrlCommand*)command;

@end