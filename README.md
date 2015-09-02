# learniosRAC
学习iOS之RAC

超链:http://benbeng.leanote.com/post/ReactiveCocoaTutorial-part1

--- RACSignal

/**
 * 当signalTrigger发出sendNext、sendComplete时，
 * 该方法返回的信号立即完成，不再接受任何sendNext发出的value 
 *
 * @ signalTrigger 信号
 * @ 返回信号
 * 
func takeUntil(signalTrigger: RACSignal!) -> RACSignal!
