//
//  commonUsedMethod.m
//  LobbyFriend
//
//  Created by Imran on 10/04/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "commonUsedMethod.h"
#import "headerfiles.h"

@implementation commonUsedMethod



+ (void)clearCookiesForServer:(NSURL *)_url {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [cookieStorage cookiesForURL:_url];
    for (NSHTTPCookie *cookie in cookies) {
        NSLog(@"Deleting cookie for domain: %@", [cookie domain]);
        [cookieStorage deleteCookie:cookie];
    }
}
+(NSString *)getOccupationString:(User *)_user{
    if (_user.occupation.length>0 || _user.employer.length>0) {
        if (_user.occupation.length>0 && _user.employer.length>0) {
            return [NSString stringWithFormat:@"%@-%@",_user.occupation, _user.employer];
        }else
            return _user.occupation.length>0 ? _user.occupation :_user.employer;
        
    }
    return @"";
}
+(int)getSelectedLobbyTab{
    if (true) {
        return 1;
    }else
        return 2;
}
+ (void)addRadiusToView:(UIView *)imageView{
    [[imageView layer] setCornerRadius:4.0f];
    [[imageView layer] setBorderWidth:0.0f];
    [[imageView layer] setMasksToBounds:YES];
    [[imageView layer] setBorderColor:[[UIColor clearColor] CGColor]];
}
+(NSString *) attachPreImageURL:(NSString  *)obj{
    if ([obj rangeOfString:@"http://"].location==NSNotFound)
        return [NSString stringWithFormat:@"%@%@",IMAGES_PREPATH,obj];
    return obj;
    
}
+(UIImage *)getPlaceHolderUser:(User *)_user{
    if ([_user.gender isEqualToString:@"F"]) {
        return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lffemale" ofType:@"png"]];
    }
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lfmale" ofType:@"png"]];
}

@end
