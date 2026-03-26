ActiveAdmin.register Book do
  permit_params :title, :description, :cover_image, :buy_url, :published_year, :cover

  index do
    selectable_column
    id_column
    column :title
    column :published_year
    column :buy_url
    actions
  end

  filter :title
  filter :published_year

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :published_year
      f.input :buy_url, hint: "External purchase link (e.g. Amazon)"
      f.input :cover, as: :file, hint: "Small cover image (< 200KB)"
    end
    f.actions
  end
end
