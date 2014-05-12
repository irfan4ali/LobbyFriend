//
//  EventNavController.h
//  LobbyFriend
//
//  Created by Imran on 05/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventNavController : UINavigationController
{
    UIViewController *fakeRootViewController;
}
@property (strong, nonatomic) UIViewController *fakeRootViewController;
- (void)setRootViewController:(UIViewController *)rootViewController;

@end
