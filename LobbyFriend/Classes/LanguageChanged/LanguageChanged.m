//
//  LanguageChanged.m
//  LobbyFriend
//
//  Created by Imran on 25/03/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "LanguageChanged.h"
#import "headerfiles.h"

@implementation LanguageChanged

static LanguageChanged *_shareInstance;

+(LanguageChanged *)languageInstance{
    @synchronized([LanguageChanged class])
    {
        if(!_shareInstance)
        {
            [[self alloc] init];
            return _shareInstance;
        }
    }
    return  _shareInstance;
    
}
+(id)alloc
{
    @synchronized([LanguageChanged class])
    {
        NSAssert(_shareInstance == nil, @"Attempted for 2nd instance of singlton class");
        _shareInstance = [super alloc];
        return  _shareInstance;
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
- (NSString *)stringForGeneralLabel:(NSString *)_text
{
    NSString *langFile  = [[NSUserDefaults standardUserDefaults] valueForKey:@"lobbyLanguage"];
    NSString *data = NSLocalizedStringFromTable(_text, langFile, @"GENERAL");
    return data;
}
-(NSString *) stringForAlertView:(NSString *)_text
{
    NSString *langFile  = [[NSUserDefaults standardUserDefaults] valueForKey:@"lobbyLanguage"];
    //  NSLog(@"Languagefile:%@",langFile);
    return NSLocalizedStringFromTable(_text, langFile, @"EMAILALERTVIEW");
    
}

- (NSString *)stringForLoginPage:(NSString *)_text
{
    NSString *langFile  = [[NSUserDefaults standardUserDefaults] valueForKey:@"lobbyLanguage"];
    NSString *data = NSLocalizedStringFromTable(_text, langFile, @"SIGNINPAGE");
    return data;
}
- (NSString *)stringForSignUpPage:(NSString *)_text{
    NSString *langFile = [[NSUserDefaults standardUserDefaults] valueForKey:@"lobbyLanguage"];
    NSString *data = NSLocalizedStringFromTable(_text, langFile, @"SIGNUPPAGE");
    return data;
}
- (UIColor *)getTableBG{
    return TABLE_BG;
}
- (UIImage *)getLanguageIcon:(NSString *)_text
{
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"lobbyLanguage"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"english" forKey:@"lobbyLanguage"];
        return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"english_selected" ofType:@"png"]];
    }else if ([_text isEqualToString:@"english"]){
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"lobbyLanguage"] isEqualToString:_text])
            return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"english_selected" ofType:@"png"]];
        else
            return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"english_normal" ofType:@"png"]];
    }else{
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"lobbyLanguage"] isEqualToString:_text]) {
            return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dutch_selected" ofType:@"png"]];
        }else
            return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dutch_normal" ofType:@"png"]];
    }
}

@end
