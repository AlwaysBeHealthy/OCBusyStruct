//
//  ViewController.m
//  BusyStruct
//
//  Created by 宋瀚章 on 2020/10/20.
//

#import "ViewController.h"
//#import "PBSExperimentExecutor.h"
#import <WebKit/WebKit.h>

@interface ViewController ()

//@property (nonatomic, strong) PBSExperimentExecutor *expExecutor;

@property (nonatomic, strong) UIView *testView;

@property (nonatomic, strong) UIButton *loadBtn;

@property (nonatomic, strong) WKWebView *webview;

@property (nonatomic, strong) UITextField *urlfield;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webview = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webview];
    _webview.backgroundColor = UIColor.clearColor;
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.additionalSafeAreaInsets = UIEdgeInsetsMake(233, 233, 233, 233);
    
    self.testView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.safeAreaInsets.top, self.view.bounds.size.width, 100)];
    self.testView.backgroundColor = UIColor.redColor;
    self.testView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.testView];
    
    [self.view addConstraints:@[ [self.view.safeAreaLayoutGuide.topAnchor constraintEqualToAnchor:self.testView.topAnchor],
                                 [self.view.widthAnchor constraintEqualToAnchor:self.testView.widthAnchor],
                                 [self.view.leftAnchor constraintEqualToAnchor:self.testView.leftAnchor],
                                 [self.testView.heightAnchor constraintEqualToConstant:100] ]];
    
    UIButton *startBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 30)];
    startBtn.backgroundColor = UIColor.blueColor;
    [startBtn setTitle:@"start" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(loadRequest) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:startBtn];
    
    _urlfield = [UITextField new];
    _urlfield.translatesAutoresizingMaskIntoConstraints = NO;
    _urlfield.text = @"https://qqvip-web.cdn-go.cn/weishi-ad/latest/index.html";
    _urlfield.backgroundColor = UIColor.grayColor;
    [self.view addSubview:_urlfield];
    
    [self.view addConstraints:@[ [self.view.centerXAnchor constraintEqualToAnchor:self.urlfield.centerXAnchor],
                                 [self.urlfield.heightAnchor constraintEqualToConstant:50],
                                 [self.urlfield.widthAnchor constraintEqualToConstant:300],
                                 [self.urlfield.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:400]
    ]];
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"%f", self.view.safeAreaInsets.bottom);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)startAnimation {
    
    [UIView animateKeyframesWithDuration:3.0
                                   delay:1.0
                                 options:UIViewKeyframeAnimationOptionAllowUserInteraction
                              animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^{
            [self.testView setTransform:CGAffineTransformMakeTranslation(0, -100)];
            self.testView.backgroundColor = UIColor.cyanColor;
        }];
    } completion:^(BOOL res) {
        NSLog(@"here");
    }];
}


- (void)loadRequest {
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlfield.text]]];
}

//- (void)viewSafeAreaInsetsDidChange {
//    [super viewSafeAreaInsetsDidChange];
//    NSLog(@"%f", self.view.safeAreaInsets.top);
//}

@end
