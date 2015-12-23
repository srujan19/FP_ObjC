//
//  LoginViewController.m
//  FP_ObjC
//
//  Created by Srujan Simha Adicharla on 12/20/15.
//  Copyright © 2015 Srujan Simha Adicharla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"
#import "SetLockViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize onOffSwitch;
@synthesize loginView;
@synthesize passcode;
@synthesize  fetchedPasscode;

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self checkPasscode] == NO) {
        SetLockViewController *setLock = (SetLockViewController *)[[self storyboard] instantiateViewControllerWithIdentifier:@"SetupLock"];
        [self presentViewController:setLock animated:YES completion:nil];
    }
}

-(IBAction) showPasscode:(UISwitch *)sender {
    
}

-(IBAction)login:(UIButton *)sender {
    
    if ([fetchedPasscode isEqualToString:[self encryptSha1:self.passcode.text]]) {
        HomeViewController *home = (HomeViewController *)[[self storyboard] instantiateViewControllerWithIdentifier:@"HomeVC"];
    }
}

-(BOOL) checkPasscode {
    BOOL status = NO;
    //1
    AppDelegate *appDel = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDel.managedObjectContext;
    NSFetchRequest *fetchReq = [[NSFetchRequest alloc] init];
    [fetchReq setEntity:[NSEntityDescription entityForName:@"MastePasscode" inManagedObjectContext:context]];
    
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchReq error:&error];
    if (result != nil) {
        fetchedPasscode = [result valueForKey:@"passcode"];
        status = YES;
    } else {
        status = NO;
    }
    
    return status;
}



- (NSString *)encryptSha1:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cStr, strlen(cStr), result);
    NSString *s = [NSString  stringWithFormat:
                   @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   result[0], result[1], result[2], result[3], result[4],
                   result[5], result[6], result[7],
                   result[8], result[9], result[10], result[11], result[12],
                   result[13], result[14], result[15],
                   result[16], result[17], result[18], result[19]
                   ];
    
    return s;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
