//
//  YKRPC_POD_NAMERegisterService.m
//  YKRPC_POD_NAME
//
//  Created by YKRPC_AUTHOR_NAME on YKRPC_CREATE_DATE.
//

#import "YKRPC_POD_NAMERegisterService.h"
#import <YKModuleServiceComponent/YKModuleServiceComponentHeader.h>

@interface YKRPC_POD_NAMERegisterService()<YKModuleServiceRegisterProtocol, SUAdvertisementServiceProtocol>
@end
@implementation SUAdvertisementServiceRegister

+ (void)ykModuleServiceRegistAction {
    YKModuleServiceRegisterExecute(SUAdvertisementServiceRegister.class, @protocol(SUAdvertisementServiceProtocol), nil);
}

@end

#pragma mark -  xxxxServiceProtocol method
// @interface YKRPC_POD_NAMERegisterService(serProtocol)<xxxxServiceProtocol>
// +(void)xxxxAction {
// // service execute code
//
// }
// @end
