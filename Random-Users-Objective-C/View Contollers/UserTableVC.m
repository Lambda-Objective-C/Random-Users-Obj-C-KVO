//
//  UserTableVC.m
//  Random-Users-Objective-C
//
//  Created by Seschwan on 11/13/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import "UserTableVC.h"
#import "Random_Users_Objective_C-Swift.h"
#import "CESUser.h"
#import "CESDetailVC.h"

@interface UserTableVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray<CESUser *> *users;

@end

@implementation UserTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tableView.delegate = self;
    //self.tableView.dataSource = self;
    
    [CESUserController.sharedController fetchuser:^(NSArray<CESUser *> *user, NSError *error) {
        if (error) {
            NSLog(@"There was an error fetching users: %@", error);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.users = [CESUserController.sharedController CESUsersArray];
            [self.tableView reloadData];
        });
        
    }];
    
   
    
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CESUser *user = [self.users objectAtIndex:indexPath.row];
    
    cell.textLabel.text = user.firstName;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ToUserDetailVC"])
    {
        NSIndexPath *selectedRow = self.tableView.indexPathForSelectedRow;
        CESDetailVC *detailVC = segue.destinationViewController;
        detailVC.user = [self.users objectAtIndex:selectedRow.row];
    }
}

@end
