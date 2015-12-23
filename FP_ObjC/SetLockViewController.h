//
//  SetLockViewController.h
//  FP_ObjC
//
//  Created by Srujan Simha Adicharla on 12/17/15.
//  Copyright © 2015 Srujan Simha Adicharla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetLockViewController : UIViewController 

@property (strong, atomic) IBOutlet UITextField *passcode;
@property (strong, atomic) IBOutlet UITextField *hint;
@property (strong, atomic) IBOutlet UIView *loginView;
@property (strong, atomic) IBOutlet UIButton *numLock;
@property (strong, atomic) IBOutlet UIButton *createBtn;
@property (strong, atomic) IBOutlet UISwitch *switchOnOff;
@property (strong, atomic) IBOutlet UIToolbar *numberToolbar;

-(IBAction) createLocker:(UIButton *) sender;
-(IBAction) numberLock:(UIButton *) sender;
-(IBAction) showPasscode:(UISwitch *) sender;
- (NSString *) encryptSha1: (NSString *) str;
@end
