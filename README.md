# ActionDeliver
    对响应者链简单封装，可替代block和delegate，从view层给vc层传值、或者从view层调用vc方法
i.示例功能：touchView按钮点击后，从vc层实现按钮点击逻辑；
ii.应用场景：假设tableCell内部有多个点击方法需要发起网络请求，若基于MVC模式的话，请求逻辑需写在controller层；
iii.思路解析：1. button点击通过btn.nextResponder(也就是demo中的TouchView)、touchView无法响应事件继续传递到vc.view、继而传递到vc，vc重写action_deliverEventsWithName: userInfo:方法后对btn点击事件拦截，判断evenName
最后要做的就是vc层实现对应方法。说起来可能啰嗦，详细原理请参考响应者链传递顺序。

    (lldb) po self
    <ViewController: 0x7fc8d8612ec0>

    (lldb) po self.nextResponder
    <UIWindow: 0x7fc8d8615430; frame = (0 0; 414 736); gestureRecognizers = <NSArray: 0x60c00044bd00>; layer = <UIWindowLayer: 0x60c00022a0e0>>

    (lldb) po self.nextResponder
    <UIApplication: 0x7fc8d8400e60>

    (lldb) po self.nextResponder
    <AppDelegate: 0x60000003a3e0>

    (lldb) po self.nextResponder
    nil

优势：
1.避免block块带来的代码结构臃肿混乱，提升可读性；
2.避免频繁签订delegate
3.以上两点仅从视图构造角度来讲的，最后就是配合xib开发比较方便


关于封装问题的解析，代码如下

    - (void)action_deliverEventsWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
        SEL selector = NSSelectorFromString(eventName);
        if ([self respondsToSelector:selector]) {
            if (userInfo) {
                [self performSelector:selector withObject:userInfo];
            } else {
                [self performSelector:selector];
            }
        } else {
            // 无法响应，继续传递
            [self.nextResponder action_deliverEventsWithName:eventName userInfo:userInfo];
        }
    }

1.建议将此方法封装于基类VC，子类无需重写action_deliverEventsWithName
2.直接在子类实现eventName相对应的方法名即可，注意根据有无userInfo添加参数
原理：若view层调用vc层的action_deliverEventsWithName时，系统会查询当前子类的方法调度表selectorList，如果子类未重写也就是未实现相应方法，那么会沿着继承链向上查找其父类，也就是常用基类的selectorList里寻找action_deliverEventsWithName，
依次查到其元类
