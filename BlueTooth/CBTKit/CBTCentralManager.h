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

/*!
 *  @method didDiscoverPeripheral:RSSI:
 *
 *  @param peripheral    外设
 *
 *  @param RSSI    Receive signal strength indication（信号接收强度指示，dBm）
 *
 *  @discussion     发现外设，每次有外设检测都会调用
 *
 */
- (void)centralManager:(CBTCentralManager *)centralManager didDiscoverPeripheral:(CBTPeripheral *)peripheral RSSI:(NSNumber *)RSSI;


/*!
 *  @method didConnectPeripheral
 *
 *  @param peripheral    外设
 *
 *  @discussion    已成功连接外设
 *
 */
- (void)centralManager:(CBTCentralManager *)centralManager didConnectPeripheral:(CBTPeripheral *)peripheral;


/*!
 *  @method didDisconnectPeripheral
 *
 *  @param peripheral    外设
 *
 *  @discussion     断开与外设的连接
 *
 */
- (void)centralManager:(CBTCentralManager *)centralManager didDisconnectPeripheral:(CBTPeripheral *)peripheral;

@end


@interface CBTCentralManager : CBTManager


// 中心设备管理,控制远程外设的发现和连接，包含扫描、发现和连接到广告外设
@property (strong, nonatomic) CBCentralManager *centralManager;


// 代理，用于接收事件回调
@property (weak, nonatomic) id <CBTCentralDelegate> delegate;


// 连接外设
- (void)connectPeriheral:(CBTPeripheral *)peripheral;


// 断开外设连接
- (void)disconnectPeriheral:(CBTPeripheral *)peripheral;


@end

NS_ASSUME_NONNULL_END
