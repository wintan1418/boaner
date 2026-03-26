ActiveAdmin.register Subscriber do
  actions :index, :show, :destroy

  index do
    selectable_column
    id_column
    column :email
    column :confirmed
    column :subscribed_at
    actions
  end

  filter :email
  filter :confirmed
  filter :subscribed_at

  action_item :export_csv, only: :index do
    link_to "Export CSV", admin_subscribers_path(format: :csv)
  end

  csv do
    column :email
    column :confirmed
    column :subscribed_at
  end
end
