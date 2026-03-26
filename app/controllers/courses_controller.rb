class CoursesController < ApplicationController
  def index
    @courses = Course.published.includes(:lessons)
  end

  def show
    @course = Course.find_by!(slug: params[:id])
    @lessons = @course.lessons
  end
end
