//
//  LobbyDataController.m
//  LobbyFriend
//
//  Created by Imran on 13/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "LobbyDataController.h"

@implementation LobbyDataController
@synthesize cityLobby,hotelLobby;
static LobbyDataController *_sharedInstance;

+ (LobbyDataController *)getLobbyInstance{
    @synchronized([LobbyDataController class]){
        if (!_sharedInstance) {
            [[self alloc] init];
            return _sharedInstance;
        }
    }
    return _sharedInstance;

}
+ (id)alloc{
    @synchronized([LobbyDataController class]){
        _sharedInstance = [super alloc];
        return  _sharedInstance;
    }
    return nil;
}




- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)addDataOfLobby:(Lobby *)_lobby{

    if (true) {
        cityLobby = _lobby;
    }else
        hotelLobby = _lobby;
}
- (Lobby *)getDataOfLobby{
    if (true) {
        return cityLobby;
        
    }else
        return hotelLobby;

}


@end
