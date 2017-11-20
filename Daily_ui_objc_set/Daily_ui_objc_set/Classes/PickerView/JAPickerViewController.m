//
//  JAPickerViewController.m
//  ActionSheetPickerDemo
//
//  Created by Jason on 24/05/2017.
//  Copyright © 2017 Jason. All rights reserved.
//

#import "JAPickerViewController.h"

CGFloat const JAAnimatedTransitionDuration = 0.4;

@interface JAPickerViewController () <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic) UIButton *cancelButton;
@property (nonatomic) UIButton *selectButton;
@property (nonatomic) UIButton *dismissButton;
@property (nonatomic) UIView *buttonDivierView;
@property (nonatomic) UIView *buttonContainerView;
@property (nonatomic) UIView *pickerContainerView;
@property (nonatomic) UIView *dimmedView;

@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,copy) NSString *selectedTitle;

// UIButton Actions
- (void)didTouchCancelButton:(id)sender;
- (void)didTouchSelectButton:(id)sender;

@end

@implementation JAPickerViewController

+ (instancetype)pickerWithTitle:(NSArray <NSString *> *)titles
                  selectedBlock:(void (^)(NSString *title))selectedBlock
                    cancelBlock:(void (^)())cancelBlock {
    return [self pickerWithTitle:titles selectedBlock:selectedBlock cancelBlock:cancelBlock presentViewController:nil];
}

+ (instancetype)pickerWithTitle:(NSArray <NSString *> *)titles
                  selectedBlock:(void (^)(NSString *title))selectedBlock
                    cancelBlock:(void (^)())cancelBlock
          presentViewController:(UIViewController *)controller {
    
    JAPickerViewController *pickerVC = [[JAPickerViewController alloc] init];
    pickerVC.titles = titles;
    pickerVC.selectedBlock = selectedBlock;
    pickerVC.cancelBlock = cancelBlock;
    pickerVC.controller = controller;
    return pickerVC;
}

- (void)show {
    [self.controller presentViewController:self animated:true completion:nil];
}
- (void)dissmiss {
    [self.controller dismissViewControllerAnimated:true completion:nil];
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    
    _pickerView = [UIPickerView new];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    _pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    _pickerView.backgroundColor = [UIColor whiteColor];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    // Dismiss View
    _dismissButton = [UIButton new];
    _dismissButton.translatesAutoresizingMaskIntoConstraints = false;
    _dismissButton.userInteractionEnabled = true;
    _dismissButton.backgroundColor = [UIColor clearColor];
    [_dismissButton addTarget:self action:@selector(didTouchCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dismissButton];
    
    // PickerView Container
    _pickerContainerView = [[UIView alloc]initWithFrame:CGRectMake(5, [UIScreen mainScreen].bounds.size.height - 60, [UIScreen mainScreen].bounds.size.width -10, 216)];
    _pickerContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    _pickerContainerView.backgroundColor = [UIColor whiteColor];
    _pickerContainerView.clipsToBounds = true;
    _pickerContainerView.layer.cornerRadius = 5.0;
    [self.view addSubview:_pickerContainerView];
    
    _pickerView.frame = self.pickerContainerView.bounds;
    _selectedTitle =_titles[0];
    // self.firstTimeLimit = _titles[0];
    [self.pickerView selectRow:0 inComponent:0 animated:false];
    [_pickerContainerView addSubview:_pickerView];
    
    // Button Container View
    _buttonContainerView = [UIView new];
    _buttonContainerView.translatesAutoresizingMaskIntoConstraints = false;
    _buttonContainerView.backgroundColor =  [UIColor whiteColor];
    _buttonContainerView.layer.cornerRadius = 5.0;
    [self.view addSubview:_buttonContainerView];
    
    // Button Divider
    _buttonDivierView = [UIView new];
    _buttonDivierView.translatesAutoresizingMaskIntoConstraints = false;
    _buttonDivierView.backgroundColor =  [UIColor colorWithRed:205.0 / 255.0 green:205.0 / 255.0 blue:205.0 / 255.0 alpha:1.0];
    [_buttonContainerView addSubview:_buttonDivierView];
    
    // Cancel Button
    _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancelButton.translatesAutoresizingMaskIntoConstraints = false;
    [_cancelButton setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(didTouchCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonContainerView addSubview:_cancelButton];
    
    // Select Button
    _selectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _selectButton.translatesAutoresizingMaskIntoConstraints = false;
    [_selectButton addTarget:self action:@selector(didTouchSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_selectButton setTitle:NSLocalizedString(@"选择", nil) forState:UIControlStateNormal];
    
    CGFloat fontSize = _selectButton.titleLabel.font.pointSize;
    _selectButton.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    
    [_buttonContainerView addSubview:_selectButton];
    
    // Layout
    NSDictionary *views = NSDictionaryOfVariableBindings(_dismissButton,
                                                         _pickerContainerView,
                                                         _pickerView,
                                                         _buttonContainerView,
                                                         _buttonDivierView,
                                                         _cancelButton,
                                                         _selectButton);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_cancelButton][_buttonDivierView(0.5)][_selectButton(_cancelButton)]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_cancelButton]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_buttonDivierView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_selectButton]|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_pickerView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_pickerView]|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_dismissButton]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_pickerContainerView]-5-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_buttonContainerView]-5-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_dismissButton][_pickerContainerView]-10-[_buttonContainerView(40)]-5-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];

}

#pragma mark pickDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    //颜色
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
     self.selectedTitle = self.titles[row];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    
    return self.titles.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    
    return  self.titles[row];
}

#pragma mark - UIButton Actions

- (void)didTouchCancelButton:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
    if (self.controller) {
        [self dissmiss];
    }
}

- (void)didTouchSelectButton:(id)sender {
    if (self.selectedBlock) {
        self.selectedBlock(self.selectedTitle);
    }
    
    if (self.controller) {
        [self dissmiss];
    }
}


#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return JAAnimatedTransitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    // If we are presenting
    if (toViewController.view == self.view) {
        fromViewController.view.userInteractionEnabled = NO;
        
        // Adding the view in the right order
        [containerView addSubview:self.dimmedView];
        [containerView addSubview:toViewController.view];
        
        // Moving the view OUT
        CGRect frame = toViewController.view.frame;
        frame.origin.y = CGRectGetHeight(toViewController.view.bounds);
        toViewController.view.frame = frame;
        
        self.dimmedView.alpha = 0.0;
        
        [UIView animateWithDuration:JAAnimatedTransitionDuration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            self.dimmedView.alpha = 0.5;
            
            // Moving the view IN
            CGRect frame = toViewController.view.frame;
            frame.origin.y = 0.0;
            toViewController.view.frame = frame;
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
    
    // If we are dismissing
    else {
        toViewController.view.userInteractionEnabled = YES;
        
        [UIView animateWithDuration:JAAnimatedTransitionDuration delay:0.1 usingSpringWithDamping:1.0 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.dimmedView.alpha = 0.0;
            
            // Moving the view OUT
            CGRect frame = fromViewController.view.frame;
            frame.origin.y = CGRectGetHeight(fromViewController.view.bounds);
            fromViewController.view.frame = frame;
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source {
    return self;
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

- (UIView *)dimmedView {
    if (!_dimmedView) {
        UIView *dimmedView = [[UIView alloc] initWithFrame:self.view.bounds];
        dimmedView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        dimmedView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
        dimmedView.backgroundColor = [UIColor blackColor];
        _dimmedView = dimmedView;
    }
    
    return _dimmedView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
