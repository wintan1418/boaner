ActiveAdmin.register Post do
  permit_params :title, :slug, :excerpt, :category, :published_at, :featured, :body

  index do
    selectable_column
    id_column
    column :title
    column :slug
    column :category
    column :featured
    column :published_at
    actions
  end

  filter :title
  filter :category
  filter :featured
  filter :published_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :slug, hint: "URL-friendly identifier (auto-generated if blank)"
      f.input :excerpt
      f.input :category, as: :select, collection: ["Story", "Essay", "Opinion"]
      f.input :published_at, as: :datepicker
      f.input :featured
      f.input :body, as: :rich_text_area
    end
    f.actions
  end
end
