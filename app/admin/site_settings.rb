ActiveAdmin.register SiteSetting do
  menu label: "Site Settings", priority: 1
  actions :index, :edit, :update

  permit_params :site_name, :tagline, :hero_heading, :hero_subheading,
                :bio_short, :bio_long,
                :youtube_url, :twitter_url, :instagram_url, :linkedin_url,
                :email, :profile_image, :hero_background

  controller do
    def index
      redirect_to edit_admin_site_setting_path(SiteSetting.instance)
    end
  end

  form title: "Site Settings" do |f|
    tabs do
      tab "Branding" do
        f.inputs do
          f.input :site_name, hint: "Your site/brand name"
          f.input :tagline, hint: "Shown below your name"
          f.input :profile_image, as: :file, hint: f.object.profile_image.attached? ? "Current: #{f.object.profile_image.filename}" : "Upload your profile photo"
        end
      end

      tab "Hero Section" do
        f.inputs do
          f.input :hero_heading, as: :text, hint: "HTML allowed. Use <em> for emphasis."
          f.input :hero_subheading, as: :text, hint: "The paragraph below the heading"
          f.input :hero_background, as: :file, hint: f.object.hero_background.attached? ? "Current: #{f.object.hero_background.filename}" : "Optional background image for the hero"
        end
      end

      tab "About / Bio" do
        f.inputs do
          f.input :bio_short, as: :text, hint: "Short bio for homepage and cards"
          f.input :bio_long, as: :text, hint: "Full bio for the About page"
        end
      end

      tab "Social & Contact" do
        f.inputs do
          f.input :email, hint: "Contact email"
          f.input :youtube_url, hint: "e.g. https://youtube.com/@yourchannel"
          f.input :twitter_url, hint: "e.g. https://twitter.com/yourhandle"
          f.input :instagram_url, hint: "e.g. https://instagram.com/yourhandle"
          f.input :linkedin_url, hint: "e.g. https://linkedin.com/in/yourprofile"
        end
      end
    end

    f.actions
  end
end
