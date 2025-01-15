# basic thread library
class ThreadRunner
  THREAD_COUNT    = 1
  MONITORING_TIME = 10 # as second

  def initialize (
      product_func: ,
      thread_func: ,
      thread_count:    THREAD_COUNT,
      monitoring_time: MONITORING_TIME,
      init_func:    -> {},
      finish_func:  -> {},
      main_func:    main_thread(),    
      monitor_func: monitor_thread(),
      product_to_queue_func: products_to_queue()
    )
    @thread_func     = thread_func
    @product_func    = product_func
    @thread_count    = thread_count
    @monitoring_time = monitoring_time
    @init_func       = init_func
    @finish_func     = finish_func
    @main_thread     = main_func
    @monitor_thread  = monitor_func
    @product_to_queue = product_to_queue_func
  end
  
  def run
    @init_func.call

    products = @product_func.call
    queue    = @product_to_queue.call(products)
    @main_thread.call(queue)
    @monitor_thread.call(queue)
    
    @finish_func.call
  end
  
  private
  
  # start threads for operation
  def main_thread
    -> queue {
      return false if @thread_count <= 0

      threads = @thread_count.times.map { |tid| Thread.new { @thread_func.call(tid, queue) } }
      threads.each(&:join)

      # puts "No element left message!"
    }
  end

  # turns lines into thread safe queue 
  def products_to_queue
      -> products { products.inject(Queue.new) { |q, param| q<<param }}
  end

  # monitor
  def monitor_thread
    -> queue {
      return false if @monitoring_time <= 0
      
      while queue.size > 0
        @monitoring_time.times { 
          if queue.size <= 0
            break
          end
          sleep 1
        }
        # puts "#{queue.size} element left!" if queue.size > 0
      end
    }
  end
end