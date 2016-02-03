//
//  Macro.h
//  XinCheng
//
//  相关宏定义，url等
//  Created by wmm on 15/11/9.
//  Copyright © 2015年 hanen. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define IsIOS6OrLower ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0)

//获得当前屏幕宽高点数（非像素）
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

//#define HEAD_URL @"https://crm.htsc.com.cn:7005/huatai-ws/investment/"
#define HEAD_URL @"https://crm.htsc.com.cn/eSalesService/"


//登录。
//#define LAND_URL @""HEAD_URL"salesLogin"
//#define LAND_URL @""HEAD_URL"permissionControllerForMobile.do?method=login"

#endif
