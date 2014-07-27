//
//  VONChatViewController.h
//  ULike
//
//  Created by Duri Abdurahman Duri on 7/22/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import "JSMessagesViewController.h"

@interface VONChatViewController : JSMessagesViewController <JSMessagesViewDataSource, JSMessagesViewDelegate>

@property (strong, nonatomic) PFObject *chatroom;

@end
