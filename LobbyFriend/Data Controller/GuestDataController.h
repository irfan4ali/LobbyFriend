//
//  GuestDataController.h
//  LobbyFriend
//
//  Created by Imran on 12/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Guest.h"

@interface GuestDataController : NSObject

@property (nonatomic,retain) Guest *cityLobby, *hotelLobby;
+ (GuestDataController *)getGuestInstance;

- (void)addDataOfGuest: (Guest *)_guest;
- (Guest *)getDataOfGuest;


@end
