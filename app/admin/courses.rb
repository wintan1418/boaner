ActiveAdmin.register Course do
  permit_params :title, :description, :slug, :published

  index do
    selectable_column
    id_column
    column :title
    column :slug
    column :published
    column "Lessons" do |course|
      course.lessons.count
    end
    actions
  end

  filter :title
  filter :published

  form do |f|
    f.inputs do
      f.input :title
      f.input :slug, hint: "URL-friendly identifier (auto-generated if blank)"
      f.input :description
      f.input :published
    end
    f.actions
  end
end
