//
//  RecordNavigationController.m
//  TableTennis
//
//  Created by Luo Shikai on 14-3-13.
//  Copyright (c) 2014年 isnailbook. All rights reserved.
//

#import "RecordNavigationController.h"
#import "RecordViewController.h"

@interface RecordNavigationController ()

@end

@implementation RecordNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Record";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    RecordViewController *recordViewController = [[RecordViewController alloc] initWithNibName:nil bundle:nil];
    
    [self pushViewController:recordViewController animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
