//
//  email.h
//  sendgrid-ios-demo
//
//  Created by Heitor Sergent on 6/23/14.
//  Copyright (c) 2014 heitortsergent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Email : NSObject

@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *to;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *html;
@property (nonatomic, strong) NSString *xsmtpapi;
@property (nonatomic, strong) NSString *bcc;
@property (nonatomic, strong) NSMutableArray *imgs;
@property (nonatomic, strong) NSArray *toList;
@property (nonatomic, strong) NSString *toName;
@property (nonatomic, strong) NSString *fromName;
@property (nonatomic, strong) NSString *replyTo;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) BOOL inlinePhoto;

- (void)attachImage:(UIImage *)img;
- (NSDictionary *)parametersDictionary:(NSString *)apiUser apiKey:(NSString *)apiKey;

@end
