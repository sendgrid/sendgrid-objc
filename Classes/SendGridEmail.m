//
//  SendGridEmail.m
//  sendgrid-ios-demo
//
//  Created by Heitor Sergent on 6/23/14.
//  Copyright (c) 2014 heitortsergent. All rights reserved.
//

#import "SendGridEmail.h"

@implementation SendGridEmail

- (id)init
{
    self = [super init];
    if (self)
    {
        self.html = @"";
        self.smtpapi = [[SMTPAPI alloc] init];
        self.bcc = [[NSMutableArray alloc] init];
        [self setInlinePhoto:false];
    }
    return self;
}

- (SendGridEmail *)addTo:(NSString *)to {
    [self.smtpapi addTo:to];
    return self;
}

- (SendGridEmail *)setTos:(NSMutableArray *)tos {
    [self.smtpapi setTos:tos];
    return self;
}

- (SendGridEmail *)addBcc:(NSString *)bcc {
    [self.bcc addObject:bcc];
    return self;
}

- (SendGridEmail *)addSubstitution:(NSString *)key val:(NSString *)val {
    [self.smtpapi addSubstitution:key val:val];
    return self;
}

- (SendGridEmail *)addUniqueArg:(NSString *)key val:(NSString *)val {
    [self.smtpapi addUniqueArg:key val:val];
    return self;
}

- (SendGridEmail *)addCategory:(NSString *)category {
    [self.smtpapi addCategory:category];
    return self;
}

- (SendGridEmail *)addSection:(NSString *)key val:(NSString *)val {
    [self.smtpapi addSection:key val:val];
    return self;
}

- (SendGridEmail *)addFilter:(NSString *)filterName parameterName:(NSString *)parameterName parameterValue:(NSString *)parameterValue {
    [self.smtpapi addFilter:filterName setting:parameterName val:parameterValue];
    return self;
}

- (SendGridEmail *)addFilter:(NSString *)filterName parameterName:(NSString *)parameterName parameterIntValue:(int)parameterIntValue {
    [self.smtpapi addFilter:filterName settings:parameterName val:parameterIntValue];
    return self;
}

- (void)attachImage:(UIImage *)img
{
    if (self.imgs == NULL)
        self.imgs = [[NSMutableArray alloc] init];
    [self.imgs addObject:img];
}

- (void)attachFile:(SendGridEmailAttachment *)attachment
{
    if (self.attachments == NULL)
        self.attachments = [[NSMutableArray alloc] init];
    [self.attachments addObject:attachment];
}

- (NSDictionary *)parametersDictionary:(NSString *)apiUser apiKey:(NSString *)apiKey
{
    [self.smtpapi configureHeader];
    self.xsmtpapi = [self.smtpapi encodedHeader];
    NSLog(@"%@", self.xsmtpapi);
    
    if (self.html != nil && self.text == nil)
        self.text = self.html;
    
    //must set the "to" parameter even if X-SMTPAPI tos array is set
    if ([self.smtpapi getTos] != nil && [[self.smtpapi getTos] count] > 0 && self.to == nil)
        [self setTo:[[self.smtpapi getTos] objectAtIndex:0]];
    else if (self.to == nil)
        [NSException raise:@"Missing to email value" format:@"to is: %@", self.to];
    
    NSMutableDictionary *parameters =[NSMutableDictionary dictionaryWithDictionary:@{@"api_user": apiUser, @"api_key": apiKey, @"subject":self.subject, @"from":self.from, @"html":self.html,@"to":self.to, @"text":self.text, @"x-smtpapi":self.xsmtpapi}];
    
    //optional parameters
    if (self.bcc != nil)
        [parameters setObject:self.bcc forKey:@"bcc"];
    
    if (self.toName != nil)
        [parameters setObject:self.toName forKey:@"toname"];
    
    if (self.fromName != nil)
        [parameters setObject:self.fromName forKey:@"fromname"];
    
    if (self.replyTo != nil)
        [parameters setObject:self.replyTo forKey:@"replyto"];
    
    if (self.date != nil)
        [parameters setObject:self.date forKey:@"date"];
    
    if (self.inlinePhoto)
    {
        for(int i = 0; i < self.imgs.count; i++)
        {
            
            NSString *filename = [NSString stringWithFormat:@"image%d.png", i];
            NSString *key = [NSString stringWithFormat:@"content[image%d.png]", i];
            NSLog(@"name: %@, Filename: %@", key, filename);
            [parameters setObject:filename forKey:key];
            
        }
    }
    
    return parameters;
}

@end
