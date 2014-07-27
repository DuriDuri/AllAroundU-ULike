//
//  VONTestUser.m
//  ULike
//
//  Created by Duri Abdurahman Duri on 7/21/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import "VONTestUser.h"

@implementation VONTestUser

+(void)saveTestUserToParse
{
    PFUser *newUser = [PFUser user];
    newUser.username = @"user1";
    newUser.password = @"password1";
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSDictionary *profile = @{@"age" :          @28,
                                      @"birthday" :     @"11/22/1985",
                                      @"firstName" :    @"Julie",
                                      @"gender" :       @"female",
                                      @"location" :     @"Berlin, Germany",
                                      @"name" :         @"Julie Adams"};
            
            [newUser setObject:profile forKey:@"profile"];
            [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                UIImage *profileImage = [UIImage imageNamed:@"astronaut.jpg"];
                NSData *imageData = UIImageJPEGRepresentation(profileImage, 0.8);
                
                PFFile *photoFile  = [PFFile fileWithData:imageData];
                [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        PFObject *photo = [PFObject objectWithClassName:kVONPhotoClassKey];
                        [photo setObject:newUser forKey:kVONPhotoUserKey];
                        [photo setObject:photoFile forKey:kVONPhotoPictureKey];
                        [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            NSLog(@"Photo Saved successfully");
                        }];
                    }
                }];
            }];
        }
    }];
}
@end
