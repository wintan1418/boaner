module Admin
  class CoursesController < BaseController
    before_action :set_course, only: [ :show, :edit, :update, :destroy ]

    def index
      @courses = Course.order(created_at: :desc)
    end

    def show
      redirect_to edit_admin_course_path(@course)
    end

    def new
      @course = Course.new
    end

    def create
      @course = Course.new(course_params)
      if @course.save
        redirect_to admin_courses_path, notice: "Course created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @course.update(course_params)
        redirect_to admin_courses_path, notice: "Course updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @course.destroy
      redirect_to admin_courses_path, notice: "Course deleted."
    end

    private

    def set_course
      @course = Course.find_by(slug: params[:id]) || Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:title, :description, :slug, :published)
    end
  end
end
