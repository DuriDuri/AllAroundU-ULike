//
//  VONMatchesViewController.m
//  ULike
//
//  Created by Duri Abdurahman Duri on 7/22/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import "VONMatchesViewController.h"
#import "VONChatViewController.h"

@interface VONMatchesViewController () <UITableViewDataSource ,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *availableChatRooms;
@end

@implementation VONMatchesViewController

#pragma mark -Lazy Instantiation

-(NSMutableArray *)availableChatRooms
{
    if (!_availableChatRooms) {
        _availableChatRooms = [[NSMutableArray alloc] init];
    }
    return _availableChatRooms;
}
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
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self updateAvailableChatRooms];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"matchesToChatSegue"]) {
        VONChatViewController *chatVC = segue.destinationViewController;
        NSIndexPath *indexPath = sender;
        chatVC.chatroom = [self.availableChatRooms objectAtIndex:indexPath.row];
    }
}



#pragma MARK - Helper

-(void)updateAvailableChatRooms
{
    PFQuery *query = [PFQuery queryWithClassName:kVONChatRoomClassKey];
    [query whereKey:kVONChatRoomUser1Key equalTo:[PFUser currentUser]];
    
    PFQuery *queryInverse = [PFQuery queryWithClassName:kVONChatRoomClassKey];
    [query whereKey:kVONChatRoomUser2Key equalTo:[PFUser currentUser]];
    
    PFQuery *queryCombined = [PFQuery orQueryWithSubqueries:@[query, queryInverse]];
    
    [queryCombined includeKey:@"chat"];
    [queryCombined includeKey:kVONChatRoomUser1Key];
    [queryCombined includeKey:kVONChatRoomUser2Key];
    [queryCombined findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [self.availableChatRooms removeAllObjects];
            self.availableChatRooms = [objects mutableCopy];
            [self.tableView reloadData];
            
        }
        
    }];
}

#pragma mark - UITableView DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.availableChatRooms count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    PFObject *chatRoom = [self.availableChatRooms objectAtIndex:indexPath.row];
    
    PFUser *likedUser;
    PFUser *currentUser = [PFUser currentUser];
    PFUser *testUser1 = chatRoom[kVONChatRoomUser1Key];
    
    if ([testUser1.objectId isEqual:currentUser.objectId]) {
        likedUser = [chatRoom objectForKey:kVONChatRoomUser2Key];
    } else {
        likedUser = [chatRoom objectForKey:kVONChatRoomUser1Key];
    }
    
    cell.textLabel.text = likedUser[kVONUserProfileKey][kVONUserProfileFirstNameKey];
    cell.detailTextLabel.text = likedUser[kVONUserProfileKey][kVONUserProfileLocation];
   
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    PFQuery *queryForPhoto = [[PFQuery alloc] initWithClassName:kVONPhotoClassKey];
    [queryForPhoto whereKey:kVONPhotoUserKey equalTo:likedUser];
    [queryForPhoto findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] > 0){
            PFObject *photo = objects[0];
            PFFile *pictureFile = photo[kVONPhotoPictureKey];
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                cell.imageView.image = [UIImage imageWithData:data];
                cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
            }];
        }
        
    }];
    
    return cell;
}

#pragma mark - UItableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"matchesToChatSegue" sender:indexPath];
}
@end
