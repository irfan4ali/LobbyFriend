//
//  headerfiles.h
//  LobbyFriend
//
//  Created by Imran on 18/03/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "EventFinderDelegate.h"
//#define mainDelegate  (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define   mainDelegate   (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define EXTRA_PARAMETERS @"&authenticationarr[id]=uwATm9vmwJ&authenticationarr[secret]=E2CU7ZNmbp&authenticationarr[type]=iphone"
#define kServerIp        @"http://173.199.149.70/dev/services/rest/" 

#define TOP_NAV_COLOR           [UIColor colorWithRed:72/255.f green:214/255.f blue:234/255.f alpha:1.0f];
#define TABLE_BG                  [UIColor colorWithRed:244/255.f green:240/255.f blue:239/255.f alpha:1.0f]; 

#define APPURL  @"http://173.199.149.70/dev/services/rest/"
//#define APPURL     @"http://173.199.131.17/dev/services/rest/"
#define appDelegate (EventFinderDelegate *)[[UIApplication sharedApplication] delegate]

#define ANONYMOUS_USER 1
#define AUTHENTICATED_USER 0
#define LOBBYFRIEND_HOTEL 3
#define LOBBYFRIEND_HOTEL_STAFF 4

#define IMAGES_PREPATH   @"http://173.199.149.70/dev/"



@interface headerfiles : NSObject

@end
