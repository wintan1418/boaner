ActiveAdmin.register Comment, as: "UserComment" do
  permit_params :approved

  scope :all
  scope :pending, default: true
  scope :approved

  index do
    selectable_column
    id_column
    column :name
    column :body do |comment|
      truncate(comment.body, length: 80)
    end
    column :commentable_type
    column :approved
    column :created_at
    actions defaults: true do |comment|
      if !comment.approved?
        link_to "Approve", approve_admin_user_comment_path(comment), method: :put, class: "member_link"
      end
    end
  end

  member_action :approve, method: :put do
    resource.update!(approved: true)
    redirect_to admin_user_comments_path, notice: "Comment approved!"
  end

  filter :name
  filter :commentable_type
  filter :approved
  filter :created_at

  form do |f|
    f.inputs do
      f.input :approved
    end
    f.actions
  end
end
