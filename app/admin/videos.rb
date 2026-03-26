ActiveAdmin.register Video do
  permit_params :title, :youtube_id, :description, :category, :published_at, :featured

  index do
    selectable_column
    id_column
    column :title
    column :youtube_id
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
      f.input :youtube_id, hint: "11-character YouTube video ID"
      f.input :description
      f.input :category, as: :select, collection: ["Story", "Lecture", "Vlog"]
      f.input :published_at, as: :datepicker
      f.input :featured
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :youtube_id
      row :description
      row :category
      row :featured
      row :published_at
      row "Thumbnail" do |video|
        image_tag video.thumbnail_url, style: "max-width: 300px"
      end
    end
  end
end
