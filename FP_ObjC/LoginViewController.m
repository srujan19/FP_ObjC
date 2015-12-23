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
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "SetLockViewController.h"

@interface LoginViewController () <UITextFieldDelegate> {
    
}

@end

@implementation LoginViewController

@synthesize onOffSwitch;
@synthesize loginView;
@synthesize passcode;
@synthesize  fetchedPasscode;
@synthesize authenticate;
@synthesize errorLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialViewSettings];
}

- (void) initialViewSettings {
    UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapView.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapView];
    [self.loginView addGestureRecognizer:tapView];
    
    self.loginView.layer.cornerRadius = 10.0;
    self.loginView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.loginView.layer.shadowRadius = 10.0;
    self.loginView.layer.shadowOpacity = 10.0;
    self.loginView.layer.shadowOffset = CGSizeZero;
    self.loginView.layer.masksToBounds = false;
    
    self.authenticate.layer.cornerRadius = 5.0;
    self.authenticate.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.passcode.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.passcode.delegate = self;
    
    CATransition *transition = nil;
    transition = [CATransition animation];
    transition.duration = 1;//kAnimationDuration
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromTop ;
    transition.delegate = self;
    [loginView.layer addAnimation:transition forKey:nil];
    
    [UIView animateWithDuration:1.0 delay:1.0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
    } completion:nil];
}

-(IBAction) showPasscode:(UISwitch *)sender {
    if (self.onOffSwitch.on == YES) {
        self.passcode.secureTextEntry = NO;
    } else {
        self.passcode.secureTextEntry = YES;
    }
}

-(IBAction)login:(UIButton *)sender {
    NSLog(@" fetchedPasscode %@", fetchedPasscode);
    if ([self checkPasscode] == YES) {
        SWRevealViewController *home = (SWRevealViewController *)[[self storyboard] instantiateViewControllerWithIdentifier:@"SWRevealVC"];
        [self presentViewController:home animated:YES completion:nil];
    } else {
        self.errorLabel.text = [NSString stringWithFormat:@"Incorrect Password!"];
    }
}

-(BOOL) checkPasscode {
    //1
    AppDelegate *appDel = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDel.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"MasterPasscode" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects) {
        fetchedPasscode = [info valueForKey:@"passcode"];
    }
    
    if ([fetchedPasscode isEqualToString:self.passcode.text]) {
        return YES;
    }
    return NO;
}

- (void) hideKeyboard {
    [self.passcode resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField.returnKeyType == UIReturnKeyDone) {
        [self.passcode resignFirstResponder];
    }
    return YES;
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
