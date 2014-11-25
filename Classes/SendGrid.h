//
//  SendGrid.h
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "SendGridEmail.h"
#import "SendGridEmailAttachment.h"

@interface SendGrid : NSObject

@property (nonatomic, strong) NSString *apiUser;
@property (nonatomic, strong) NSString *apiKey;


+ (instancetype)apiUser:(NSString *)apiUser apiKey:(NSString *)apiKey;
- (id)initWithApiUser:(NSString *)apiUser apiKey:(NSString *)apiKey;
- (void)sendWithWeb:(SendGridEmail *)email;
- (void)sendWithWeb:(SendGridEmail *)email successBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock;
- (void)sendAttachmentWithWeb:(SendGridEmail *)email;
- (void)sendAttachmentWithWeb:(SendGridEmail *)email successBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock;


@end
