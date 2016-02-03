//
//  ViewController.m
//  XinCheng
//
//  Created by wmm on 15/11/5.
//  Copyright © 2015年 hanen. All rights reserved.
//

#import "ViewController.h"
#import "MenuListViewController.h"
#import "GHRevealViewController.h"
#import "Tools.h"
#import "Macro.h"
#import "AFNetworking.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;

- (IBAction)login:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    _userName = [[UITextField alloc]init];
    _userName.delegate = self;
    
//    _password = [[UITextField alloc]init];
    _password.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

- (IBAction)login:(id)sender {
    NSLog(@"%@======%@",_userName.text,_password.text);
    if(_userName.text == nil | [_userName.text length] == 0 | _password.text == nil | [_password.text length] == 0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号密码不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        
        // 创建按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }else{
        [_userName resignFirstResponder];
        [_password resignFirstResponder];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:_userName.text forKey:@"userName"];
//        [userDefaults setObject:_password.text forKey:@"password"];
        //在存储数据的地方,别忘了这一句
        [[NSUserDefaults standardUserDefaults] synchronize];

//        [Tools showDial:_login];
    }

    

    
    //在需要的地方获取数据
//    NSString *getStringValue  = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
   
            MenuListViewController* menuVc = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuListViewController"];
            
            if (nil==menuVc) return;
            
            if ([_userName.text isEqualToString: @"1"]) {
                menuVc.role = 2;
            }else{
                menuVc.role = 1;
            }
            
            UIColor *bgColor = [UIColor whiteColor];
            GHRevealViewController* revealController = [[GHRevealViewController alloc] initWithNibName:nil bundle:nil];
            revealController.view.backgroundColor = bgColor;
            
            // 绑定.
            menuVc.revealController = revealController;
            revealController.sidebarViewController = menuVc;
            
            // show.
            revealController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;    // 淡入淡出.
            //[self presentModalViewController:revealController animated:YES];
            [self presentViewController:revealController animated:YES completion:nil];

    
    // 直接模态弹出菜单页面（已废弃，仅用于调试）.
    //    if (NO) {
    //        menuVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;    // 淡入淡出.
    //        //[self presentModalViewController:menuVc animated:YES];
    //        [self presentViewController:menuVc animated:YES completion:nil];
    //
    //    }
    
    //    // 模态弹出侧开菜单控制器.
    //    if (YES) {
    //        //UIColor *bgColor = [UIColor colorWithRed:(50.0f/255.0f) green:(57.0f/255.0f) blue:(74.0f/255.0f) alpha:1.0f];
    //        UIColor *bgColor = [UIColor whiteColor];
    //        GHRevealViewController* revealController = [[GHRevealViewController alloc] initWithNibName:nil bundle:nil];
    //        revealController.view.backgroundColor = bgColor;
    //
    //        // 绑定.
    //        menuVc.revealController = revealController;
    //        revealController.sidebarViewController = menuVc;
    //
    //        // show.
    //        revealController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;    // 淡入淡出.
    //        //[self presentModalViewController:revealController animated:YES];
    //        [self presentViewController:revealController animated:YES completion:nil];
    //    }
}

//关闭虚拟键盘。
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == _userName){
        [_userName resignFirstResponder];
        [_password resignFirstResponder];
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_userName resignFirstResponder];
    [_password resignFirstResponder];
    
}

//防止虚拟键盘挡住输入框。
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    if(self.view.frame.origin.y == 0)
//    {
//        [UIView animateWithDuration:0.3 animations:^{
//            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - offsetH, self.view.frame.size.width, self.view.frame.size.height);
//        }];
//    }
}

@end
