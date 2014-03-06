/********* BixolonPlugin.h Cordova Plugin Header *******/

#import <Cordova/CDV.h>
#import "BXPrinterController.h"

@interface BixolonPlugin : CDVPlugin<BXPrinterControlDelegate>
{
    BXPrinterController* _pController;
}

- (void)pluginInitialize;

- (void)printText:(CDVInvokedUrlCommand*)command;

@end