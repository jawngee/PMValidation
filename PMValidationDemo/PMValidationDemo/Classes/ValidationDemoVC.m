//
//  ValidationDemoVC.m
//  PMValidationDemo
//
//  Created by Brett Walker on 11/20/12.
//  Copyright (c) 2012 Poet & Mountain, LLC. All rights reserved.
//

#import "ValidationDemoVC.h"
#import "ValidationUnitStatusIndicatorVC.h"
#import "PMValidationManager.h"
#import "PMValidationUnit.h"
#import "PMValidationEmailType.h"
#import "PMValidationLengthType.h"
#import "PMValidationUITextCompareType.h"
#import "PMValidationRegexType.h"

@interface ValidationDemoVC ()


@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *userNameLabel;
@property (nonatomic, retain) UILabel *emailLabel;
@property (nonatomic, retain) UILabel *passwordLabel;
@property (nonatomic, retain) UILabel *retypeLabel;

@property (nonatomic, retain) UITextField *userNameText;
@property (nonatomic, retain) UITextField *emailText;
@property (nonatomic, retain) UITextField *passwordText;
@property (nonatomic, retain) UITextField *retypeText;

@property (nonatomic, retain) PMValidationManager *validationManager;
@property (nonatomic, retain) ValidationUnitStatusIndicatorVC *userNameStatus;
@property (nonatomic, retain) ValidationUnitStatusIndicatorVC *emailStatus;
@property (nonatomic, retain) ValidationUnitStatusIndicatorVC *passwordStatus;
@property (nonatomic, retain) ValidationUnitStatusIndicatorVC *retypeStatus;

@property (nonatomic, retain) UIButton *submitButton;


- (void)setupUI;
- (void)registerValidators;
- (void)doneEditing:(id)sender;



@end

@implementation ValidationDemoVC

@synthesize validationManager;
@synthesize titleLabel;
@synthesize userNameLabel;
@synthesize emailLabel;
@synthesize passwordLabel;
@synthesize retypeLabel;
@synthesize userNameText;
@synthesize emailText;
@synthesize passwordText;
@synthesize retypeText;
@synthesize userNameStatus;
@synthesize emailStatus;
@synthesize passwordStatus;
@synthesize retypeStatus;
@synthesize submitButton;



- (void)viewDidLoad {
    [super viewDidLoad];


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupUI];
    
    [self registerValidators];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [titleLabel release];
    [userNameLabel release];
    [emailLabel release];
    [passwordLabel release];
    [retypeLabel release];
    [userNameText release];
    [passwordText release];
    [retypeText release];
    [emailText release];
    [userNameStatus release];
    [emailStatus release];
    [passwordStatus release];
    [retypeStatus release];
    [submitButton release];
    [validationManager release];
    
    [super dealloc];
    
}






- (void)setupUI {
    
    
    CGFloat currx = 10;
    CGFloat curry = 10;
    CGFloat view_width = self.view.frame.size.width - (currx*2);
    CGFloat label_width = 110;
    CGFloat status_width = 30;
    CGFloat input_x = currx + label_width + 10;
    CGFloat input_width = view_width - input_x - status_width;
    CGFloat status_x = input_x + input_width + 5;
    
    // title
    CGFloat title_x = currx + (view_width/2) - (200/2);
    CGRect title_frame = CGRectMake(title_x, curry, 200, 40);
    self.titleLabel = [[[UILabel alloc] initWithFrame:title_frame] autorelease];
    self.titleLabel.textAlignment = UITextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = @"Registration";
    [self.view addSubview:self.titleLabel];
    
    curry += 60;
    
    // login name
    CGRect loginlabel_frame = CGRectMake(currx, curry, label_width, 30);
    self.userNameLabel = [[[UILabel alloc] initWithFrame:loginlabel_frame] autorelease];
    self.userNameLabel.text = @"Username";
    self.userNameLabel.backgroundColor = [UIColor clearColor];
    self.userNameLabel.textAlignment = UITextAlignmentRight;
    self.userNameLabel.contentMode = UIViewContentModeBottomRight;
    [self.view addSubview:self.userNameLabel];
    
    CGRect logininput_frame = CGRectMake(input_x, curry, input_width, 30);
    self.userNameText = [[[UITextField alloc] initWithFrame:logininput_frame] autorelease];
    self.userNameText.borderStyle = UITextBorderStyleRoundedRect;
    self.userNameText.autocorrectionType = UITextAutocorrectionTypeNo;
    self.userNameText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.userNameText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.userNameText.keyboardType = UIKeyboardTypeDefault;
    self.userNameText.returnKeyType = UIReturnKeyNext;
    self.userNameText.delegate = self;
    self.userNameText.tag = 9000;
    [self.view addSubview:self.userNameText];
    
    self.userNameStatus = [[[ValidationUnitStatusIndicatorVC alloc] init] autorelease];
    CGRect loginstatus_frame = CGRectMake(status_x, curry, self.userNameStatus.indicatorIcon.frame.size.width, self.userNameStatus.indicatorIcon.frame.size.height);
    self.userNameStatus.view.frame = loginstatus_frame;
    [self.view addSubview:self.userNameStatus.view];
    
    
    
    curry += 40;
    
    // e-mail
    CGRect emaillabel_frame = CGRectMake(currx, curry, label_width, 30);
    self.emailLabel = [[[UILabel alloc] initWithFrame:emaillabel_frame] autorelease];
    self.emailLabel.text = @"Email";
    self.emailLabel.backgroundColor = [UIColor clearColor];
    self.emailLabel.textAlignment = UITextAlignmentRight;
    [self.view addSubview:self.emailLabel];
    
    CGRect emailinput_frame = CGRectMake(input_x, curry, input_width, 30);
    self.emailText = [[[UITextField alloc] initWithFrame:emailinput_frame] autorelease];
    self.emailText.borderStyle = UITextBorderStyleRoundedRect;
    self.emailText.autocorrectionType = UITextAutocorrectionTypeNo;
    self.emailText.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.emailText.returnKeyType = UIReturnKeyNext;
    self.emailText.tag = 9002;
    self.emailText.delegate = self;
    [self.view addSubview:self.emailText];
    

    self.emailStatus = [[[ValidationUnitStatusIndicatorVC alloc] init] autorelease];
    CGRect emailstatus_frame = CGRectMake(status_x, curry, self.emailStatus.indicatorIcon.frame.size.width, self.emailStatus.indicatorIcon.frame.size.height);
    self.emailStatus.view.frame = emailstatus_frame;
    [self.view addSubview:self.emailStatus.view];
    
    
    curry += 40;
    
    // password
    CGRect passlabel_frame = CGRectMake(currx, curry, label_width, 30);
    self.passwordLabel = [[[UILabel alloc] initWithFrame:passlabel_frame] autorelease];
    self.passwordLabel.text = @"Password";
    self.passwordLabel.backgroundColor = [UIColor clearColor];
    self.passwordLabel.textAlignment = UITextAlignmentRight;
    [self.view addSubview:self.passwordLabel];
    
    CGRect passinput_frame = CGRectMake(input_x, curry, input_width, 30);
    self.passwordText = [[[UITextField alloc] initWithFrame:passinput_frame] autorelease];
    self.passwordText.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordText.secureTextEntry = YES;
    self.passwordText.clearsOnBeginEditing = NO;
    self.passwordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.passwordText.returnKeyType = UIReturnKeyNext;
    self.passwordText.keyboardType = UIKeyboardTypeDefault;
    self.passwordText.tag = 9003;
    self.passwordText.delegate = self;
    [self.view addSubview:self.passwordText];
    

    self.passwordStatus = [[[ValidationUnitStatusIndicatorVC alloc] init] autorelease];
    CGRect passstatus_frame = CGRectMake(status_x, curry, self.passwordStatus.indicatorIcon.frame.size.width, self.passwordStatus.indicatorIcon.frame.size.height);
    self.passwordStatus.view.frame = passstatus_frame;
    [self.view addSubview:self.passwordStatus.view];
    
    curry += 40;
    
    // password retype
    CGRect retypelabel_frame = CGRectMake(currx, curry, label_width, 30);
    self.retypeLabel = [[[UILabel alloc] initWithFrame:retypelabel_frame] autorelease];
    self.retypeLabel.text = @"Retype";
    self.retypeLabel.backgroundColor = [UIColor clearColor];
    self.retypeLabel.textAlignment = UITextAlignmentRight;
    [self.view addSubview:self.retypeLabel];
    
    CGRect retypeinput_frame = CGRectMake(input_x, curry, input_width, 30);
    self.retypeText = [[[UITextField alloc] initWithFrame:retypeinput_frame] autorelease];
    self.retypeText.borderStyle = UITextBorderStyleRoundedRect;
    self.retypeText.secureTextEntry = YES;
    self.retypeText.clearsOnBeginEditing = NO;
    self.retypeText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.retypeText.returnKeyType = UIReturnKeyDone;
    self.retypeText.keyboardType = UIKeyboardTypeDefault;
    self.retypeText.delegate = self;
    self.retypeText.tag = 9004;
    [self.view addSubview:self.retypeText];
    

    self.retypeStatus = [[[ValidationUnitStatusIndicatorVC alloc] init] autorelease];
    CGRect retypestatus_frame = CGRectMake(status_x, curry, self.retypeStatus.indicatorIcon.frame.size.width, self.retypeStatus.indicatorIcon.frame.size.height);
    self.retypeStatus.view.frame = retypestatus_frame;
    [self.view addSubview:self.retypeStatus.view];
    
    
    
    curry += 50;
    
    // submit button
    CGFloat submit_x = (retypeinput_frame.origin.x + retypeinput_frame.size.width) - 104;
    self.submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.submitButton.frame = CGRectMake(submit_x, curry, 104, 35);
    [self.submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [self.submitButton addTarget:self action:@selector(createUser:) forControlEvents:UIControlEventTouchUpInside];
    self.submitButton.enabled = NO;
    [self.view addSubview:self.submitButton];
    
    
}




- (void) registerValidators {
    
    self.validationManager = [PMValidationManager validationManager];
    
    // username
    PMValidationLengthType *val_login_len = [PMValidationLengthType validator];
    val_login_len.minimumCharacters = 4;
    val_login_len.maximumCharacters = 12;
    PMValidationRegexType *val_login_regex = [PMValidationRegexType validator];
    val_login_regex.regexString = @"^[A-Z0-9a-z]+$"; // only letters and numbers.
    PMValidationUnit *login_unit = [self.validationManager registerTextField:self.userNameText
                                                         forValidationTypes:[NSSet setWithObjects:val_login_len, val_login_regex, nil]
                                                                 identifier:@"login"];
    [self.userNameStatus registerWithValidationUnit:login_unit];
    
    
    // password
    PMValidationLengthType *val_pass_len = [PMValidationLengthType validator];
    val_pass_len.minimumCharacters = 4;
    PMValidationUnit *pass_unit = [self.validationManager registerTextField:self.passwordText
                                                        forValidationTypes:[NSSet setWithObjects:val_pass_len, nil]
                                                                identifier:@"password"];
    [self.passwordStatus registerWithValidationUnit:pass_unit];
    
    
    // retype password
    PMValidationUITextCompareType *val_retype_match = [PMValidationUITextCompareType validator];
    [val_retype_match registerTextFieldToMatch:self.passwordText];
    PMValidationUnit *retype_unit = [self.validationManager registerTextField:self.retypeText
                                                          forValidationTypes:[NSSet setWithObjects:val_retype_match, nil]
                                                                  identifier:@"retype"];
    [self.retypeStatus registerWithValidationUnit:retype_unit];
    
    
    // email
    PMValidationEmailType *val_email = [PMValidationEmailType validator];
    PMValidationUnit *email_unit = [self.validationManager registerTextField:self.emailText
                                                         forValidationTypes:[NSSet setWithObjects:val_email, nil]
                                                                 identifier:@"email"];
    [self.emailStatus registerWithValidationUnit:email_unit];
    
    
    
    // get validation status update
    [[NSNotificationCenter defaultCenter] addObserverForName:PMValidationStatusNotification object:self.validationManager queue:nil usingBlock:
         ^(NSNotification *notification) {
             BOOL is_valid = [(NSNumber *)[notification.userInfo objectForKey:@"status"] boolValue];
             if (is_valid) {
                 self.submitButton.enabled = YES;
             } else {
                 self.submitButton.enabled = NO;
             }
             //NSLog(@"unit dict %@", notification.userInfo);
         }
     ];
    

}



-(void)doneEditing:(id)sender {
	[sender resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.userNameText resignFirstResponder];
	[self.passwordText resignFirstResponder];
	[self.retypeText resignFirstResponder];
	[self.emailText resignFirstResponder];
    
}



#pragma mark -- UITextFieldDelegate methods


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    NSInteger previousTag = textField.tag;
    
    UITextField *next_field = (UITextField *)[self.view viewWithTag:previousTag+1];
    
    if (next_field) {
        [next_field becomeFirstResponder];
        return NO;
    } else {
        return YES;
    }
    
}



@end
