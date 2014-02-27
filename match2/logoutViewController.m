//
//  logoutViewController.m
//  match2
//
//  Created by Luo Feiheng on 7/12/13.
//  Copyright (c) 2013 junhao. All rights reserved.
//

#import "logoutViewController.h"

@interface logoutViewController ()

@end

@implementation logoutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSegueWithIdentifier:@"logoutOK" sender:self] ;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
