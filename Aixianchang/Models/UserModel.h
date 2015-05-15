//
//  User.h
//  Aixianchang
//
//  Created by zhangliugang on 14/12/29.
//  Copyright (c) 2014年 Caonima. All rights reserved.
//

#import <Mantle.h>

typedef enum {
    UserSexMale,
    UserSexFemale
}UserSex;

typedef enum {
    UserTypeNormal = 1,
    UserTypeWriter = 2,
    UserTypeOrgnize = 3
}UserType;

typedef enum {
    UserStatusOpen = 1,
    UserStatusClose = 2
}UserStatus;

@interface UserModel : MTLModel <MTLJSONSerializing>
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *wechatcode;
@property (strong, nonatomic) NSString *openId;
@property (strong, nonatomic) NSString *imei;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *orgName;
@property (assign, nonatomic) UserSex sex;
@property (strong, nonatomic) NSDate *birthday;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSURL *picture;
@property (strong, nonatomic) NSString *signature;
@property (strong, nonatomic) NSString *completion;
@property (strong, nonatomic) NSString *level;
@property (strong, nonatomic) NSString *score;
@property (strong, nonatomic) NSString *scoreLeft;
@property (assign, nonatomic) UserType type; //1-一般用户,2-签约写手,3-组织
@property (assign, nonatomic) UserStatus status;//1-启用,2-禁用
@property (strong, nonatomic) NSDate *lastUserTime;
@end


@interface UserModel (Encode)
- (BOOL)saveToApplicationDocument;
+ (UserModel*)readFromApplicationDocument;
+ (void)clearArchivedUser;
@end