//
//  CBTCentralManager.h
//  BlueTooth
//
//  Created by yryz on 2020/1/6.
//  Copyright © 2020 com.yryz.qiyun. All rights reserved.
//

#import "CBTManager.h"

NS_ASSUME_NONNULL_BEGIN

@class CBTCentralManager, CBTPeripheral;
@protocol CBTCentralDelegate <NSObject>

// 发现外设
- (void)centralManager:(CBTCentralManager *)centralManager didDiscoverPeripheral:(CBTPeripheral *)peripheral RSSI:(NSNumber *)RSSI;

// 与外设断开连接
- (void)centralManager:(CBTCentralManager *)centralManager didDisconnectPeripheral:(CBTPeripheral *)peripheral;

@end


@interface CBTCentralManager : CBTManager

@property (strong, nonatomic) CBCentralManager *centralManager;

@property (weak, nonatomic) id <CBTCentralDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
