# Thread Runner

Basic thread library with which you can manage startup, main, monitor and queue functions. User functions can be implemented as lambda functions.


In simple use, thread_func and product_func must be given as parameters. As the default parameter, the number of threads is set to 1 and monitoring time is set to 10 seconds.


~~~ruby
runner = ThreadRunner.new(
    product_func: -> {
      [1,2,3,4,5,6,7,8,9]
    },
    thread_func:  -> tid, queue { 
        until queue.size == 0
          param = queue.pop
          puts "thread: '#{tid}' processed param: '#{param}' !"
          sleep 1
        end 
    }
)

runner.run
# output will be
# thread: '0' processed param: '1' !
# thread: '0' processed param: '2' !
# thread: '0' processed param: '3' !
# thread: '0' processed param: '4' !
# thread: '0' processed param: '5' !
# thread: '0' processed param: '6' !
# thread: '0' processed param: '7' !
# thread: '0' processed param: '8' !
# thread: '0' processed param: '9' !
~~~

If we set thread_count other than 1, we will see that the result printed to the output also changes.


~~~ruby
runner = ThreadRunner.new(
    product_func: -> {
      [1,2,3,4,5,6,7,8,9]
    },
    thread_func:  -> tid, queue { 
        until queue.size == 0
          param = queue.pop
          puts "thread: '#{tid}' processed param: '#{param}' !"
          sleep 1
        end 
    }, 
    thread_count: 5
)

runner.run
# output might be like:
# 
# thread: '2' processed param: '1' !
# thread: '0' processed param: '2' !
# thread: '3' processed param: '3' !
# thread: '1' processed param: '4' !
# thread: '0' processed param: '6' !
# thread: '1' processed param: '7' !
# thread: '2' processed param: '8' !
# thread: '3' processed param: '5' !
# thread: '0' processed param: '9' !
~~~


## product_func
TODO:

## thread_func
TODO:

## thread_count
TODO:

## thread_count
TODO:

## init_func
TODO:

## finish_func
TODO:

## main_func
TODO:

## monitor_func
TODO:

## product_to_queue_func
TODO:
