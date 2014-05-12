//
//  LoginViewController.m
//  LobbyFriend
//
//  Created by Imran on 18/03/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "LobbyViewController.h"
#import "headerfiles.h"
#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "headerfiles.h"
#import "LanguageChanged.h"
#import "LFDataModel.h"
#import "SVProgressHUD.h"

@interface LoginViewController ()
{
    UIView *currentFieldView;
}
@end

@implementation LoginViewController
@synthesize textfieldArray,username, password;
@synthesize loginRegister;
@synthesize labelDutch,labelEnglish,labelFb,labelForgot,labelLogin,labelRemember,labelSignUp,labelTwitter,loginLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self.navigationController setNavigationBarHidden:YES];
    [super viewDidLoad];
    //////////////////////
    username.text = @"kimme";
    password.text = @"zzz";
    
    
    
    /////////////////////
    //[mainDelegate showAlertMessage:@"Hello"];
    self.title = @"Login";
    //[self.navigationController setNavigationBarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
	checked =0;
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"dark_bg.png"] forBarMetrics:UIBarMetricsDefault];
   UIColor *green = TOP_NAV_COLOR;
    labelLogin.backgroundColor = green;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_bg.png"]];
    textfieldArray = [NSArray arrayWithObjects:username,password, nil];
    for (UITextField *textField in self.textfieldArray)
    {
        [textField addPreviousNextDoneOnKeyboardWithTarget:self previousAction:@selector(previousAction:) nextAction:@selector(nextAction:) doneAction:@selector(doneAction:)];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 
}


-(void)displayLanguage
{
    self.username.placeholder = [[LanguageChanged languageInstance] stringForLoginPage:@"userNameText"];
    self.password.placeholder = [[LanguageChanged languageInstance] stringForLoginPage:@"passswordText"];
    self.labelRemember.text = [[LanguageChanged languageInstance] stringForLoginPage:@"rememberButtonText"];
    [self.labelSignUp setTitle:[[LanguageChanged languageInstance] stringForLoginPage:@"signInText"] forState:UIControlStateNormal];
    [self.labelForgot setTitle:[[LanguageChanged languageInstance] stringForLoginPage:@"forgotText"] forState:UIControlStateNormal];
    [self.labelLogin setTitle:[[LanguageChanged languageInstance] stringForLoginPage:@"loginButtonText"] forState:UIControlStateNormal];
    [self.labelFb setTitle:[[LanguageChanged languageInstance] stringForLoginPage:@"fbButtonText"] forState:UIControlStateNormal];
    [self.labelTwitter setTitle:[[LanguageChanged languageInstance] stringForLoginPage:@"TwitterButtonText"] forState:UIControlStateNormal];
}

- (IBAction)languageChanged:(UIButton *)sender {
    if (sender.tag==1) {
        if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"lobbyLanguage"] isEqualToString:@"english"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"english" forKey:@"lobbyLanguage"];
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else{
       if (sender.tag == 2)
       {
           if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"lobbyLanguage"] isEqualToString:@"dutch"]) {
               [[NSUserDefaults standardUserDefaults] setObject:@"dutch" forKey:@"lobbyLanguage"];
           }
           [[NSUserDefaults standardUserDefaults]  synchronize];
       }
    }
    [self.labelEnglish setImage:[[LanguageChanged languageInstance] getLanguageIcon:@"english"] forState:UIControlStateNormal];
    [self.labelDutch setImage:[[LanguageChanged languageInstance] getLanguageIcon:@"dutch"] forState:UIControlStateNormal];
    [self displayLanguage];
    
}

- (IBAction)loginButton:(id)sender {
    
    if([self validateTextFields]==0){
        
    [SVProgressHUD showWithStatus:@"Logging in" maskType:SVProgressHUDMaskTypeGradient];
    [self.view endEditing:YES];
    loginRegister = [[NSMutableDictionary alloc] init];
    [loginRegister setObject:[NSString stringWithFormat:@"%@",username.text] forKey:@"username"];
    [loginRegister setObject:[NSString stringWithFormat:@"%@",password.text] forKey:@"password"];
    [loginRegister setObject:[NSString stringWithFormat:@"%d",1] forKey:@"auth"];
    //[loginRegister setObject:[NSString stringWithFormat:@"%@",EXTRA_PARAMETERS] forKey:@""];
    
    LFDataModel *data = [[LFDataModel alloc] init];
     //[data loginUser:loginRegister];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [data loginUser:loginRegister];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if(true) {
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                
                LoginViewController *reward = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                [self presentViewController:reward animated:NO completion:NULL];
            }else{
               // some code here
            
            }
        
        
        });
    
    });
    
    }
    
    
   /* //[self performSegueWithIdentifier:@"forgotSugue" sender:nil];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    LoginViewController *reward = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    [self presentViewController:reward animated:NO completion:NULL];*/
}

- (IBAction)signUp:(id)sender {
    BOOL status = [self validateTextFields];
    
}

- (IBAction)forgotPassword:(id)sender {
}

- (IBAction)checkBoxAction:(id)sender {
    if (checked == 0) {
        [self.checkbox setImage:[UIImage imageNamed:@"checkbox-marked.png"] forState:UIControlStateNormal];
        checked =1;
        NSLog(@"Checked %d",checked);
    }
    else
        if (checked == 1) {
            [self.checkbox setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
            checked = 0;
            NSLog(@"checked %d",checked);
        }
}

- (NSInteger)validateTextFields{
    
    NSArray *fields = [NSArray arrayWithArray:self.textfieldArray];
    
    int valFlag = 0;
    for (UITextField *tfield in fields) {
        if ([tfield.text isEqualToString:@""])
        {
            [tfield.layer setBorderWidth:2.0f];
            [tfield.layer setCornerRadius:7.0f];
            [tfield.layer setBorderColor:[[UIColor redColor] CGColor]];
            valFlag++;
        }
    }
   /* if (![self validateEmailWithString:self.email.text]) {
        [mainDelegate showAlertMessage:@"invalidEmailText"];
        return 1;
    }*/
    if (checked==0) {
        //[mainDelegate showAlertMessage:[[LanguageChanged languageInstance ] stri] ]@"agreeTermConditionText"];
        [mainDelegate showAlertMessage:[[LanguageChanged languageInstance] stringForAlertView:@"agreeTermConditionText"]];
        return 1;
    }
    
    if (valFlag > 0)
    {
        //[mainDelegate showAlertMessage:@"enterAllFieldText"];
        [mainDelegate showAlertMessage:[[LanguageChanged languageInstance] stringForAlertView:@"enterAllFieldText"]];
        
        return 1;
    }
    
    return 0;
}
-(void)previousAction:(UISegmentedControl*)segmentedControl
{
	//Getting index of current textField.
	NSInteger index = [self.textfieldArray indexOfObject:currentFieldView]-1;
	
    for (; index>-1; index--)
    {
        UITextField *textField = [self.textfieldArray objectAtIndex:index];
        
        if ([textField canBecomeFirstResponder])
        {
            [textField becomeFirstResponder];
            break;
        }
    }
}

//	Next button action.
-(void)nextAction:(UISegmentedControl*)segmentedControl
{
	//Getting index of current textField.
	NSInteger index = [self.textfieldArray indexOfObject:currentFieldView]+1;
	
    for (; index<self.textfieldArray.count; index++)
    {
        UITextField *textField = [self.textfieldArray objectAtIndex:index];
        
        if ([textField becomeFirstResponder])
        {
            break;
        }
    }
}
-(void)doneAction:(UIBarButtonItem*)barButton
{
    [currentFieldView resignFirstResponder];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentFieldView = textField;
}

@end
