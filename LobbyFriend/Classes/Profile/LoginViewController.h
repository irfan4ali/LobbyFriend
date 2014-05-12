//
//  LoginViewController.h
//  LobbyFriend
//
//  Created by Imran on 18/03/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    int checked;
}

@property (strong, nonatomic) SignUpViewController *signupVC;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) NSArray *textfieldArray;

@property (strong, nonatomic) IBOutlet UIButton *checkbox;
@property (strong, nonatomic) IBOutlet UIButton *loginLabel;
    // label connection
@property (strong, nonatomic) IBOutlet UIButton *labelEnglish;
@property (strong, nonatomic) IBOutlet UIButton *labelDutch;
@property (strong, nonatomic) IBOutlet UILabel *labelRemember;
@property (strong, nonatomic) IBOutlet UIButton *labelSignUp;
@property (strong, nonatomic) IBOutlet UIButton *labelForgot;
@property (strong, nonatomic) IBOutlet UIButton *labelLogin;
@property (strong, nonatomic) IBOutlet UIButton *labelFb;
@property (strong, nonatomic) IBOutlet UIButton *labelTwitter;

@property (strong, nonatomic) NSMutableDictionary *loginRegister;



- (IBAction)languageChanged:(UIButton *)sender;

- (IBAction)loginButton:(id)sender;
- (IBAction)signUp:(id)sender;
- (IBAction)forgotPassword:(id)sender;
- (IBAction)checkBoxAction:(id)sender;

//- (BOOL)validateTextFields;
- (BOOL)validateEmailWithString:(NSString *)email;
- (NSInteger)validateTextFields;

- (void)displayLanguage;

@end
