//
//  YKRPC_POD_NAMERegisterService.swift
//  YKRPC_POD_NAME
//
//  Created by YKRPC_AUTHOR_NAME on YKRPC_CREATE_DATE.
//
import STModuleServiceSwift

private class YKRPC_POD_NAMERegisterService: NSObject, STModuleServiceProtocol {
    static func stModuleServiceRegistAction() {
        //注册服务 NSObject --> NSObjectProtocol   NSObjectProtocol为 swift 协议
//         STModuleService().stRegistModule(YKRPC_POD_NAMERegisterService.self, protocol: NSObjectProtocol.self, err: nil)
    }
}

// extension YKRPC_POD_NAMERegisterService: XXXXProtocol {
// static mehtod for XXXXProtocol
//     static func xxxxx() -> xxxxxObjc {
//         return XXXXX()
//     }
// }