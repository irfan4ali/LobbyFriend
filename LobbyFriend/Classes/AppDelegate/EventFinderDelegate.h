//
//  EventFinderDelegate.h
//  LobbyFriend
//
//  Created by Imran on 05/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventNavController.h"
#import "UserProfileViewController.h"

@interface EventFinderDelegate : NSObject<UIApplicationDelegate, UINavigationControllerDelegate>
{
    EventNavController *navigationController;
    UIWindow           *window;
}
@property (retain, nonatomic) EventNavController *navigationController;

@property (strong,nonatomic)  UserProfileViewController *profile;

- (void)openUserDetails;

@end
