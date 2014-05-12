//
//  SignUpViewController.m
//  LobbyFriend
//
//  Created by Imran on 18/03/2014.
//  Copyright (c) 2014 Imran. All rights reserved.
//

#import "SignUpViewController.h"
#import "headerfiles.h"
#import "IQKeyboardManager.h"
#import "LanguageChanged.h"
#import "CustomLobby.h"
#import "SVProgressHUD.h"
#import "LFDataModel.h"
#import "LoginViewController.h"


@interface SignUpViewController ()
{
    UIView *currentFieldView;
}

@end

@implementation SignUpViewController
@synthesize textfieldArray, firstname,lastname,email,username, password;
@synthesize maleSegmentLabel,buttonLabel;
@synthesize labelSemgent,labelTerm,userRegister,genderString;
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
    [super viewDidLoad];
	textfieldArray = [NSArray arrayWithObjects:firstname,lastname,email,username, password, nil];

    [self.navigationController setNavigationBarHidden:NO];
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
 
    UIColor *green = TOP_NAV_COLOR;
   // UIColor *red = [UIColor colorWithRed:rand()/(CGFloat)RAND_MAX green:rand()/(CGFloat)RAND_MAX blue:rand()/(CGFloat)RAND_MAX alpha:1.0];
   //[[UINavigationBar appearance] setTintColor:red];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
   // [self.navigationController.navigationBar setBackgroundColor:red];
    [self.navigationController.navigationBar setBackgroundImage:[self getImageOfColor:green] forBarMetrics:UIBarMetricsDefault];
    maleSegmentLabel.segmentedControlStyle = UISegmentedControlStyleBar;
    labelSemgent.tintColor = green;
    [self.view addSubview:maleSegmentLabel];
    //buttonLabel.tintColor = red;
    buttonLabel.backgroundColor = green;
    textfieldArray = [[NSArray alloc]initWithObjects:firstname,lastname,email,username,password, nil ];
    for (UITextField *textField in self.textfieldArray)
    {
        [textField addPreviousNextDoneOnKeyboardWithTarget:self previousAction:@selector(previousAction:) nextAction:@selector(nextAction:) doneAction:@selector(doneAction:)];
    }
    genderString = @"M";
    genderVal = 0;
    checked = 0;
    genderChecked = 0;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self languageChanged];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)languageChanged{
    self.title = [[LanguageChanged languageInstance] stringForSignUpPage:@"signUpTitle"];
    self.firstname.placeholder = [[LanguageChanged languageInstance] stringForSignUpPage:@"firstNameText"];
    self.lastname.placeholder = [[LanguageChanged languageInstance] stringForSignUpPage:@"lastNameText"];
    self.email.placeholder = [[LanguageChanged languageInstance] stringForSignUpPage:@"theEmailText"];
    self.password.placeholder = [[LanguageChanged languageInstance] stringForSignUpPage:@"passswordText"];
    self.username.placeholder = [[LanguageChanged languageInstance] stringForSignUpPage:@"userNameText"];
    [self.buttonLabel setTitle:[[LanguageChanged languageInstance] stringForSignUpPage:@"registerSignUpButtonText"] forState:UIControlStateNormal];
    [labelSemgent setTitle:[[LanguageChanged languageInstance] stringForGeneralLabel:@"femaleText"] forSegmentAtIndex:1];
    self.labelTerm.text = [[LanguageChanged languageInstance] stringForSignUpPage:@"TCButtonText"];
    


}

- (IBAction)signUpRegister:(id)sender {
    if ([self validateTextFields]==0) {
    
    
    [SVProgressHUD showWithStatus:@"Logging in" maskType:SVProgressHUDMaskTypeGradient];
    [self.view endEditing:YES];
    userRegister = [[NSMutableDictionary alloc] init];
    [userRegister setObject:[NSString stringWithFormat:@"%@",firstname.text] forKey:@"firstname"];
    [userRegister setObject:[NSString stringWithFormat:@"%@",lastname.text] forKey:@"lastname"];
    [userRegister setObject:[NSString stringWithFormat:@"%@",email.text] forKey:@"email"];
    [userRegister setObject:[NSString stringWithFormat:@"%@",genderString] forKey:@"gender"];
    [userRegister setObject:[NSString stringWithFormat:@"%@",username.text] forKey:@"username"];
    [userRegister setObject:[NSString stringWithFormat:@"%@",password.text] forKey:@"password"];
    [userRegister setObject:[NSString stringWithFormat:@"%d",1] forKey:@"auth"];
    //[loginRegister setObject:[NSString stringWithFormat:@"%@",EXTRA_PARAMETERS] forKey:@""];
    
    LFDataModel *data = [[LFDataModel alloc] init];
    //[data loginUser:loginRegister];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [data newUserRegister:userRegister];
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

}

- (IBAction)checkBoxAction:(id)sender {
    if (checked == 0) {
        [self.checkBoxButton setImage:[UIImage imageNamed:@"checkbox-marked.png"] forState:UIControlStateNormal];
        checked =1;
        NSLog(@"Checked %d",checked);
    }
    else
        if (checked == 1) {
            [self.checkBoxButton setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
            checked = 0;
            NSLog(@"checked %d",checked);
        }
}
- (IBAction)maleAndFemaleSelect:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex==0) {
        genderVal = 0;
        genderString = @"M";
    }else{
        genderVal = 1;
        genderString = @"F";
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
    if (![self validateEmailWithString:self.email.text]) {
        //[mainDelegate showAlertMessage:@"invalidEmailText"];
        [mainDelegate showAlertMessage:[[LanguageChanged languageInstance] stringForAlertView:@"invalidEmailText"]];
        return 1;
    }
    if (checked==0) {
        //[mainDelegate showAlertMessage:@"agreeTermConditionText"];
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
- (BOOL)validateEmailWithString:(NSString *)email
{
    NSString *regularExp = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailMatch = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regularExp];
    return [emailMatch evaluateWithObject:email];
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
    [firstname resignFirstResponder];
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
