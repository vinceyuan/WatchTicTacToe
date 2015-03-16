//
//  GlanceController.m
//  WatchTicTacToe WatchKit Extension
//
//  Created by Vince Yuan on 4/2/15.
//
//

#import "GlanceController.h"
#import "InterfaceController.h"

@interface GlanceController()

@end


@implementation GlanceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger win = [userDefaults integerForKey:KEY_SELF_WIN_COUNT];
    NSInteger lose = [userDefaults integerForKey:KEY_PC_WIN_COUNT];
    [_labelStat setText:[NSString stringWithFormat:@"💩 %ld  :  %ld 🐷", (long)win, (long)lose]];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



