//
//  SetLockViewController.m
//  FP_ObjC
//
//  Created by Srujan Simha Adicharla on 12/17/15.
//  Copyright © 2015 Srujan Simha Adicharla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "SetLockViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "NSString-Hashes.h"
#import <VENTouchLock/VENTouchLock.h>

@interface SetLockViewController () <UITextFieldDelegate>

@end

@implementation SetLockViewController

@synthesize passcode;
@synthesize hint;
@synthesize loginView;
@synthesize numLock;
@synthesize switchOnOff;
@synthesize createBtn;
@synthesize numberToolbar;

- (void) viewDidLoad {
    [super viewDidLoad];
    self.passcode.delegate = self;
    self.hint.delegate = self;
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
    
    self.createBtn.layer.cornerRadius = 5.0;
    self.createBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.passcode.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.hint.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    self.passcode.delegate = self;
    self.hint.delegate = self;
    
    CATransition *transition = nil;
    transition = [CATransition animation];
    transition.duration = 1;//kAnimationDuration
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromTop ;
    transition.delegate = self;
    [loginView.layer addAnimation:transition forKey:nil];
    
    self.numLock.alpha = 0;
    [UIView animateWithDuration:1.0 delay:1.0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.numLock.alpha = 1.0;
    } completion:nil];
}

- (IBAction)createLocker:(UIButton *) sender {
    AppDelegate *appDel = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDel.managedObjectContext;
    NSManagedObject *entity = [NSEntityDescription insertNewObjectForEntityForName:@"MasterPasscode" inManagedObjectContext:context];
    [entity setValue:[self.passcode.text sha1] forKey:@"passcode"];
    [entity setValue:[self.hint.text sha1] forKey:@"hint"];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        if ([UIAlertController class])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"There is an error in saving your password. Please close and re-open the app." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } else {
        LoginViewController *login = (LoginViewController *) [[self storyboard] instantiateViewControllerWithIdentifier:@"LoginVC"];
        [self presentViewController:login animated:YES completion:nil];
    }
}

- (IBAction)numberLock:(UIButton *) sender {
}

- (IBAction)showPasscode:(UISwitch *) sender {
    if (self.switchOnOff.on == YES) {
        self.passcode.secureTextEntry = NO;
    } else {
        self.passcode.secureTextEntry = YES;
    }
}

- (void) hideKeyboard {
    [self.passcode resignFirstResponder];
    [self.hint resignFirstResponder];
    [[self view] resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField.returnKeyType == UIReturnKeyNext) {
        [self.hint becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
