//
//  HomeViewController.m
//  FP_ObjC
//
//  Created by Srujan Simha Adicharla on 12/20/15.
//  Copyright © 2015 Srujan Simha Adicharla. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize menu;

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    }
}

-(IBAction) menu:(UIBarButtonItem *)sender {
    [self.revealViewController revealToggleAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
