//
//  SendGrid.h


#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Email.h"

@interface SendGrid : NSObject

@property (nonatomic, strong) NSString *apiUser;
@property (nonatomic, strong) NSString *apiKey;


+ (instancetype)user:(NSString *)apiUser andPass:(NSString *)apiKey;
- (id)initWithUser:(NSString *)apiUser andPass:(NSString *)apiKey;
- (void)sendWithWeb:(Email *)email;
- (void)sendWithWebUsingSuccessBlock:(Email *) email successBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock;

@end
