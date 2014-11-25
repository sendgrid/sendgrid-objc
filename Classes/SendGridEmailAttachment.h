//
//  SendGridEmailAttachment.h
//  Pods
//
//  Created by Juan Ant. Garrido Romero on 18/11/14.
//
//

#import <Foundation/Foundation.h>

@interface SendGridEmailAttachment : NSObject

@property (nonatomic, strong) NSData *attachmentData;
@property (nonatomic, strong) NSString *mimeType;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *extension;

@end
