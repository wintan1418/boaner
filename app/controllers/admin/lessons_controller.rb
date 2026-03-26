module Admin
  class LessonsController < BaseController
    before_action :set_course
    before_action :set_lesson, only: [ :show, :edit, :update, :destroy ]

    def show
      redirect_to edit_admin_course_lesson_path(@course, @lesson)
    end

    def new
      @lesson = @course.lessons.build
    end

    def create
      @lesson = @course.lessons.build(lesson_params)
      if @lesson.save
        redirect_to edit_admin_course_path(@course), notice: "Lesson created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @lesson.update(lesson_params)
        redirect_to edit_admin_course_path(@course), notice: "Lesson updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @lesson.destroy
      redirect_to edit_admin_course_path(@course), notice: "Lesson deleted."
    end

    private

    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_lesson
      @lesson = @course.lessons.find(params[:id])
    end

    def lesson_params
      params.require(:lesson).permit(:title, :body, :position, :free_preview)
    end
  end
end
