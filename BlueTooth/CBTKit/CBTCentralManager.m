//
//  CBTCentralManager.m
//  BlueTooth
//
//  Created by yryz on 2020/1/6.
//  Copyright © 2020 com.yryz.qiyun. All rights reserved.
//

#import "CBTCentralManager.h"
#import "CBTPeripheral.h"

static NSString *kCBCentralProperty_state = @"state";
static NSString *kCBCentralProperty_isScanning = @"isScanning";

@interface CBTCentralManager () <CBCentralManagerDelegate>

@end

@implementation CBTCentralManager

- (id)init {
    if (self = [super init]) {
        [self centralManager];
    }
    return self;
}


- (void)dealloc {
    [self removeAllObserver];
}


#pragma mark    -   private

- (void)addAllObserver {
    [self addObserver:self.centralManager forKeyPath:kCBCentralProperty_state options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    [self addObserver:self.centralManager forKeyPath:kCBCentralProperty_isScanning options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

- (void)removeAllObserver {
    [self removeObserver:self.centralManager forKeyPath:kCBCentralProperty_state context:NULL];
    [self removeObserver:self.centralManager forKeyPath:kCBCentralProperty_isScanning context:NULL];
}


#pragma mark    -   public method

- (void)scanPeripherals {
    // serviceUUIDs: 如果设置为nil则扫描结果返回全部的外设，不考虑它们支持的服务类型。
    NSDictionary *options = @{CBCentralManagerScanOptionAllowDuplicatesKey : @false};
    [self.centralManager scanForPeripheralsWithServices:nil options:options];
}


#pragma mark    -   get method

// 管理远程外设的发现和连接，包含扫描、发现和连接到广告外设
// 使用之前需要先设置电源开启状态
- (CBCentralManager *)centralManager {
    // By specifying the dispatch queue as nil, the central manager dispatches central role events using the main queue.
    if (!_centralManager) {
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
        [self addAllObserver];
    }
    return _centralManager;
}




#pragma mark    -   CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    switch (central.state) {
        case CBManagerStateUnknown:         NSLog(@"CBManagerStateUnknown");        break;
        case CBManagerStateResetting:       NSLog(@"CBManagerStateResetting");      break;
        case CBManagerStateUnsupported:     NSLog(@"CBManagerStateUnsupported");    break;
        case CBManagerStateUnauthorized:    NSLog(@"CBManagerStateUnauthorized");   break;
        case CBManagerStatePoweredOff:      NSLog(@"CBManagerStatePoweredOff");     break;
        case CBManagerStatePoweredOn: {
            NSLog(@"CBManagerStatePoweredOn");
            [self scanPeripherals];
        }
            break;
        default: break;
    }
}



- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
    if (peripheral.name) {
        NSLog(@"Discovered, name = %@, charter = %@, RSSI = %@", peripheral.name, peripheral.identifier, RSSI);
        CBTPeripheral *mPeripheral;
        if ([peripheral.name isEqualToString:@"qiyun的AirPods Pro"]) {
            [central connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey : @true,
                                                            CBConnectPeripheralOptionNotifyOnDisconnectionKey : @true,
                                                            CBConnectPeripheralOptionNotifyOnNotificationKey : @true
            }];
            mPeripheral = [[CBTPeripheral alloc] initWithPeripheral:peripheral];
        } else {
            mPeripheral = [CBTPeripheral initWithPeripheral:peripheral];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(centralManager:didDiscoverPeripheral:RSSI:)]) {
            [self.delegate centralManager:self didDiscoverPeripheral:mPeripheral RSSI:RSSI];
        }
        if (![self.discoverPeripherals containsObject:mPeripheral]) {
            [self.discoverPeripherals addObject:mPeripheral];
        }
    }
}


- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"didConnectPeripheral");
    
    if (peripheral.state == CBPeripheralStateConnected) {
        // 获取所有的外设服务信息,参数可以进行过滤
        [peripheral discoverServices:nil];
    }
}


- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"didFailToConnectPeripheral");
}


- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    NSLog(@"didDisconnectPeripheral");
}


- (void)centralManager:(CBCentralManager *)central connectionEventDidOccur:(CBConnectionEvent)event forPeripheral:(CBPeripheral *)peripheral NS_AVAILABLE_IOS(13_0) {
    NSLog(@"connectionEventDidOccur");
}


- (void)centralManager:(CBCentralManager *)central didUpdateANCSAuthorizationForPeripheral:(CBPeripheral *)peripheral NS_AVAILABLE_IOS(13_0) {
    NSLog(@"didUpdateANCSAuthorizationForPeripheral");
}



@end
