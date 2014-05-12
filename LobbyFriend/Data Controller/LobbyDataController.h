//
//  LobbyDataController.h
//  LobbyFriend
//
//  Created by Imran on 13/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lobby.h"

@interface LobbyDataController : NSObject

+ (LobbyDataController *)getLobbyInstance;

@property (nonatomic, retain) Lobby *cityLobby,*hotelLobby;
- (void)addDataOfLobby: (Lobby *)_lobby;
- (Lobby *)getDataOfLobby;

@end
