//
//  ResultController.m
//  WatchTicTacToe
//
//  Created by Vince Yuan on 4/2/15.
//
//

#import "ResultController.h"
#import "InterfaceController.h"


@interface ResultController() {
}

@end


@implementation ResultController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    GameResult result = (GameResult)[(NSNumber *)context[@"result"] intValue];
    if (result == GameResultWin) {
        [_labelResult setText:@"YOU WIN!"];
    } else if (result == GameResultLose) {
        [_labelResult setText:@"YOU LOSE!"];
    } else {
        [_labelResult setText:@"THE END"];
    }
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

- (IBAction)pressButtonRestart {
    [self dismissController];
}

- (IBAction)pressButtonReset {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:0 forKey:KEY_SELF_WIN_COUNT];
    [userDefaults setInteger:0 forKey:KEY_PC_WIN_COUNT];
    [userDefaults synchronize];
    [_labelStat setText:@"💩 0  :  0 🐷"];
}
@end



