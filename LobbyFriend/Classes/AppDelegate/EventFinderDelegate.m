//
//  EventFinderDelegate.m
//  LobbyFriend
//
//  Created by Imran on 05/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "EventFinderDelegate.h"
#import "EventNavController.h"
#import "UserProfileViewController.h"

@implementation EventFinderDelegate
@synthesize navigationController,profile,window;



- (void)applicationDidFinishLaunching:(UIApplication *)application{

    navigationController = [[EventNavController alloc] init];

}
- (void)openUserDetails
{
    //[navigationController setRootViewController:userProfile];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    profile  = [storyBoard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
    EventNavController *newNav = [[EventNavController alloc] initWithRootViewController:profile];;
    [window setRootViewController:newNav];
    [window makeKeyAndVisible];

   // [self.navigationController presentViewController:profile animated:YES completion:NULL];
    
    
}


@end
