//
//  VONConstants.m
//  ULike
//
//  Created by Duri Abdurahman Duri on 7/9/14.
//  Copyright (c) 2014 Duri. All rights reserved.
//

#import "VONConstants.h"

@implementation VONConstants

#pragma mark - User Class Details
NSString *const kVONUserTagLineKey = @"tagLine";

NSString *const kVONUserProfileKey                      = @"profile";
NSString *const kVONUserProfileNameKey                  = @"name";
NSString *const kVONUserProfileFirstNameKey             = @"firstNameKey";
NSString *const kVONUserProfileLocation                 = @"location";
NSString *const kVONUserProfileGender                   = @"gender";
NSString *const kVONUserProfileBirthday                 = @"birthday";
NSString *const kVONUserProfileInterestedIn             = @"interestedIn";
NSString *const kVONUserProfilePictureURL               =@"pictureURL";
NSString *const kVONUserProfileRelationshipStatusKey    = @"relationshipStatus";
NSString *const kVONUserProfileAgeKey                   = @"age";

#pragma mark - Photo Class
NSString *const kVONPhotoClassKey       = @"Photo";
NSString *const kVONPhotoUserKey        = @"user";
NSString *const kVONPhotoPictureKey     = @"image";


#pragma - mark Activity
NSString *const kVONActivityClassKey            = @"Activity";
NSString *const kVONActivityTypeKey             = @"type";
NSString *const kVONActivityFromUserKey         = @"fromUser";
NSString *const kVONActivityToUserKey           = @"toUser";
NSString *const kVONActivityPhotoKey            = @"photo";
NSString *const kVONActivityTypeLikeKey         = @"like";
NSString *const kVONActivityTypeDislikeKey      = @"dislike";


#pragma mark - Settings

NSString *const kVONMenEnabledKey       =@"men";
NSString *const kVONWomenEnabledKey     =@"women";
NSString *const kVONSingleEnabledKey    =@"single";
NSString *const kVONAgeMaxKey           =@"ageMax";


#pragma mark - ChatRoom
NSString *const kVONChatRoomClassKey    = @"ChatRoom";
NSString *const kVONChatRoomUser1Key    = @"user1";
NSString *const kVONChatRoomUser2Key    = @"user2";



#pragma mark - Chat
NSString *const kVONChatClassKey        = @"Chat";
NSString *const kVONChatChatroomKey     = @"chatroom";
NSString *const kVONChatFromUserKey     = @"fromUser";
NSString *const kVONChatToUserKey       = @"toUser";
NSString *const kVONChatTextKey         = @"text";


@end
