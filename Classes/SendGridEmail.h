//
//  SendGridEmail.h
//  sendgrid-ios-demo
//
//  Created by Heitor Sergent on 6/23/14.
//  Copyright (c) 2014 heitortsergent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 
#import "SMTPAPI.h"
#import "SendGridEmailAttachment.h"

@interface SendGridEmail : NSObject

@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *to;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *html;
@property (nonatomic, strong) NSString *xsmtpapi;
@property (nonatomic, strong) NSMutableArray *bcc;
@property (nonatomic, strong) NSMutableArray *imgs;
@property (nonatomic, strong) NSMutableArray *attachments;
@property (nonatomic, strong) NSString *toName;
@property (nonatomic, strong) NSString *fromName;
@property (nonatomic, strong) NSString *replyTo;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) BOOL inlinePhoto;
@property (nonatomic, strong) SMTPAPI *smtpapi;

- (SendGridEmail *)addTo:(NSString *)to;
- (SendGridEmail *)setTos:(NSMutableArray *)tos;
- (SendGridEmail *)addBcc:(NSString *)bcc;
- (SendGridEmail *)addSubstitution:(NSString *)key val:(NSString *)val;
- (SendGridEmail *)addUniqueArg:(NSString *)key val:(NSString *)val;
- (SendGridEmail *)addCategory:(NSString *)category;
- (SendGridEmail *)addSection:(NSString *)key val:(NSString *)val;
- (SendGridEmail *)addFilter:(NSString *)filterName parameterName:(NSString *)parameterName parameterValue:(NSString *)parameterValue;
- (SendGridEmail *)addFilter:(NSString *)filterName parameterName:(NSString *)parameterName parameterIntValue:(int)parameterIntValue;

- (void)attachImage:(UIImage *)img;
- (void)attachFile:(SendGridEmailAttachment *)attachment;
- (NSDictionary *)parametersDictionary:(NSString *)apiUser apiKey:(NSString *)apiKey;

@end
