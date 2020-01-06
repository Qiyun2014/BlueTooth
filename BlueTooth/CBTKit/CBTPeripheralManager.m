//
//  CBTPeripheralManager.m
//  BlueTooth
//
//  Created by yryz on 2020/1/6.
//  Copyright © 2020 com.yryz.qiyun. All rights reserved.
//

#import "CBTPeripheralManager.h"

@interface CBTPeripheralManager () <CBPeripheralManagerDelegate>

@end

@implementation CBTPeripheralManager

- (CBPeripheralManager *)peripheralManager {
    if (!_peripheralManager) {
        // CBPeripheralManagerOptionShowPowerAlertKey: 系统检测，当外设关闭时t提供给用户警告信息
        // CBPeripheralManagerOptionRestoreIdentifierKey: @"uuid-xxxx"
        NSDictionary *peripheralOptions = @{CBPeripheralManagerOptionShowPowerAlertKey: @true};
        _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:peripheralOptions];
    }
    return _peripheralManager;
}


#pragma mark    -   CBPeripheralManagerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    
}



- (void)peripheralManager:(CBPeripheralManager *)peripheral willRestoreState:(NSDictionary<NSString *, id> *)dict {
    
}


- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(nullable NSError *)error {
    
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(nullable NSError *)error {
    
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic {
    
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic {
    
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request {
    
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray<CBATTRequest *> *)requests {
    
}


- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral {
    
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral didPublishL2CAPChannel:(CBL2CAPPSM)PSM error:(nullable NSError *)error {
    
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral didUnpublishL2CAPChannel:(CBL2CAPPSM)PSM error:(nullable NSError *)error {
    
}


- (void)peripheralManager:(CBPeripheralManager *)peripheral didOpenL2CAPChannel:(nullable CBL2CAPChannel *)channel error:(nullable NSError *)error {
    
}


@end
