//
//  MenuListViewController.m
//  XinCheng
//
//  Created by wmm on 15/11/5.
//  Copyright © 2015年 hanen. All rights reserved.
//

#import "MenuListViewController.h"
#import "SideMenuUtil.h"
#import "SVProgressHUD.h"
#import "BranchStatisticController.h"

#define kSidebarCellTextKey	@"CellText"
#define kSidebarCellImageKey	@"CellImage"

@interface MenuListViewController (){
    NSArray *_headers;	//!< 节头文本.
    NSArray *_cellInfos;	//!< 单元格信息.
    NSArray *_controllers;	//!< 导航控制器集.
}
@property (strong, nonatomic) IBOutlet UITableView *menuTableView;

@property (strong, nonatomic) UIView *overlayView;
@property (strong,nonatomic) UIImagePickerController * imagePikerViewController;
@property (strong,nonatomic) UIButton *takeButton;


@end

@implementation MenuListViewController

@synthesize revealController;
@synthesize role;

/// 构造函数.
- (id)init {
    // [UIStoryboard instantiateViewControllerWithIdentifier] 获取vc时, 似乎不会被调用构造函数.
    NSLog(@"init. By %@", self);
    self = [self initWithNibName:nil bundle:nil];
    return self;
}

/// 构造函数: 根据Nib名.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // [UIStoryboard instantiateViewControllerWithIdentifier] 获取vc时, 似乎不会被调用构造函数.
    NSLog(@"initWithNibName: %@, %@ . By %@", nibNameOrNil, nibBundleOrNil, self);
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;	// 淡入淡出.
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置自身窗口尺寸
    self.view.frame = CGRectMake(0.0f, 0.0f, kGHRevealSidebarWidth, CGRectGetHeight(self.view.bounds));
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    // 绑定主页为内容视图.
    if (YES) {
        UINavigationController* homeNC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeNavigationController"];
        NSLog(@"instantiateViewControllerWithIdentifier: %@", homeNC);
        [SideMenuUtil addNavigationGesture:homeNC revealController:revealController];
        //homeNC.revealController = revealController;
        [SideMenuUtil setRevealControllerProperty:homeNC revealController:revealController];
        revealController.contentViewController = homeNC;
    }
    // 初始化表格.
    _headers = @[
                 [NSNull null],
                 [NSNull null],
//                 @"",
//                 @"",
                 ];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *userRole = [userDefaultes objectForKey:@"userName"];
    if([userRole isEqualToString:@"2"]){
        _cellInfos = @[
                       @[
                           @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"拜访管理", @"")},
                           @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"小区管理", @"")},
                           @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"网点统计", @"")},
                           ],
                       @[
                           @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"注销", @"")},
                           ],
                       ];
        _controllers = @[
                         @[
                             [self.storyboard instantiateViewControllerWithIdentifier:@"HomeNavigationController"],
                             [self.storyboard instantiateViewControllerWithIdentifier:@"SubdistrictNavigationController"],
                             [self.storyboard instantiateViewControllerWithIdentifier:@"BranchStatisticNavigationController"],
                             ],
                         @[
                             @"logout",
                             ],
                         ];
        
    }else{
        _cellInfos = @[
                       @[
                           @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"拜访管理", @"")},
                           @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"物业管理", @"")},
                           @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"小区管理", @"")},
                           @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"名片扫描", @"")},
                           @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"小区地图", @"")},
                           ],
                       @[
                           @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"注销", @"")},
                           ],
                       ];
        _controllers = @[
                         @[
                             [self.storyboard instantiateViewControllerWithIdentifier:@"HomeNavigationController"],
                             [self.storyboard instantiateViewControllerWithIdentifier:@"PropertyNavigationController"],
                             [self.storyboard instantiateViewControllerWithIdentifier:@"SubdistrictNavigationController"],
                             @"scanning",
                             [self.storyboard instantiateViewControllerWithIdentifier:@"MapNavigationController"],
                             ],
                         @[
                             @"logout",
                             ],
                         ];
    }
    
    // 添加手势.
    for (id obj1 in _controllers) {
//        [SideMenuUtil setRevealControllerProperty:obj revealController:revealController];
//        if ([obj isKindOfClass:UINavigationController.class]) {
//            [SideMenuUtil addNavigationGesture:(UINavigationController*)obj revealController:revealController];
//        }
        if (nil==obj1) continue;
        for (id obj2 in (NSArray *)obj1) {
            if (nil==obj2) continue;
            [SideMenuUtil setRevealControllerProperty:obj2 revealController:revealController];
            if ([obj2 isKindOfClass:UINavigationController.class]) {
                [SideMenuUtil addNavigationGesture:(UINavigationController*)obj2 revealController:revealController];
            }
        }
    }
    
    // ui.
    UIColor *bgColor = [UIColor colorWithRed:(50.0f/255.0f) green:(57.0f/255.0f) blue:(74.0f/255.0f) alpha:1.0f];
    self.view.backgroundColor = bgColor;
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    self.menuTableView.backgroundColor = [UIColor clearColor];
    self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    
    
    self.imagePikerViewController = [[UIImagePickerController alloc] init];
    self.imagePikerViewController.delegate = self;
    self.imagePikerViewController.allowsEditing = YES;
}

- (void)viewDidUnload {
    [self setMenuTableView:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    // 设置自身窗口尺寸
    self.view.frame = CGRectMake(0.0f, 0.0f, kGHRevealSidebarWidth, CGRectGetHeight(self.view.bounds));
}


-(void)takePhoto{
    //拍照，会自动回调- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info，对于自定义照相机界面，拍照后回调可以不退出实现连续拍照效果
    NSLog(@"takePicture...");
    [self.imagePikerViewController takePicture];
    [SVProgressHUD showWithStatus:@"识别中"];
    self.takeButton.hidden = YES;
}

- (UIView *)drawCameraView {
    UIView* cameraView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
    
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    upView.alpha = 0.5;
    upView.backgroundColor = [UIColor blackColor];
    [cameraView addSubview:upView];
    
    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 35, kScreenHeight-110)];
    leftView.alpha = 0.5;
    leftView.backgroundColor = [UIColor blackColor];
    [cameraView addSubview:leftView];
    
    UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-35, 30, 35, kScreenHeight-110)];
    rightView.alpha = 0.5;
    rightView.backgroundColor = [UIColor blackColor];
    [cameraView addSubview:rightView];
    
    //    UIView* middleView = [[UIView alloc] initWithFrame:CGRectMake(35, 30, kScreenWidth-70, kScreenHeight-110)];
    UIView* middleView = [[UIView alloc] initWithFrame:CGRectMake(35, 30, kScreenWidth-70, kScreenHeight-150)];
    middleView.alpha = 1;
    [cameraView addSubview:middleView];
    
    UIView * downView1 = [[UIView alloc] initWithFrame:CGRectMake(35, kScreenHeight-120, kScreenWidth-70, 40)];
    downView1.alpha = 0.5;
    downView1.backgroundColor = [UIColor blackColor];
    [cameraView addSubview:downView1];
    
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-80, kScreenWidth, 80)];
    downView.alpha = 1;
    //    NSString *bg_path = [[NSBundle mainBundle] pathForResource:@"uexCardRec/card_bg" ofType:@"png"];
    //    UIImage *bg_img = [UIImage imageWithContentsOfFile:bg_path];
    UIImage *bg_img = [UIImage imageNamed:@"card_bg.png"];
    downView.backgroundColor = [UIColor colorWithPatternImage:bg_img];
    [cameraView addSubview:downView];
    
    self.takeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.takeButton.alpha = 1;
    //      NSString *path = [[NSBundle mainBundle] pathForResource:@"uexCardRec/shot" ofType:@"png"];
    //      UIImage *img = [UIImage imageWithContentsOfFile:path];
    UIImage *img = [UIImage imageNamed:@"shot.png"];
    [self.takeButton setImage:img forState:UIControlStateNormal];
    [self.takeButton setFrame:CGRectMake(kScreenWidth/2-30, kScreenHeight-65, 50, 50)];
    [self.takeButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [cameraView addSubview:self.takeButton];
    
    
    //用于取消操作的button
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.alpha = 1;
    [cancelButton setFrame:CGRectMake(kScreenWidth-70, kScreenHeight-65, 50, 50)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [cancelButton addTarget:self action:@selector(cancelCamera) forControlEvents:UIControlEventTouchUpInside];
    [cameraView addSubview:cancelButton];
    
    
    UIView* leftUpLine = [[UIView alloc] initWithFrame:CGRectMake(35, 30, 3, 20)];
    leftUpLine.alpha = 1;
    leftUpLine.backgroundColor = [UIColor redColor];
    [cameraView addSubview:leftUpLine];
    
    UIView* leftUpLine2 = [[UIView alloc] initWithFrame:CGRectMake(35, 30, 20, 3)];
    leftUpLine2.alpha = 1;
    leftUpLine2.backgroundColor = [UIColor redColor];
    [cameraView addSubview:leftUpLine2];
    
    UIView* rightUpLine = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-38, 30, 3, 20)];
    rightUpLine.alpha = 1;
    rightUpLine.backgroundColor = [UIColor redColor];
    [cameraView addSubview:rightUpLine];
    
    UIView* rightUpLine2 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-55, 30, 20, 3)];
    rightUpLine2.alpha = 1;
    rightUpLine2.backgroundColor = [UIColor redColor];
    [cameraView addSubview:rightUpLine2];
    
    UIView* leftButLine = [[UIView alloc] initWithFrame:CGRectMake(35, kScreenHeight-140, 3, 20)];
    leftButLine.alpha = 1;
    leftButLine.backgroundColor = [UIColor redColor];
    [cameraView addSubview:leftButLine];
    
    UIView* leftButLine2 = [[UIView alloc] initWithFrame:CGRectMake(35, kScreenHeight-122, 20, 3)];
    leftButLine2.alpha = 1;
    leftButLine2.backgroundColor = [UIColor redColor];
    [cameraView addSubview:leftButLine2];
    
    UIView* rightButLine = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-38, kScreenHeight-140, 3, 20)];
    rightButLine.alpha = 1;
    rightButLine.backgroundColor = [UIColor redColor];
    [cameraView addSubview:rightButLine];
    
    UIView* rightButLine2 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-55, kScreenHeight-122, 20, 3)];
    rightButLine2.alpha = 1;
    rightButLine2.backgroundColor = [UIColor redColor];
    [cameraView addSubview:rightButLine2];
    
    return cameraView;
}


//startScanning
- (void)startScanning{
    self.imagePikerViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePikerViewController.delegate = self;
    self.imagePikerViewController.showsCameraControls = NO;
    self.overlayView.frame = self.imagePikerViewController.cameraOverlayView.frame;
    self.overlayView.backgroundColor = [UIColor clearColor];
    self.imagePikerViewController.cameraOverlayView = [self drawCameraView];
    
    // 相机全屏
    CGSize screenBounds = [UIScreen mainScreen].bounds.size;
    CGFloat cameraAspectRatio = 4.0f/3.0f;
    CGFloat camViewHeight = screenBounds.width * cameraAspectRatio;
    CGFloat scale = screenBounds.height / camViewHeight;
    self.imagePikerViewController.cameraViewTransform = CGAffineTransformMakeTranslation(0, (screenBounds.height - camViewHeight) / 2.0);
    self.imagePikerViewController.cameraViewTransform = CGAffineTransformScale(self.imagePikerViewController.cameraViewTransform, scale, scale);
    
    [self presentViewController:self.imagePikerViewController animated:YES completion:NULL];
    

}
#pragma mark -
#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    HWCloudsdk *sdk = [[HWCloudsdk alloc] init];
    
    NSString *apiKey = @"b5777b52-f26c-4d1f-b834-c5a2053fe37e";
    NSLog(@"识别开始。。。");
    //    NSString *cardResult = [sdk cardLanguage:language cardImage: image apiKey:apiKey];
    NSString *cardResult = nil;
    [sdk cardLanguage:@"chns" cardImage:image apiKey:apiKey successBlock:^(id responseObject) {
        NSLog(@"%@",responseObject);
        //        cardResult = responseObject;
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    NSLog(@"识别结果。。。%@",cardResult);
    
    if(cardResult == nil || [cardResult isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:@"网络异常或超时,请稍后再试！"];
        [SVProgressHUD dismissWithDelay:1555.0];
        NSLog(@"识别失败。。。网络异常或超时");
        return;
    }
    
    NSData *data = [cardResult dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    NSDictionary * rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    NSLog(@"%@",rootDic);
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    
    NSString *code = [rootDic objectForKey:@"code"];
    if ([code isEqualToString:@"0"]) {
        
        [SVProgressHUD dismiss];
        
        NSArray *names = [rootDic objectForKey:@"name"];
        if (names.count > 0) {
            NSString *nameString = [names componentsJoinedByString:@","];
            [keyValues addObject:[NSString stringWithFormat:@"\"name\":\"%@\"",nameString]];
        }else{
            [keyValues addObject:@"\"name\":\"\""];
        }
        
        NSArray *faxs = [rootDic objectForKey:@"fax"];
        if (faxs.count > 0) {
            NSString *faxString = [faxs componentsJoinedByString:@","];
            [keyValues addObject:[NSString stringWithFormat:@"\"fax\":\"%@\"",faxString]];
        }else{
            [keyValues addObject:@"\"fax\":\"\""];
        }
        
        NSArray *telephones = [rootDic objectForKey:@"tel"];
        if (telephones.count > 0) {
            NSString *telephoneString = [telephones componentsJoinedByString:@","];
            [keyValues addObject:[NSString stringWithFormat:@"\"telephone\":\"%@\"",telephoneString]];
        }else{
            [keyValues addObject:@"\"telephone\":\"\""];
        }
        NSArray *cellphones = [rootDic objectForKey:@"mobile"];
        if (cellphones.count > 0) {
            NSString *cellphoneString = [cellphones componentsJoinedByString:@","];
            [keyValues addObject:[NSString stringWithFormat:@"\"cellphone\":\"%@\"",cellphoneString]];
        }else{
            [keyValues addObject:@"\"cellphone\":\"\""];
        }
        NSArray *organizations = [rootDic objectForKey:@"comp"];
        if (organizations.count > 0) {
            NSString *organizationString = [organizations componentsJoinedByString:@","];
            [keyValues addObject:[NSString stringWithFormat:@"\"organization\":\"%@\"",organizationString]];
        }else{
            [keyValues addObject:@"\"organization\":\"\""];
        }
        NSArray *emails = [rootDic objectForKey:@"email"];
        if (emails.count > 0) {
            NSString *emailString = [emails componentsJoinedByString:@","];
            [keyValues addObject:[NSString stringWithFormat:@"\"email\":\"%@\"",emailString]];
        }else{
            [keyValues addObject:@"\"email\":\"\""];
        }
        NSArray *addresss = [rootDic objectForKey:@"addr"];
        if (addresss.count > 0) {
            NSString *addressString = [addresss componentsJoinedByString:@","];
            [keyValues addObject:[NSString stringWithFormat:@"\"address\":\"%@\"",addressString]];
        }else{
            [keyValues addObject:@"\"address\":\"\""];
        }
        NSArray *urls = [rootDic objectForKey:@"web"];
        if (urls.count > 0) {
            NSString *urlString = [urls componentsJoinedByString:@","];
            [keyValues addObject:[NSString stringWithFormat:@"\"url\":\"%@\"",urlString]];
        }else{
            [keyValues addObject:@"\"url\":\"\""];
        }
        
        [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
        [reString appendString:@"}"];
        //        [self jsSuccessWithName:@"uexCardRec.cbResultCardInfo" opId:0 dataType:0 strData:reString];
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"名片识别失败！"];
        [SVProgressHUD dismissWithDelay:1555.0];
    }
}


-(void)cancelCamera{
    [self.imagePikerViewController dismissViewControllerAnimated:YES completion:nil];
}

// 处理菜单项点击事件.
- (BOOL)onSelectRowAtIndexPath:(NSIndexPath *)indexPath hideSidebar:(BOOL)hideSidebar {
    BOOL rt = NO;
    do {
        if (nil==indexPath) break;
        
        // 获得当前项目.
        id controller = _controllers[indexPath.section][indexPath.row];
        if (nil!=controller) {
            // 命令.
            if ([controller isKindOfClass:NSString.class]) {
                NSString* cmd = controller;
                if ([cmd isEqualToString:@"logout"]) {
                    [self cancelButton_selector:nil];
                    rt = YES;
                    break;
                }
                if ([cmd isEqualToString:@"scanning"]) {
                    [self startScanning];
                    rt = YES;
//                    if (hideSidebar) {
//                        [revealController toggleSidebar:NO duration:kGHRevealSidebarDefaultAnimationDuration];
//                    }
                    break;
                }
//                if ([cmd isEqualToString:@"BranchStatisticController"]) {
//                    controller = [[BranchStatisticController alloc] init];
//                    rt = YES;
//                    revealController.contentViewController = controller;
//                    if (hideSidebar) {
//                        [revealController toggleSidebar:NO duration:kGHRevealSidebarDefaultAnimationDuration];
//                    }
//                    break;
//                }
            }
            
            // 页面跳转.
            if ([controller isKindOfClass:UIViewController.class]) {
                rt = YES;
                revealController.contentViewController = controller;
                if (hideSidebar) {
                    [revealController toggleSidebar:NO duration:kGHRevealSidebarDefaultAnimationDuration];
                }
            }
        }
    } while (0);
    return rt;
}

/// 选择某个菜单项.
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition {
    [_menuTableView selectRowAtIndexPath:indexPath animated:animated scrollPosition:scrollPosition];
    if (scrollPosition == UITableViewScrollPositionNone) {
        [_menuTableView scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
    }
    [self onSelectRowAtIndexPath:indexPath hideSidebar:NO];
    NSLog(@"selectRowAtIndexPath: %@", revealController.contentViewController);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _headers.count;
//    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)_cellInfos[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MenuListCell";
    MenuListCell *cell = (MenuListCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MenuListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *info = _cellInfos[indexPath.section][indexPath.row];
    cell.textLabel.text = info[kSidebarCellTextKey];
    cell.imageView.image = info[kSidebarCellImageKey];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (_headers[section] == [NSNull null]) ? 0.0f : 21.0f;
//    return 21.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.menuTableView.frame.size.width, 1000)];
    view.backgroundColor = [UIColor clearColor];
    return view;
    
//    NSObject *headerText = _headers[section];
//    UIView *headerView = nil;
//    if (headerText != [NSNull null]) {
//        headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.height, 21.0f)];
//        CAGradientLayer *gradient = [CAGradientLayer layer];
//        gradient.frame = headerView.bounds;
//        gradient.colors = @[
//                            (id)[UIColor colorWithRed:(67.0f/255.0f) green:(74.0f/255.0f) blue:(94.0f/255.0f) alpha:1.0f].CGColor,
//                            (id)[UIColor colorWithRed:(57.0f/255.0f) green:(64.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f].CGColor,
//                            ];
//        [headerView.layer insertSublayer:gradient atIndex:0];
//        
//        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectInset(headerView.bounds, 12.0f, 5.0f)];
//        textLabel.text = (NSString *) headerText;
//        textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:([UIFont systemFontSize] * 0.8f)];
//        textLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
//        textLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.25f];
//        textLabel.textColor = [UIColor colorWithRed:(125.0f/255.0f) green:(129.0f/255.0f) blue:(146.0f/255.0f) alpha:1.0f];
//        textLabel.backgroundColor = [UIColor clearColor];
//        textLabel.backgroundColor = [UIColor redColor];
//        [headerView addSubview:textLabel];
//        
//        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.height, 1.0f)];
////        topLine.backgroundColor = [UIColor colorWithRed:(78.0f/255.0f) green:(86.0f/255.0f) blue:(103.0f/255.0f) alpha:1.0f];
//        topLine.backgroundColor = [UIColor redColor];
//        [headerView addSubview:topLine];
//        
//        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 21.0f, [UIScreen mainScreen].bounds.size.height, 1.0f)];
//        bottomLine.backgroundColor = [UIColor colorWithRed:(36.0f/255.0f) green:(42.0f/255.0f) blue:(5.0f/255.0f) alpha:1.0f];
//        bottomLine.backgroundColor = [UIColor redColor];
//        [headerView addSubview:bottomLine];
//    }
//    return headerView;
}

/// 处理单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self onSelectRowAtIndexPath:indexPath hideSidebar:YES];
    NSLog(@"didSelectRowAtIndexPath: %@", revealController.contentViewController);
}

/// 取消按钮:点击.
- (void)cancelButton_selector:(id)sender {
    if (nil!=revealController) {
        [revealController dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
