require "test_helper"

class ActiveJob::QueuesTest < ActiveSupport::TestCase
  test "enumerable methods" do
    queues_list = 10.times.collect { |index| create_queue "queue_#{index}" }
    queues = ActiveJob::Queues.new(queues_list)

    assert_equal queues_list, queues.to_a
    assert_equal 10, queues.count
  end

  test "direct access by name" do
    queue_1 = create_queue "queue_1"
    queue_2 = create_queue "queue_2"
    queues = ActiveJob::Queues.new([ queue_1, queue_2 ])

    assert_equal queue_1, queues[:queue_1]
    assert_equal queue_2, queues["queue_2"]
  end

  test "convert to hash" do
    queue_1 = create_queue "queue_1"
    queue_2 = create_queue "queue_2"
    queues = ActiveJob::Queues.new([ queue_1, queue_2 ])

    expected_hash = { "queue_1" => queue_1, "queue_2" => queue_2 }
    assert_equal expected_hash, queues.to_h
  end

  private
    def create_queue(name)
      ActiveJob::Queue.new(name)
    end
end
