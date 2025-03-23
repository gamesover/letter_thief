require "test_helper"

module LetterThief
  class EmailSearchTest < ActiveSupport::TestCase
    setup do
      EmailMessage.delete_all

      @t1 = EmailMessage.create!(
        from: ["alice@example.com"],
        to: ["bob@example.com"],
        subject: "Important news",
        intercepted_at: Time.utc(2024, 1, 1, 10)
      )

      @t2 = EmailMessage.create!(
        from: ["carol@example.com"],
        to: ["dave@example.com"],
        subject: "Weekly update",
        intercepted_at: Time.utc(2024, 1, 2, 12)
      )

      @t3 = EmailMessage.create!(
        from: ["eve@example.com"],
        to: ["frank@example.com"],
        subject: "Party invitation",
        intercepted_at: Time.utc(2024, 1, 3, 15)
      )
    end

    test "filters by subject" do
      result = EmailSearch.new(query: "weekly").perform
      assert_equal [@t2], result.results
    end

    test "filters by from address" do
      result = EmailSearch.new(query: "alice").perform
      assert_equal [@t1], result.results
    end

    test "filters by start_time" do
      result = EmailSearch.new(start_time: "2024-01-02T00:00:00Z").perform
      assert_equal [@t3, @t2], result.results
    end

    test "filters by end_time" do
      result = EmailSearch.new(end_time: "2024-01-02T23:59:59Z").perform
      assert_equal [@t2, @t1], result.results
    end

    test "pagination returns first page only" do
      25.times do |i|
        EmailMessage.create!(
          from: ["x#{i}@test.com"],
          to: ["y@test.com"],
          subject: "Test #{i}",
          intercepted_at: Time.now + i
        )
      end

      result = EmailSearch.new(page: 1).perform
      assert_equal 20, result.results.size
      assert result.has_next_page
    end

    test "pagination returns second page" do
      25.times do |i|
        EmailMessage.create!(
          from: ["x#{i}@test.com"],
          to: ["y@test.com"],
          subject: "Test #{i}",
          intercepted_at: Time.now + i
        )
      end

      result = EmailSearch.new(page: 2).perform
      assert_operator result.results.size, :<=, 20
    end
  end
end
