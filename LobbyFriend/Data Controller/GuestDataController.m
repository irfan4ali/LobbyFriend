//
//  GuestDataController.m
//  LobbyFriend
//
//  Created by Imran on 12/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "GuestDataController.h"

@implementation GuestDataController
@synthesize cityLobby, hotelLobby;
static GuestDataController *_sharedInstance;

+ (GuestDataController *)getGuestInstance
{
    @synchronized([GuestDataController class]){
        if (!_sharedInstance) {
            [[self alloc] init];
            return _sharedInstance;
        }
    
    }
    return _sharedInstance;
}
+(id)alloc
{
    @synchronized([GuestDataController class]){
        _sharedInstance = [super alloc];
        return _sharedInstance;
    }
    return nil;
}
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)addDataOfGuest:(Guest *)_guest{
    if (true) {
        hotelLobby = _guest;
    }else
        cityLobby = _guest;
}
- (Guest *)getDataOfGuest{
    if (true) {
        return hotelLobby;
    }else
        return cityLobby;
    
}

@end
