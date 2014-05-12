//
//  EventNavController.m
//  LobbyFriend
//
//  Created by Imran on 05/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "EventNavController.h"
#import "LanguageChanged.h"
#import "headerfiles.h"

@interface EventNavController ()

@end

@implementation EventNavController
@synthesize fakeRootViewController;

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    UIViewController *fakeController = [[UIViewController alloc] init];
    if (self== [super initWithRootViewController:fakeController]) {
        self.fakeRootViewController = fakeController;
        
        rootViewController.navigationItem.hidesBackButton = NO;
        [self pushViewController:rootViewController animated:NO];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//[self.navigationController.navigationBar setTintColor:TOP_NAV_COLOR];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setRootViewController:(UIViewController *)rootViewController
{
    [super setViewControllers:[NSArray arrayWithObject:rootViewController]];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    return [self popToViewController:[self.viewControllers objectAtIndex:0] animated:animated];
}
@end
