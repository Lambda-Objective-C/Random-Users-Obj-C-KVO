//
//  CESDetailVC.m
//  Random-Users-Objective-C
//
//  Created by Seschwan on 11/13/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import "CESDetailVC.h"
#import "CESUser.h"
#import "Random_Users_Objective_C-Swift.h"

void *KVOContext = &KVOContext;

@interface CESDetailVC ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userPhone;
@property (weak, nonatomic) IBOutlet UILabel *userEmail;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *downLoadBtn;

//@property (nonatomic) CESUser *user;

@end

@implementation CESDetailVC



- (void)viewDidLoad {
    [super viewDidLoad];
    //self.user = [[CESUser alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self updateViews];

}


- (void)updateViews
{
    if (self.user)
    {
        self.userName.text = [NSString stringWithFormat:@" %@ %@", [self.user firstName], [self.user lastName]]; //Adding first and last name. 
        self.userEmail.text = [self.user email];
        self.userPhone.text = [self.user phone];
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[self.user image]]];
        self.userImageView.image = [UIImage imageWithData:imageData];
        
        NSLog(@"\nImage info: %@\n\n", [self.user image]);
    }
}

#pragma mark - kvoUpdateViews
- (void)kvoUpdateViews
{
    if (self.user)
    {
        //[self updateViews];
        self.userName.text = [NSString stringWithFormat:@" %@ %@", [self.user firstName], [self.user lastName]];
        self.userEmail.text = [self.user KVOEmail];
        self.userPhone.text = [self.user KVOPhone];
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[self.user KVOImage]]];
        self.userImageView.image = [UIImage imageWithData:imageData];
        
        NSLog(@"\n\n\nImage info: %@\n\n", [self.user image]);
    }
    
    
}



- (IBAction)downLoadBtnPressed:(UIBarButtonItem*)sender {
    self.user.KVOPhone = self.user.phone;
    self.user.KVOEmail = self.user.email;
    self.user.KVOImage = self.user.image;
    NSLog(@"KVO After button press:\n %@\n, %@\n, %@\n", self.user.KVOPhone, self.user.KVOEmail, self.user.KVOImage);
    
}

- (IBAction)trashBtnPressed:(UIBarButtonItem*)sender {
    self.user.KVOPhone = nil;
    self.user.KVOEmail = nil;
    self.user.KVOImage = nil;
    

}



- (void)setUser:(CESUser *)user
{
    if (user != _user)
    {
        //[_user removeObserver:self forKeyPath:@"firstName" context:KVOContext];
        //[_user removeObserver:self forKeyPath:@"lastName" context:KVOContext];
        [_user removeObserver:self forKeyPath:@"KVOPhone" context:KVOContext];
        [_user removeObserver:self forKeyPath:@"KVOEmail" context:KVOContext];
        [_user removeObserver:self forKeyPath:@"KVOImage" context:KVOContext];

        NSLog(@"\n\n\nUser info in setUser BEFORE: %@\n\n\n", self.user);

        _user = user;

        //[_user addObserver:self forKeyPath:@"firstName" options:NSKeyValueObservingOptionInitial context:KVOContext];
        //[_user addObserver:self forKeyPath:@"lastName" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_user addObserver:self forKeyPath:@"KVOPhone" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_user addObserver:self forKeyPath:@"KVOEmail" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_user addObserver:self forKeyPath:@"KVOImage" options:NSKeyValueObservingOptionInitial context:KVOContext];
        
        NSLog(@"\n\n\nUser info in setUser AFTER: %@\n\n\n", self.user);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == KVOContext)
    {
        [self kvoUpdateViews];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc
{
    self.user = nil;
}


@end
