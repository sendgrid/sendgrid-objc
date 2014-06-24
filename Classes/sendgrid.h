//
//  SendGrid.h


#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Email.h"

@interface SendGrid : NSObject

@property (nonatomic, strong) NSString *apiUser;
@property (nonatomic, strong) NSString *apiKey;


+ (instancetype)apiUser:(NSString *)apiUser apiKey:(NSString *)apiKey;
- (id)initWithApiUser:(NSString *)apiUser apiKey:(NSString *)apiKey;
- (void)sendWithWeb:(Email *)email;
- (void)sendWithWeb:(Email *)email successBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock;

@end
