//
//  LanguageChanged.h
//  LobbyFriend
//
//  Created by Imran on 25/03/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageChanged : NSObject
{
}
+(LanguageChanged*)languageInstance;
-(NSString *)stringForLoginPage: (NSString *)_text;
-(NSString *) stringForAlertView:(NSString *)_text;
-(UIImage *)getLanguageIcon: (NSString *)_text;
- (NSString *)stringForSignUpPage:(NSString *)_text;
- (NSString *)stringForGeneralLabel:(NSString *)_text;
- (UIColor *)getTableBG;
@end
