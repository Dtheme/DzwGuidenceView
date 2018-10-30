DzwGuidenceView基于lottie-iOS开发的动态引导页，上半部分动画采用AE生成，demo中动画来自[lottie素材网站，谢谢Airbnb以及lottiefile.com](https://www.lottiefiles.com)，lottie库强大在于如果你会使用AE可以大大减轻写代码的工作量，性能上也不错。底部的渐变切换的文字是用原生代码实现。思路是默认赋值的文本设置成透明的attributeString，在fade动画中随机将文本中的文字透明度设置成1。



### 使用

```objective-c
DzwGuidenceView *guidenceView = [[DzwGuidenceView alloc]initWithFrame:[UIScreen mainScreen].bounds];
guidenceView.backgroundColor = [UIColor whiteColor];

//设置动画文件数组
guidenceView.animationsGroup = @[@"man_and_chat",@"man_and_phone",@"man_and_pay_with_credit_card",@"man_and_travel"];
//设置文字数组
guidenceView.textGroup = @[@"看看驴友评价",@"找个靠谱攻略",@"在线支付安排行程",@"走起 ——~ "];
__weak typeof(self) weakSelf = self;

//next按钮回调
guidenceView.nextAction = ^(UIButton * _Nonnull button) {
	UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"" message:@"引导完成,跳出引导页" preferredStyle:1];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"✔️" style:0 handler:nil];
        [alert addAction:ok];
        [weakSelf presentViewController:alert animated:YES completion:nil];
};

[self.view addSubview:guidenceView];

```



注意：lottie也存在一些问题。lottie对AE的属性支持目前并不全面，例如我demo中使用的json文件就使用了AE的`merge shape`属性，但lottie暂时没有支持，所以会出现性能下滑，出现离屏渲染的问题导致卡顿，期待lottie更加完善。