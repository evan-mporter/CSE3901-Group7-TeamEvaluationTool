class EvaluationsController < ApplicationController
  before_action :set_props

  def landing
  end

  def single
    @feedback_item = nil # TODO!
  end

  def done
  end

  private
    class FakeGroup
      attr_reader :name
      attr_reader :students
      def initialize num
        @name = "Group #{num}"
        @students = [
          Student.new(name: "John Doe"),
          Student.new(name: "Alice Doe"),
          Student.new(name: "Foo Bar"),
        ]
      end
    end

    class FakeProject
      attr_reader :name
      def initialize num
        @name = "Project #{num}"
      end
    end

    def set_props
      # TODO
      @group = FakeGroup.new params[:group]
      @project = FakeProject.new params[:project]
      @target = @group.students[params[:member].to_i] unless params[:member].nil?
    end
end
