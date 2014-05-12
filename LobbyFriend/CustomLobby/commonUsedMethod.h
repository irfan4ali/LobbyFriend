//
//  commonUsedMethod.h
//  LobbyFriend
//
//  Created by Imran on 10/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface commonUsedMethod : NSObject



/// Cookies
+ (void)clearCookiesForServer:(NSURL *)_url;
+(NSString *)getOccupationString: (User *)_user;
+ (int)getSelectedLobbyTab;
+(void) addRadiusToView:(UIView *)imageView;
+(NSString *) attachPreImageURL:(NSString  *)imageProfile;
+(UIImage *) getPlaceHolderUser:(User *)_user;


@end
