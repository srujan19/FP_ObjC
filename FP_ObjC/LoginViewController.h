//
//  LoginViewController.h
//  FP_ObjC
//
//  Created by Srujan Simha Adicharla on 12/20/15.
//  Copyright © 2015 Srujan Simha Adicharla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, atomic) IBOutlet UITextField *passcode;
@property (strong, atomic) IBOutlet UISwitch *onOffSwitch;
@property (strong, atomic) IBOutlet UIView *loginView;
@property (strong, atomic) NSString *fetchedPasscode;

-(IBAction) showPasscode:(UISwitch *) sender;
-(IBAction) login:(UIButton *) sender;
@end
