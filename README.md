# ActionDeliver
对响应者链简单封装，可替代block和delegate，从view层给vc层传值、或者从view层调用vc方法
i.示例功能：touchView按钮点击后，从vc层实现按钮点击逻辑；
ii.应用场景：假设tableCell内部有多个点击方法需要发起网络请求，若基于MVC模式的话，请求逻辑需写在controller层；
iii.原理button点击后事件传递到下一个响应者nextResponder(也就是demo中的TouchView)、touchView无法响应事件继续传递到vc.view、继而传递到vc
最后要做的就是vc层实现对应方法

优势：
1.避免block块带来的代码结构臃肿混乱，提升可读性；
2.避免频繁签订delegate
3.以上两点仅从视图构造角度来讲的，最后就是配合xib开发比较方便
