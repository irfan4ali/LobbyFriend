//
//  CustomLobby.h
//  LobbyFriend
//
//  Created by Imran on 04/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomLobby : NSObject

+ (CustomLobby*)customLobbyInstance;

- (UIColor *)getTopLobbyColor;
-(UIImage *) getImageOfColor:(UIColor *)_thisColor;

@end
