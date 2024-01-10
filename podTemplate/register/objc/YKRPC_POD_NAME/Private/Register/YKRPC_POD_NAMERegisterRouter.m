//
//  YKRPC_POD_NAMERegisterRouter.m
//  YKRPC_POD_NAME
//
//  Created by YKRPC_AUTHOR_NAME on YKRPC_CREATE_DATE.
//

#import "YKRPC_POD_NAMERegisterRouter.h"
#import <YKRouterComponent/YKRouterComponentHeader.h>

@interface YKRPC_POD_NAMERegisterRouter()<YKRouterComponentRegisterProtocol>

@end

@implementation YKRPC_POD_NAMERegisterRouter

+ (void)ykRouterRegisterExecute {
    [[YKRouterComponent shareInstance] ykRegisterUrlPartterns:@"XXXRouterStr" error:nil action:^(YKRouterUrlRequest * _Nonnull urlRequest, YKRouterUrlCompletion  _Nonnull completetion) {
//         xxxVC *vc = [[xxxVC alloc] init];
//         UIViewController *topVC = urlRequest.fromVC ? urlRequest.fromVC : [UIViewController topController];
//         [topVC.navigationController pushViewController:vc animated:YES];
    }];
}


@end

