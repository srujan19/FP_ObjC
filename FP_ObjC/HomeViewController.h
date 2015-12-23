//
//  HomeViewController.h
//  FP_ObjC
//
//  Created by Srujan Simha Adicharla on 12/20/15.
//  Copyright © 2015 Srujan Simha Adicharla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (strong, atomic) IBOutlet UIBarButtonItem *menu;
- (IBAction) menu:(UIBarButtonItem *)sender;

@end
