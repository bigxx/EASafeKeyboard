# EASafeKeyboard
---

自定义安全键盘，数字键盘随机打乱    
---
## 使用
创建*EASafeTextField*控件，该控件继承*UITextField*，可正常使用任何父类属性
```
   EASafeTextField *textField = [[EASafeTextField alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    textField.placeholder = @"自定义安全键盘";
    textField.eKeyboardType = EASKTextFieldSafeKeyboard;
    textField.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:textField];
```


## 效果
[image:63E89728-B994-4064-BF8B-020D51B8C93F-7377-000013620B9E0625/Nov-08-2019 16-34-24.gif]
