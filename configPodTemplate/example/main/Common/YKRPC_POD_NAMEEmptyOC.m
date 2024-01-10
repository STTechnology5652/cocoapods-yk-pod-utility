//
//  YKRPC_POD_NAMEEmptyOC.m
//  YKRPC_POD_NAME_Example
//
//  Created by YKPRC_AUTHOR_NAME on YKPRC_CREATE_DATE.
//

#import "YKRPC_POD_NAMEEmptyOC.h"

@implementation YKRPC_POD_NAMEEmptyOC
+ (void)load {
#ifdef kENTERPRISE
    NSLog(@"has kEnterprise:%d", kENTERPRISE);
#else
    NSLog(@"no kEnterprise");
#endif
}
@end
