ActiveAdmin.register Lesson do
  permit_params :title, :body, :position, :free_preview, :course_id

  index do
    selectable_column
    id_column
    column :title
    column :course
    column :position
    column :free_preview
    actions
  end

  filter :course
  filter :free_preview

  form do |f|
    f.inputs do
      f.input :course
      f.input :title
      f.input :position
      f.input :free_preview
      f.input :body, as: :rich_text_area
    end
    f.actions
  end
end
