//
//  CustomLobby.m
//  LobbyFriend
//
//  Created by Imran on 04/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "CustomLobby.h"
#import "headerfiles.h"

@implementation CustomLobby

static CustomLobby *_shareInstance;

+ (CustomLobby *)customLobbyInstance
{
    @synchronized([CustomLobby class]){
        if (!_shareInstance) {
            [[self alloc] init];
            return _shareInstance;
        }
    }
    return _shareInstance;

}
+ (id)alloc{
    @synchronized([CustomLobby class]){
        _shareInstance = [super alloc];
        return _shareInstance;
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

- (UIColor *)getTopLobbyColor
{

    return TOP_NAV_COLOR;
}
-(UIImage *) getImageOfColor:(UIColor *)_thisColor
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   [_thisColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
